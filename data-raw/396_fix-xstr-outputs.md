
# Fix XSTR outputs (#396)

Closes \#396 by applying on the output what \#391, \#392, and \#393
should have done on the code.

## Setup

``` r
library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)

options(readr.show_col_types = FALSE)
```

## Data

``` r
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

## Fix

### At product level, remove bad output

<https://github.com/2DegreesInvesting/tiltIndicator/issues/391>

Expect either 4 or 2.

``` r
unique(count(xstr_product_level, companies_id, clustered)$n)
#> [1] 2 4 6
```

Fix.

``` r
# The bad output resulted from duplicated data in the weo scenario
bad <- xstr_product_level |>
  filter(
    type == "weo",
    # Exclude weo_flow = "energy" & weo_product = "total energy supply"
    tilt_sector == "energy",
    tilt_subsector == "total energy",
    # Exclude the one that has low risk (because emission capture)
    risk_category == "low",
  )
bad
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

xstr_product_level2 <- anti_join(xstr_product_level, bad)
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

<https://github.com/2DegreesInvesting/tiltIndicator/issues/392>

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

<https://github.com/2DegreesInvesting/tiltIndicator/issues/393>

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

## Export

``` r
write_csv(xstr_product_level3, params$export_product_level)
write_csv(xstr_company_level3, params$export_company_level)
```
