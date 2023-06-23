
# Fix XSTR outputs (#396)

## Setup

``` r
library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
library(stringr)

options(readr.show_col_types = FALSE)
```

## Data

``` r
pstr_companies <- params$import_pstr_companies |> 
  # Avoid parsing problems
  read_csv(col_select = -company_name)

xstr_product_level <- read_csv(params$import_product_level)
xstr_product_level |> glimpse()
#> Rows: 1,832,962
#> Columns: 10
#> $ companies_id               <chr> "%ef%bb%bfmathias-maschinenhandel-laserserv…
#> $ grouped_by                 <chr> "ipr_1.5c rps_2030", "ipr_1.5c rps_2050", "…
#> $ risk_category              <chr> "high", "high", NA, NA, NA, NA, NA, NA, NA,…
#> $ clustered                  <chr> NA, NA, "fish, deep-frozen", "fish, deep-fr…
#> $ activity_uuid_product_uuid <chr> NA, NA, "26104519-4d49-5d85-bc74-e8e03d1a79…
#> $ tilt_sector                <chr> "steel and metals", "steel and metals", NA,…
#> $ scenario                   <chr> "1.5c rps", "1.5c rps", NA, NA, NA, NA, NA,…
#> $ year                       <dbl> 2030, 2050, NA, NA, NA, NA, NA, NA, NA, NA,…
#> $ type                       <chr> "ipr", "ipr", "ipr", "weo", "ipr", "weo", "…
#> $ tilt_subsector             <chr> "steel", "steel", NA, NA, NA, NA, NA, NA, N…

xstr_company_level <- read_csv(params$import_company_level)
xstr_company_level |> glimpse()
#> Rows: 3,401,364
#> Columns: 6
#> $ companies_id  <chr> "%ef%bb%bfmathias-maschinenhandel-laserservice_000000050…
#> $ type          <chr> "ipr", "ipr", "ipr", "ipr", "ipr", "ipr", "ipr", "ipr", …
#> $ scenario      <chr> "1.5c rps", "1.5c rps", "1.5c rps", "1.5c rps", "1.5c rp…
#> $ year          <dbl> 2030, 2030, 2030, 2050, 2050, 2050, NA, NA, NA, NA, NA, …
#> $ risk_category <chr> "high", "medium", "low", "high", "medium", "low", "high"…
#> $ value         <dbl> 1, 0, 0, 1, 0, 0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
```

## Helpers

``` r
if_all_na_is_first_else_not_na <- function(x) {
  if (all(is.na(x))) is_first(x) else !is.na(x)
}

is_first <- function(x) {
  seq_along(x) == 1L
}
```

## Fix

### At product level, remove bad output

- <https://github.com/2DegreesInvesting/tiltIndicator/issues/391>
- <https://github.com/2DegreesInvesting/tiltIndicator/pull/431>

Expect either 4 or 2.

``` r
unique(count(xstr_product_level, companies_id, clustered)$n)
#> [1] 2 4 6
```

Fix.

