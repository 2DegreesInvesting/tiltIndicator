<details/>
<summary/>
reprex
</summary>

``` r
# styler: off
companies <- tibble::tribble(
      ~sector, ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~subsector, ~tilt_sector, ~tilt_subsector, ~type,
  "unmatched",           "a",        "a",                         "a",   "energy",          "a",             "a", "ipr"
)
scenarios <- tibble::tribble(
  ~sector, ~subsector,  ~year, ~reductions, ~type, ~scenario,
  "total",   "energy", "2050",         "1", "ipr",       "a"
)

# styler: on

if (!interactive()) withr::local_options(width = 500)



# Load code in the main branch
library(tiltIndicator)
packageVersion("tiltIndicator")
#> [1] '0.0.0.9221'

result_main <- sector_profile(companies, scenarios)

result_main |> unnest_product()
#> # A tibble: 1 × 11
#>   companies_id grouped_by risk_category profile_ranking clustered activity_uuid_product_uuid tilt_sector scenario year  type  tilt_subsector
#>   <chr>        <chr>      <chr>         <chr>           <chr>     <chr>                      <chr>       <chr>    <chr> <chr> <chr>         
#> 1 a            <NA>       <NA>          <NA>            a         a                          a           <NA>     <NA>  ipr   a

result_main |> unnest_company()
#> # A tibble: 1 × 4
#>   companies_id grouped_by risk_category value
#>   <chr>        <chr>      <chr>         <dbl>
#> 1 a            <NA>       <NA>             NA

# Compare ----------------------------------------------------------------

# Load code in this PR
devtools::load_all()
#> ℹ Loading tiltIndicator
packageVersion("tiltIndicator")
#> [1] '0.0.0.9222'

result_pr <- sector_profile(companies, scenarios)

result_pr |> unnest_product()
#> # A tibble: 1 × 11
#>   companies_id grouped_by risk_category profile_ranking clustered activity_uuid_product_uuid tilt_sector scenario year  type  tilt_subsector
#>   <chr>        <chr>      <chr>         <chr>           <chr>     <chr>                      <chr>       <chr>    <chr> <chr> <chr>         
#> 1 a            ipr_NA_NA  <NA>          <NA>            a         a                          a           <NA>     <NA>  ipr   a

result_pr |> unnest_company()
#> # A tibble: 4 × 4
#>   companies_id grouped_by risk_category value
#>   <chr>        <chr>      <chr>         <dbl>
#> 1 a            ipr_NA_NA  high              0
#> 2 a            ipr_NA_NA  medium            0
#> 3 a            ipr_NA_NA  low               0
#> 4 a            ipr_NA_NA  <NA>              1
```

</details>
