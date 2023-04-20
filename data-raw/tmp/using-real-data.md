Using real data
================

This article uses the tiltIndicator package with real data as described
in [this
issue](https://github.com/2DegreesInvesting/tiltIndicator/issues/160).

``` r
library(dplyr, warn.conflicts = FALSE)
library(readr)
library(fs)
library(tiltIndicator)

packageVersion("tiltIndicator")
#> [1] '0.0.0.9022'

options(readr.show_col_types = FALSE)
```

> All data for pstr and pctr are in the folder “pstr_pctr_data”.

``` r
# Help access the data
data_path <- function(...) {
  path_home("Downloads", "data_prep_v1", "pstr_pctr_data", ...)
}
```

> Only consider those that start with pstr\_ or pctr\_.

``` r
to_consider <- "pstr_|pctr_"
all_files <- dir_ls(data_path())
useful_files <- all_files[grepl(to_consider, path_file(all_files))]

path_file(useful_files)
#> [1] "pctr_companies.csv"     "pctr_ecoinvent_co2.csv" "pstr_companies.csv"    
#> [4] "pstr_ipr_2022.csv"      "pstr_weo_2022.csv"
```

Read the useful file into a list of `real` data.

``` r
real <- lapply(useful_files, read_csv) |>
  setNames(path_ext_remove(path_file(useful_files)))

real
#> $pctr_companies
#> # A tibble: 8 × 4
#>   company_id                             activity_product_uuid ei_activity unit 
#>   <chr>                                  <chr>                 <chr>       <chr>
#> 1 lusitania-food_00000004012865-4035090… a6478da4-5cd6-5c9e-a… market for… kg   
#> 2 queso-quintana_00000005400093-7292290… 6e2f5d7d-37d0-5548-a… cheese pro… kg   
#> 3 quesos-finca-la-cruz_00000004641972-0… 6e2f5d7d-37d0-5548-a… cheese pro… kg   
#> 4 manz-backtechnik-gmbh_deu087356-00101  063e488f-803a-5d13-a… cookstove … unit 
#> 5 manz-backtechnik-gmbh_deu087356-00101  61d00580-6742-5050-9… microwave … unit 
#> 6 breuninger-leder-gmbh_00000005064318-… 03fbf989-9a1a-5e3d-a… seal produ… kg   
#> 7 kurt-schmidt_00000004941462-001        011da854-af42-5570-a… market for… kg   
#> 8 barham-metall-gmbh_00000005371632-683… 0faa7ecb-fef2-5117-8… market for… kg   
#> 
#> $pctr_ecoinvent_co2
#> # A tibble: 8 × 5
#>   co2_footprint   sec unit  activity_product_uuid                    ei_activity
#>           <dbl> <dbl> <chr> <chr>                                    <chr>      
#> 1         12.5   1050 kg    a6478da4-5cd6-5c9e-a00b-14148d44aad9_e3… market for…
#> 2         12.5   1050 kg    6e2f5d7d-37d0-5548-a38c-1533a9c76075_e3… cheese pro…
#> 3         12.5   1050 kg    6e2f5d7d-37d0-5548-a38c-1533a9c76075_e3… cheese pro…
#> 4        176.    2750 unit  063e488f-803a-5d13-af19-852d6070f35c_cf… cookstove …
#> 5         58.1   2750 unit  61d00580-6742-5050-91ec-7eba6fd63e90_a9… microwave …
#> 6          1.98  2029 kg    03fbf989-9a1a-5e3d-a5bd-15f4cd20abbc_13… seal produ…
#> 7          2.07  2029 kg    011da854-af42-5570-a442-de88ba590506_13… market for…
#> 8          4.95  2410 kg    0faa7ecb-fef2-5117-8993-387c1898ffc8_c3… market for…
#> 
#> $pstr_companies
#> # A tibble: 17 × 14
#>    company_id       company_name products isic_4digit tilt_sector tilt_subsector
#>    <chr>            <chr>        <chr>          <dbl> <chr>       <chr>         
#>  1 cta-commodity-t… cta - commo… <NA>              NA Energy      Bioenergy & W…
#>  2 cbrit_000000052… cbr-it       <NA>              NA Energy      Bioenergy & W…
#>  3 manz-backtechni… manz backte… 063e488…        2750 <NA>        <NA>          
#>  4 manz-backtechni… manz backte… 61d0058…        2750 <NA>        <NA>          
#>  5 manz-backtechni… manz backte… 063e488…        2750 <NA>        <NA>          
#>  6 manz-backtechni… manz backte… 61d0058…        2750 <NA>        <NA>          
#>  7 barham-metall-g… barham meta… 0faa7ec…        2410 <NA>        <NA>          
#>  8 cta-commodity-t… cta - commo… <NA>              NA Transporta… Transportation
#>  9 cbrit_000000052… cbr-it       <NA>              NA Transporta… Transportation
#> 10 queso-quintana_… queso quint… 6e2f5d7…        1050 <NA>        <NA>          
#> 11 quesos-finca-la… quesos finc… 6e2f5d7…        1050 <NA>        <NA>          
#> 12 lusitania-food_… lusitania f… a6478da…        1050 <NA>        <NA>          
#> 13 lusitania-food_… lusitania f… a6478da…        1050 <NA>        <NA>          
#> 14 cbrit_000000052… cbr-it       <NA>              NA Constructi… Construction …
#> 15 cta-commodity-t… cta - commo… <NA>              NA Constructi… Construction …
#> 16 kurt-schmidt_00… kurt schmidt 011da85…        2029 <NA>        <NA>          
#> 17 breuninger-lede… breuninger … 03fbf98…        2029 <NA>        <NA>          
#> # ℹ 8 more variables: ipr_sector.x <chr>, ipr_subsector.x <chr>,
#> #   weo_product.x <chr>, weo_flow.x <chr>, ipr_sector.y <chr>,
#> #   ipr_subsector.y <chr>, weo_product.y <chr>, weo_flow.y <chr>
#> 
#> $pstr_ipr_2022
#> # A tibble: 112 × 7
#>    scenario          region ipr_sector ipr_subsector  year  value co2_reductions
#>    <chr>             <chr>  <chr>      <chr>         <dbl>  <dbl>          <dbl>
#>  1 1.5C Required Po… Weste… Power      <NA>           2020  550.           0    
#>  2 1.5C Required Po… Weste… Power      <NA>           2030   47.4          0.914
#>  3 1.5C Required Po… Weste… Power      <NA>           2040  -60.6          1.11 
#>  4 1.5C Required Po… Weste… Power      <NA>           2050 -175.           1.32 
#>  5 1.5C Required Po… Weste… Buildings  <NA>           2020  397.           0    
#>  6 1.5C Required Po… Weste… Buildings  <NA>           2030  189.           0.525
#>  7 1.5C Required Po… Weste… Buildings  <NA>           2040   13.1          0.967
#>  8 1.5C Required Po… Weste… Buildings  <NA>           2050    0            1    
#>  9 1.5C Required Po… Weste… Industry   Iron and Ste…  2020   70.2          0    
#> 10 1.5C Required Po… Weste… Industry   Iron and Ste…  2030   30.5          0.565
#> # ℹ 102 more rows
#> 
#> $pstr_weo_2022
#> # A tibble: 372 × 8
#>    publication  scenario region weo_product weo_flow  year  value co2_reductions
#>    <chr>        <chr>    <chr>  <chr>       <chr>    <dbl>  <dbl>          <dbl>
#>  1 World Energ… Stated … World  Total       Total e…  2020 31904          0     
#>  2 World Energ… Stated … World  Total       Total e…  2030 33135.        -0.0386
#>  3 World Energ… Stated … World  Total       Total e…  2040 30800.         0.0346
#>  4 World Energ… Stated … World  Total       Total e…  2050 28946.         0.0927
#>  5 World Energ… Stated … World  Coal        Total e…  2020 14335.         0     
#>  6 World Energ… Stated … World  Coal        Total e…  2030 13695          0.0447
#>  7 World Energ… Stated … World  Coal        Total e…  2040 11553.         0.194 
#>  8 World Energ… Stated … World  Coal        Total e…  2050  9863.         0.312 
#>  9 World Energ… Stated … World  Oil         Total e…  2020 10194.         0     
#> 10 World Energ… Stated … World  Oil         Total e…  2030 11412.        -0.119 
#> # ℹ 362 more rows
```

### PCTR

> The datasets `pctr_companies` and `pctr_ecoinvent_co2` are in the
> exact same format as in the mvp

``` r
glimpse(real$pctr_ecoinvent_co2)
#> Rows: 8
#> Columns: 5
#> $ co2_footprint         <dbl> 12.485806, 12.468865, 12.468865, 175.615479, 58.…
#> $ sec                   <dbl> 1050, 1050, 1050, 2750, 2750, 2029, 2029, 2410
#> $ unit                  <chr> "kg", "kg", "kg", "unit", "unit", "kg", "kg", "k…
#> $ activity_product_uuid <chr> "a6478da4-5cd6-5c9e-a00b-14148d44aad9_e35863ed-d…
#> $ ei_activity           <chr> "market for cheese, from cow milk, fresh, unripe…

glimpse(real$pctr_companies)
#> Rows: 8
#> Columns: 4
#> $ company_id            <chr> "lusitania-food_00000004012865-403509001", "ques…
#> $ activity_product_uuid <chr> "a6478da4-5cd6-5c9e-a00b-14148d44aad9_e35863ed-d…
#> $ ei_activity           <chr> "market for cheese, from cow milk, fresh, unripe…
#> $ unit                  <chr> "kg", "kg", "kg", "unit", "unit", "kg", "kg", "k…
```

Works smoothly.

``` r
pctr <- real$pctr_ecoinvent_co2 |>
  pctr_score_activities() |>
  pctr_score_companies(real$pctr_companies)

pctr
#> # A tibble: 21 × 5
#>    company_id                          score share_all share_unit share_unit_sec
#>    <chr>                               <chr>     <dbl>      <dbl>          <dbl>
#>  1 lusitania-food_00000004012865-4035… high          1        1              1  
#>  2 lusitania-food_00000004012865-4035… medi…         0        0              0  
#>  3 lusitania-food_00000004012865-4035… low           0        0              0  
#>  4 queso-quintana_00000005400093-7292… high          0        1              0  
#>  5 queso-quintana_00000005400093-7292… medi…         1        0              1  
#>  6 queso-quintana_00000005400093-7292… low           0        0              0  
#>  7 quesos-finca-la-cruz_0000000464197… high          0        1              0  
#>  8 quesos-finca-la-cruz_0000000464197… medi…         1        0              1  
#>  9 quesos-finca-la-cruz_0000000464197… low           0        0              0  
#> 10 manz-backtechnik-gmbh_deu087356-00… high          1        0.5            0.5
#> # ℹ 11 more rows
```

### PSTR

> The datasets for the pstr vary slightly as follows:

> `pstr_companies` already contains the matched scenario sectors.
> However, as you will see, there are 8 columns at the end containing
> scenario sectors.

``` r
glimpse(real$pstr_companies)
#> Rows: 17
#> Columns: 14
#> $ company_id      <chr> "cta-commodity-trading-austria-gmbh_00000005215384-001…
#> $ company_name    <chr> "cta - commodity trading austria gmbh", "cbr-it", "man…
#> $ products        <chr> NA, NA, "063e488f-803a-5d13-af19-852d6070f35c_cf47d9e8…
#> $ isic_4digit     <dbl> NA, NA, 2750, 2750, 2750, 2750, 2410, NA, NA, 1050, 10…
#> $ tilt_sector     <chr> "Energy", "Energy", NA, NA, NA, NA, NA, "Transportatio…
#> $ tilt_subsector  <chr> "Bioenergy & Waste", "Bioenergy & Waste", NA, NA, NA, …
#> $ ipr_sector.x    <chr> NA, NA, "Industry", "Industry", "Industry", "Industry"…
#> $ ipr_subsector.x <chr> NA, NA, "Other Industry", "Other Industry", "Other Ind…
#> $ weo_product.x   <chr> NA, NA, "Total", "Total", "Total", "Total", "Total", N…
#> $ weo_flow.x      <chr> NA, NA, "Industry", "Industry", "Industry", "Industry"…
#> $ ipr_sector.y    <chr> "Total", "Total", NA, NA, NA, NA, NA, "Transport", "Tr…
#> $ ipr_subsector.y <chr> "Energy", "Energy", NA, NA, NA, NA, NA, "Other Transpo…
#> $ weo_product.y   <chr> "Bioenergy and Waste", "Bioenergy and Waste", NA, NA, …
#> $ weo_flow.y      <chr> "Total Energy Supply", "Total Energy Supply", NA, NA, …
```

> It actually should only be 4.

Which four columns do you want to pick: `.x` or `.y`?

> Please include the values from the 4 columns .y into the 4 columns

``` r
remove_suffix <- function(x) gsub("[.].", "", x)
pstr_companies_y <- select(real$pstr_companies, -ends_with(".x")) |>
  rename_with(remove_suffix)
pstr_companies_y
#> # A tibble: 17 × 10
#>    company_id       company_name products isic_4digit tilt_sector tilt_subsector
#>    <chr>            <chr>        <chr>          <dbl> <chr>       <chr>         
#>  1 cta-commodity-t… cta - commo… <NA>              NA Energy      Bioenergy & W…
#>  2 cbrit_000000052… cbr-it       <NA>              NA Energy      Bioenergy & W…
#>  3 manz-backtechni… manz backte… 063e488…        2750 <NA>        <NA>          
#>  4 manz-backtechni… manz backte… 61d0058…        2750 <NA>        <NA>          
#>  5 manz-backtechni… manz backte… 063e488…        2750 <NA>        <NA>          
#>  6 manz-backtechni… manz backte… 61d0058…        2750 <NA>        <NA>          
#>  7 barham-metall-g… barham meta… 0faa7ec…        2410 <NA>        <NA>          
#>  8 cta-commodity-t… cta - commo… <NA>              NA Transporta… Transportation
#>  9 cbrit_000000052… cbr-it       <NA>              NA Transporta… Transportation
#> 10 queso-quintana_… queso quint… 6e2f5d7…        1050 <NA>        <NA>          
#> 11 quesos-finca-la… quesos finc… 6e2f5d7…        1050 <NA>        <NA>          
#> 12 lusitania-food_… lusitania f… a6478da…        1050 <NA>        <NA>          
#> 13 lusitania-food_… lusitania f… a6478da…        1050 <NA>        <NA>          
#> 14 cbrit_000000052… cbr-it       <NA>              NA Constructi… Construction …
#> 15 cta-commodity-t… cta - commo… <NA>              NA Constructi… Construction …
#> 16 kurt-schmidt_00… kurt schmidt 011da85…        2029 <NA>        <NA>          
#> 17 breuninger-lede… breuninger … 03fbf98…        2029 <NA>        <NA>          
#> # ℹ 4 more variables: ipr_sector <chr>, ipr_subsector <chr>, weo_product <chr>,
#> #   weo_flow <chr>
```

> I didn’t know how to “merge” them. If you know how to do that, please
> tell me.

Here is a tiny example that may help understand where the problem might
come from. To fully understand what’s going on, we may need to pick a
tiny bit of real data and explore similarly to what I do here:

``` r
x <- tibble(a = 1:2, b = 1, c = 1)
x
#> # A tibble: 2 × 3
#>       a     b     c
#>   <int> <dbl> <dbl>
#> 1     1     1     1
#> 2     2     1     1

y <- tibble(a = 2:3, b = 2)
y
#> # A tibble: 2 × 2
#>       a     b
#>   <int> <dbl>
#> 1     2     2
#> 2     3     2

# Joining by all shared columns
x |> left_join(y, by = join_by(a, b))
#> # A tibble: 2 × 3
#>       a     b     c
#>   <int> <dbl> <dbl>
#> 1     1     1     1
#> 2     2     1     1
# Same
x |> left_join(y)
#> Joining with `by = join_by(a, b)`
#> # A tibble: 2 × 3
#>       a     b     c
#>   <int> <dbl> <dbl>
#> 1     1     1     1
#> 2     2     1     1

# Joining only by some but not all of the shared columns
x |> left_join(y, by = "a")
#> # A tibble: 2 × 4
#>       a   b.x     c   b.y
#>   <int> <dbl> <dbl> <dbl>
#> 1     1     1     1    NA
#> 2     2     1     1     2

# Excluding from `y` the shared columns I don't want to join by
y2 <- y |> select(-b)
x |> left_join(y2, by = join_by(a))
#> # A tibble: 2 × 3
#>       a     b     c
#>   <int> <dbl> <dbl>
#> 1     1     1     1
#> 2     2     1     1
```

> `pstr_ipr_2022` and `pstr_weo_2022` replace `pstr_weo_2022`

``` r
# FIXME: Then I guess I need to join them. I don't know which rows we want to
# preserve so I'll conservatively preserve all rows but this may result in more
# rows than we need and in confusing data.
# There seems to be redundant data, as both datasets share most columns!
old_pstr_weo_2022 <- full_join(real$pstr_ipr_2022, real$pstr_weo_2022)
#> Joining with `by = join_by(scenario, region, year, value, co2_reductions)`
old_pstr_weo_2022 |> glimpse()
#> Rows: 484
#> Columns: 10
#> $ scenario       <chr> "1.5C Required Policy Scenario", "1.5C Required Policy …
#> $ region         <chr> "Western Europe (WEU)", "Western Europe (WEU)", "Wester…
#> $ ipr_sector     <chr> "Power", "Power", "Power", "Power", "Buildings", "Build…
#> $ ipr_subsector  <chr> NA, NA, NA, NA, NA, NA, NA, NA, "Iron and Steel", "Iron…
#> $ year           <dbl> 2020, 2030, 2040, 2050, 2020, 2030, 2040, 2050, 2020, 2…
#> $ value          <dbl> 550.4698707, 47.3894183, -60.5859092, -175.4472297, 397…
#> $ co2_reductions <dbl> 0.0000000, 0.9139110, 1.1100622, 1.3187227, 0.0000000, …
#> $ publication    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
#> $ weo_product    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
#> $ weo_flow       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
```

> `pstr_ep_weo` is not required anymore, as I already mapped the data
> directly into `pstr_companies`

Unfortunately this makes the data incompatible with the current
interface, as `pstr_ep_weo` is an obligatory argument of
`pstr_add_reductions()`.

In both `pstr_weo_2022` and `pstr_ipr_2022` I see a column
`co2_reductions`. So we would need to adapt `pstr_add_reductions()`.
Here is a draft:

``` r
pstr_add_reductions_new <- function(ipr, weo, companies) {
  # TODO: full_join() is conservative but likely not the best
  # TODO: Decide how to handle multiple matches
  reductions <- full_join(ipr, weo)
  left_join(companies, reductions)
}

companies <- pstr_companies_y
ipr <- real$pstr_ipr_2022
weo <- real$pstr_weo_2022

companies |>
  pstr_add_reductions_new(ipr, weo)
#> Joining with `by = join_by(ipr_sector, ipr_subsector)`
#> Warning in full_join(ipr, weo): Detected an unexpected many-to-many relationship between `x` and `y`.
#> ℹ Row 1 of `x` matches multiple rows in `y`.
#> ℹ Row 49 of `y` matches multiple rows in `x`.
#> ℹ If a many-to-many relationship is expected, set `relationship =
#>   "many-to-many"` to silence this warning.
#> Joining with `by = join_by(scenario, region, weo_product, weo_flow, year,
#> value, co2_reductions)`
#> # A tibble: 372 × 16
#>    publication  scenario region weo_product weo_flow  year  value co2_reductions
#>    <chr>        <chr>    <chr>  <chr>       <chr>    <dbl>  <dbl>          <dbl>
#>  1 World Energ… Stated … World  Total       Total e…  2020 31904          0     
#>  2 World Energ… Stated … World  Total       Total e…  2030 33135.        -0.0386
#>  3 World Energ… Stated … World  Total       Total e…  2040 30800.         0.0346
#>  4 World Energ… Stated … World  Total       Total e…  2050 28946.         0.0927
#>  5 World Energ… Stated … World  Coal        Total e…  2020 14335.         0     
#>  6 World Energ… Stated … World  Coal        Total e…  2030 13695          0.0447
#>  7 World Energ… Stated … World  Coal        Total e…  2040 11553.         0.194 
#>  8 World Energ… Stated … World  Coal        Total e…  2050  9863.         0.312 
#>  9 World Energ… Stated … World  Oil         Total e…  2020 10194.         0     
#> 10 World Energ… Stated … World  Oil         Total e…  2030 11412.        -0.119 
#> # ℹ 362 more rows
#> # ℹ 8 more variables: company_id <chr>, company_name <chr>, products <chr>,
#> #   isic_4digit <dbl>, tilt_sector <chr>, tilt_subsector <chr>,
#> #   ipr_sector <chr>, ipr_subsector <chr>
```

But the output is incompatible because `pstr_add_reductions()` knows
about a column called `reductions` but not the new column
`co2_reductions`.

``` r
companies |>
  pstr_add_reductions_new(ipr, weo) |>
  pstr_add_transition_risk()
#> Joining with `by = join_by(ipr_sector, ipr_subsector)`
#> Warning in full_join(ipr, weo): Detected an unexpected many-to-many relationship between `x` and `y`.
#> ℹ Row 1 of `x` matches multiple rows in `y`.
#> ℹ Row 49 of `y` matches multiple rows in `x`.
#> ℹ If a many-to-many relationship is expected, set `relationship =
#>   "many-to-many"` to silence this warning.
#> Joining with `by = join_by(scenario, region, weo_product, weo_flow, year,
#> value, co2_reductions)`
#> Error in `mutate()` at tiltIndicator/R/pstr_add_transition_risk.R:34:2:
#> ℹ In argument: `transition_risk = case_when(...)`.
#> Caused by error in `case_when()`:
#> ! Failed to evaluate the left-hand side of formula 1.
#> Caused by error:
#> ! object 'reductions' not found
```

So we would need to adapt `pstr_add_transition_risk()`.

``` r
pstr_add_transition_risk_new <- function(data) {
  data |>
    rename(reductions = co2_reductions) |>
    pstr_add_transition_risk()
}
```

With those changes the code runs without error.

``` r
companies |>
  pstr_add_reductions_new(ipr, weo) |>
  pstr_add_transition_risk_new() |>
  pstr_aggregate_scores(companies)
#> Joining with `by = join_by(ipr_sector, ipr_subsector)`
#> Warning in full_join(ipr, weo): Detected an unexpected many-to-many relationship between `x` and `y`.
#> ℹ Row 1 of `x` matches multiple rows in `y`.
#> ℹ Row 49 of `y` matches multiple rows in `x`.
#> ℹ If a many-to-many relationship is expected, set `relationship =
#>   "many-to-many"` to silence this warning.
#> Joining with `by = join_by(scenario, region, weo_product, weo_flow, year,
#> value, co2_reductions)`
#> # A tibble: 12 × 5
#> # Groups:   company_name, transition_risk, scenario, year [12]
#>    company_name transition_risk scenario                   year score_aggregated
#>    <chr>        <chr>           <chr>                     <dbl>            <dbl>
#>  1 <NA>         low             Announced Pledges Scenar…  2020               NA
#>  2 <NA>         low             Announced Pledges Scenar…  2030               NA
#>  3 <NA>         low             Announced Pledges Scenar…  2040               NA
#>  4 <NA>         low             Announced Pledges Scenar…  2050               NA
#>  5 <NA>         low             Net Zero Emissions by 20…  2020               NA
#>  6 <NA>         low             Net Zero Emissions by 20…  2030               NA
#>  7 <NA>         low             Net Zero Emissions by 20…  2040               NA
#>  8 <NA>         low             Net Zero Emissions by 20…  2050               NA
#>  9 <NA>         low             Stated Policies Scenario   2020               NA
#> 10 <NA>         low             Stated Policies Scenario   2030               NA
#> 11 <NA>         low             Stated Policies Scenario   2040               NA
#> 12 <NA>         low             Stated Policies Scenario   2050               NA
```

The result seems invalid.

> The dataset has `NA`s for all rows in `company_name`. This shouldn’t
> be the case. `score_aggregated` is also `NA`.

TODO: Peer-program with Tilman to develop a new version of the PSTR
functions that takes the new data structure.