``` r
# The bad output resulted from duplicated data in the weo scenario
bad_391 <- xstr_product_level |>
  filter(
    type == "weo",
    # Exclude weo_flow = "energy" & weo_product = "total energy supply"
    tilt_sector == "energy",
    tilt_subsector == "total energy",
    # Exclude the one that has low risk (because emission capture)
    risk_category == "low",
  )
bad_391
#> # A tibble: 1,810 × 10
#>    companies_id        grouped_by risk_category clustered activity_uuid_produc…¹
#>    <chr>               <chr>      <chr>         <chr>     <chr>                 
#>  1 1a-autoservice-wol… weo_nz 20… low           petroleu… 4438999c-7021-5448-80…
#>  2 1a-autoservice-wol… weo_nz 20… low           petroleu… 4438999c-7021-5448-80…
#>  3 1a-baloonide_00000… weo_nz 20… low           petroleu… 4438999c-7021-5448-80…
#>  4 1a-baloonide_00000… weo_nz 20… low           petroleu… 4438999c-7021-5448-80…
#>  5 aceitunas-jope_000… weo_nz 20… low           oilve pit 4438999c-7021-5448-80…
#>  6 aceitunas-jope_000… weo_nz 20… low           oilve pit 4438999c-7021-5448-80…
#>  7 zugel-gmbh-co-kg_0… weo_nz 20… low           petroleu… 4438999c-7021-5448-80…
#>  8 zugel-gmbh-co-kg_0… weo_nz 20… low           petroleu… 4438999c-7021-5448-80…
#>  9 zwickl-mineralolve… weo_nz 20… low           petroleu… 4438999c-7021-5448-80…
#> 10 zwickl-mineralolve… weo_nz 20… low           petroleu… 4438999c-7021-5448-80…
#> # ℹ 1,800 more rows
#> # ℹ abbreviated name: ¹​activity_uuid_product_uuid
#> # ℹ 5 more variables: tilt_sector <chr>, scenario <chr>, year <dbl>,
#> #   type <chr>, tilt_subsector <chr>

xstr_product_level2 <- anti_join(xstr_product_level, bad_391)
#> Joining with `by = join_by(companies_id, grouped_by, risk_category, clustered,
#> activity_uuid_product_uuid, tilt_sector, scenario, year, type, tilt_subsector)`
xstr_product_level2
#> # A tibble: 1,831,152 × 10
#>    companies_id        grouped_by risk_category clustered activity_uuid_produc…¹
#>    <chr>               <chr>      <chr>         <chr>     <chr>                 
#>  1 %ef%bb%bfmathias-m… ipr_1.5c … high          <NA>      <NA>                  
#>  2 %ef%bb%bfmathias-m… ipr_1.5c … high          <NA>      <NA>                  
#>  3 -fred-sl_000000054… ipr_NA_NA  <NA>          fish, de… 26104519-4d49-5d85-bc…
#>  4 -fred-sl_000000054… weo_NA_NA  <NA>          fish, de… 26104519-4d49-5d85-bc…
#>  5 -fred-sl_000000054… ipr_NA_NA  <NA>          fish, fr… 0fe31e67-346a-504c-a0…
#>  6 -fred-sl_000000054… weo_NA_NA  <NA>          fish, fr… 0fe31e67-346a-504c-a0…
#>  7 -fred-sl_000000054… ipr_NA_NA  <NA>          fish, de… 26104519-4d49-5d85-bc…
#>  8 -fred-sl_000000054… weo_NA_NA  <NA>          fish, de… 26104519-4d49-5d85-bc…
#>  9 -fred-sl_000000054… ipr_NA_NA  <NA>          fish, fr… 0fe31e67-346a-504c-a0…
#> 10 -fred-sl_000000054… weo_NA_NA  <NA>          fish, fr… 0fe31e67-346a-504c-a0…
#> # ℹ 1,831,142 more rows
#> # ℹ abbreviated name: ¹​activity_uuid_product_uuid
#> # ℹ 5 more variables: tilt_sector <chr>, scenario <chr>, year <dbl>,
#> #   type <chr>, tilt_subsector <chr>
```

Test.

``` r
unique(count(xstr_product_level2, companies_id, clustered)$n)
#> [1] 2 4
```

### At both levels, remove duplicated rows

- <https://github.com/2DegreesInvesting/tiltIndicator/issues/392>
- <https://github.com/2DegreesInvesting/tiltIndicator/pull/438>

``` r
anyDuplicated(xstr_product_level2)
#> [1] 7

anyDuplicated(xstr_company_level)
#> [1] 13
```

Fix.

``` r
xstr_product_level3 <- distinct(xstr_product_level2)
nrow(xstr_product_level2)
#> [1] 1831152
nrow(xstr_product_level3)
#> [1] 1655052

xstr_company_level2 <- distinct(xstr_company_level)
nrow(xstr_company_level)
#> [1] 3401364
nrow(xstr_company_level2)
#> [1] 2752110
```

Test.

``` r
anyDuplicated(xstr_product_level3)
#> [1] 0

anyDuplicated(xstr_company_level2)
#> [1] 0
```

Note this step makes product-level data to no longer have only 4 or 2
rows per company per product – as we expected before.

``` r
unique(count(xstr_product_level2, companies_id, clustered)$n)
#> [1] 2 4

unique(count(xstr_product_level3, companies_id, clustered)$n)
#> [1] 2 3 4 1
```

### At company level, remove needless rows with missing values

- <https://github.com/2DegreesInvesting/tiltIndicator/issues/393>
- <https://github.com/2DegreesInvesting/tiltIndicator/pull/434>

Expect either 12, 6, or 1.

``` r
unique(count(xstr_company_level2, companies_id)$n)
#> [1]  6  9 12  3 15 18
```

Fix.

``` r
# Rows where `value` is not `NA` from companies with at least one such `value`
filtered_complete_data <- xstr_company_level2 |>
  group_by(companies_id) |>
  # Drop companies where all `value` is `NA`
  filter(!all(is.na(value))) |>
  # Drop rows where `value` is `NA`
  filter(!is.na(value)) |>
  ungroup()

# In companies where all `value` is `NA`, make `type` & `risk_category` also `NA`
filtered_incomplete_data <- xstr_company_level2 |>
  group_by(companies_id) |>
  # Where all `value` is `NA` ...
  filter(all(is.na(value))) |>
  # ... pick the first row and ...
  slice(1) |>
  # ... make `type` and `risk_category` also `NA`
  mutate(type = NA_character_, risk_category = NA_character_) |>
  ungroup()

xstr_company_level3 <- bind_rows(filtered_complete_data, filtered_incomplete_data)
```

Test.

``` r
unique(count(xstr_company_level3, companies_id)$n)
#> [1]  6  1 12
```

### At product level, each company should have 1, 2, or 4 rows per product

- <https://github.com/2DegreesInvesting/tiltIndicator/issues/402>
- <https://github.com/2DegreesInvesting/tiltIndicator/pull/436>

Expect 1, 2, or 4.

``` r
xstr_product_level3 |> 
  count(companies_id, clustered) |> 
  count(n)
#> Storing counts in `nn`, as `n` already present in input
#> ℹ Use `name = "new_name"` to pick a new name.
#> # A tibble: 4 × 2
#>       n     nn
#>   <int>  <int>
#> 1     1  66658
#> 2     2 173725
#> 3     3  76332
#> 4     4 252987
```

Fix

``` r
xstr_product_level4 <- xstr_product_level3 |> 
  filter(
    if_all_na_is_first_else_not_na(.data$risk_category), 
    .by = c("companies_id", "clustered")
  )
```

Test.

``` r
xstr_product_level4 |> 
  count(companies_id, clustered) |> 
  count(n)
#> Storing counts in `nn`, as `n` already present in input
#> ℹ Use `name = "new_name"` to pick a new name.
#> # A tibble: 3 × 2
#>       n     nn
#>   <int>  <int>
#> 1     1  83213
#> 2     2 233502
#> 3     4 252987

# The companies with only 1 row should all have missing `risk_category`
sum(is.na(xstr_product_level4$risk_category))
#> [1] 83213
```

### At company level, remove `companies_id` with “;” in either of the relevant columns in `pstr_companies`

- <https://github.com/2DegreesInvesting/tiltIndicator/issues/405>
- <https://github.com/2DegreesInvesting/tiltIndicator/issues/439>

``` r
semicolon <- pstr_companies |> 
  select(-starts_with("tilt_")) |> 
  filter(if_any(ends_with("sector"), ~ str_detect(.x, ";")))

# Note ";"
select(semicolon, ends_with("sector"))
#> # A tibble: 48,811 × 4
#>    ipr_sector             ipr_subsector                 weo_sector weo_subsector
#>    <chr>                  <chr>                         <chr>      <chr>        
#>  1 buildings              <NA>                          total      residential;…
#>  2 transport              trucks; other transport       total      road heavy d…
#>  3 buildings              land use                      total; no… buildings; n…
#>  4 industry; total; power iron and steel; energy        total; na… iron and ste…
#>  5 industry               other industry; iron and ste… total      industry; ir…
#>  6 buildings; transport   other transport               total      buildings; t…
#>  7 buildings              <NA>                          total      buildings; r…
#>  8 buildings              land use                      total; no… buildings; r…
#>  9 transport              other transport; cars         total      transport; r…
#> 10 transport              trucks; other transport       total      road heavy d…
#> # ℹ 48,801 more rows

# Affected companies
distinct(semicolon, companies_id)
#> # A tibble: 48,486 × 1
#>    companies_id                                                                 
#>    <chr>                                                                        
#>  1 040-elektricien_00000005335951-634140001                                     
#>  2 1-2-3-autoservice-gmbh_00000004895557-001                                    
#>  3 1-a-arbeitsbuhnen-baumaschinen-stapler-u-kran-vermietung-beyer-mietservice_0…
#>  4 1-blechdesign-bauspenglerei-haslinger-harald-eu_00000005229852-001           
#>  5 1-iso-giesstechnik-maik-straile-ek_00000004818898-001                        
#>  6 123-abflussfrei-gmbh_00000004883869-001                                      
#>  7 123-carrelage-lille_00000005467896-840021001                                 
#>  8 123-filter-gmbh_00000005275457-001                                           
#>  9 123carcamnl_00000004686127-486065001                                         
#> 10 123repair-deutschland_00000005109249-001                                     
#> # ℹ 48,476 more rows

# Remove affected companies
xstr_company_level4 <- xstr_company_level3 |> 
  anti_join(distinct(semicolon, companies_id))
#> Joining with `by = join_by(companies_id)`
```

Test.

``` r
# Compare
nrow(xstr_company_level3)
#> [1] 2373289
nrow(xstr_company_level4)
#> [1] 1940769

# All gone
inner_join(xstr_company_level4, semicolon)
#> Joining with `by = join_by(companies_id)`
#> # A tibble: 0 × 13
#> # ℹ 13 variables: companies_id <chr>, type <chr>, scenario <chr>, year <dbl>,
#> #   risk_category <chr>, value <dbl>, clustered <chr>,
#> #   activity_uuid_product_uuid <chr>, isic_4digit <chr>, ipr_sector <chr>,
#> #   ipr_subsector <chr>, weo_sector <chr>, weo_subsector <chr>
```

### At both levels, remove companies affected by duplicated scenario data

- <https://github.com/2DegreesInvesting/tiltIndicator/issues/403>
- <https://github.com/2DegreesInvesting/tiltIndicator/issues/391>

``` r
# Affected companies
ids_391 <- distinct(bad_391, companies_id)
ids_391
#> # A tibble: 902 × 1
#>    companies_id                                              
#>    <chr>                                                     
#>  1 1a-autoservice-wolfgang-meschede_00000004940450-001       
#>  2 1a-baloonide_00000004972901-001                           
#>  3 aceitunas-jope_00000003986658-001                         
#>  4 zugel-gmbh-co-kg_00000005078611-001                       
#>  5 zwickl-mineralolvetriebs-gmbh_00000005039177-001          
#>  6 bama-mineralolkontor-gmbh-co-kg_deu058222-00101           
#>  7 barmeier-holzhandel-inh-manuel-barmeier_00000005072363-001
#>  8 barriquand-technologies-thermiques_fra310535-00101        
#>  9 batra-sl_esp030231-00101                                  
#> 10 bau-brennstoffe-bender_00000004966624-001                 
#> # ℹ 892 more rows

xstr_product_level5 <- xstr_product_level4 |> anti_join(ids_391)
#> Joining with `by = join_by(companies_id)`
xstr_company_level5 <- xstr_company_level4 |> anti_join(ids_391)
#> Joining with `by = join_by(companies_id)`
```

Test.

``` r
# Compare
nrow(xstr_product_level4)
#> [1] 1562165
nrow(xstr_product_level5)
#> [1] 1548430

# Gone
inner_join(xstr_product_level5, ids_391)
#> Joining with `by = join_by(companies_id)`
#> # A tibble: 0 × 10
#> # ℹ 10 variables: companies_id <chr>, grouped_by <chr>, risk_category <chr>,
#> #   clustered <chr>, activity_uuid_product_uuid <chr>, tilt_sector <chr>,
#> #   scenario <chr>, year <dbl>, type <chr>, tilt_subsector <chr>

# Compare
nrow(xstr_company_level4)
#> [1] 1940769
nrow(xstr_company_level5)
#> [1] 1933701

# Gone
inner_join(xstr_company_level5, ids_391)
#> Joining with `by = join_by(companies_id)`
#> # A tibble: 0 × 6
#> # ℹ 6 variables: companies_id <chr>, type <chr>, scenario <chr>, year <dbl>,
#> #   risk_category <chr>, value <dbl>
```

## Export

``` r
write_csv(xstr_product_level5, params$export_product_level)
write_csv(xstr_company_level5, params$export_company_level)
```
