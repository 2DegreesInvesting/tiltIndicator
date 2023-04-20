Using real data
================

This article uses the tiltIndicator package with real data as described
in [this
issue](https://github.com/2DegreesInvesting/tiltIndicator/issues/160).

``` r
library(dplyr, warn.conflicts = FALSE)
library(tidyr)
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

### New functions

``` r
# R/pstr_add_reductions.R
pstr_add_reductions_new <- function(companies, scenario) {
  left_join(
    companies, scenario,
    by = join_by(type, sector, subsector),
    relationship = "many-to-many"
  )
}

# R/pstr_prepare_scenario.R
pstr_prepare_scenario <- function(ipr, weo) {
  bind_rows(
    pstr_prepare_scenario_impl(ipr, "ipr"), 
    pstr_prepare_scenario_impl(weo, "weo")
  )

}
pstr_prepare_scenario_impl <- function(data, type) {
  data |>
    lowercase_characters() |>
    rename_with(~ gsub(paste0(type, "_"), "", .x)) |>
    mutate(type = type) |>
    rename(reductions = co2_reductions)
}

# R/pstr_prepare_companies.R
pstr_prepare_companies <- function(data) {
  data |>
    merge_scenario_columns() |> 
    lowercase_characters() |>
    pivot_type_sector_subsector()
}

merge_scenario_columns <- function(data) {
  data |>
    mutate(ipr_sector = if_else(is.na(ipr_sector.y), ipr_sector.x, ipr_sector.y)) |>
    mutate(ipr_subsector = if_else(is.na(ipr_subsector.y), ipr_subsector.x, ipr_subsector.y)) |>
    mutate(weo_product = if_else(is.na(weo_product.y), weo_product.x, weo_product.y)) |>
    mutate(weo_flow = if_else(is.na(weo_flow.y), weo_flow.x, weo_flow.y)) |>
    select(-ends_with(".x")) |>
    select(-ends_with(".y")) |>
    distinct()
}

pivot_type_sector_subsector <- function(companies) {
  companies |>
    rename(weo_sector = weo_product, weo_subsector = weo_flow) |>
    pivot_longer(c(ipr_sector, ipr_subsector, weo_sector, weo_subsector)) |>
    separate(name, c("type", "tmp")) |>
    pivot_wider(names_from = "tmp")
}

# R/utils.R
lowercase_characters <- function(data) {
  mutate(data, across(where(is.character), tolower))
}
```

### Prepare data

``` r
companies <- real$pstr_companies |>
  slice(1:2) |> 
  pstr_prepare_companies()

scenario <- pstr_prepare_scenario(real$pstr_ipr_2022, real$pstr_weo_2022)
```

### Calculate the indicator

``` r
companies |>
  pstr_add_reductions_new(scenario) |>
  pstr_add_transition_risk() |>
  # FIXME: We lost `company_id`
  # FIXME: We lost `type`
  # FIXME: Remove groups
  pstr_aggregate_scores(companies)
#> # A tibble: 10 × 5
#> # Groups:   company_name, transition_risk, scenario, year [10]
#>    company_name                  transition_risk scenario  year score_aggregated
#>    <chr>                         <chr>           <chr>    <dbl>            <dbl>
#>  1 cbr-it                        low             1.5c re…  2020              100
#>  2 cbr-it                        low             1.5c re…  2030              100
#>  3 cbr-it                        low             1.5c re…  2040              100
#>  4 cbr-it                        low             1.5c re…  2050              100
#>  5 cbr-it                        no_sector       <NA>        NA               50
#>  6 cta - commodity trading aust… low             1.5c re…  2020              100
#>  7 cta - commodity trading aust… low             1.5c re…  2030              100
#>  8 cta - commodity trading aust… low             1.5c re…  2040              100
#>  9 cta - commodity trading aust… low             1.5c re…  2050              100
#> 10 cta - commodity trading aust… no_sector       <NA>        NA               50
```

QUESTION 1: De we expect only one type for some companies?

``` r
companies |>
  slice(1) |>
  pstr_add_reductions_new(scenario) |>
  pstr_add_transition_risk() |>
  count(type)
#> # A tibble: 1 × 2
#>   type      n
#>   <chr> <int>
#> 1 ipr       8
```
