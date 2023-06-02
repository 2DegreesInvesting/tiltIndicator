
# Check XSTR

The goal of this document is to check XSTR outputs are as we expect. It
automates checks that we would otherwise run interactively.

``` r
library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
library(testthat, warn.conflicts = FALSE)
```

## At both levels

``` r
message("Using ", params$product)
#> Using ~/Downloads/pstr_product_level_v2_fixed.csv
product <- read_csv(params$product)
#> Rows: 1655052 Columns: 10
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (9): companies_id, grouped_by, risk_category, clustered, activity_uuid_p...
#> dbl (1): year
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
product |> glimpse()
#> Rows: 1,655,052
#> Columns: 10
#> $ companies_id               <chr> "%ef%bb%bfmathias-maschinenhandel-laserserv…
#> $ grouped_by                 <chr> "ipr_1.5c rps_2030", "ipr_1.5c rps_2050", "…
#> $ risk_category              <chr> "high", "high", NA, NA, NA, NA, "high", "hi…
#> $ clustered                  <chr> NA, NA, "fish, deep-frozen", "fish, deep-fr…
#> $ activity_uuid_product_uuid <chr> NA, NA, "26104519-4d49-5d85-bc74-e8e03d1a79…
#> $ tilt_sector                <chr> "steel and metals", "steel and metals", NA,…
#> $ scenario                   <chr> "1.5c rps", "1.5c rps", NA, NA, NA, NA, "1.…
#> $ year                       <dbl> 2030, 2050, NA, NA, NA, NA, 2030, 2050, 203…
#> $ type                       <chr> "ipr", "ipr", "ipr", "weo", "ipr", "weo", "…
#> $ tilt_subsector             <chr> "steel", "steel", NA, NA, NA, NA, "oil ener…

message("Using ", params$company)
#> Using ~/Downloads/pstr_company_level_v2_fixed.csv
company <- read_csv(params$company)
#> Rows: 2373289 Columns: 6
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (4): companies_id, type, scenario, risk_category
#> dbl (2): year, value
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
company |> glimpse()
#> Rows: 2,373,289
#> Columns: 6
#> $ companies_id  <chr> "%ef%bb%bfmathias-maschinenhandel-laserservice_000000050…
#> $ type          <chr> "ipr", "ipr", "ipr", "ipr", "ipr", "ipr", "ipr", "ipr", …
#> $ scenario      <chr> "1.5c rps", "1.5c rps", "1.5c rps", "1.5c rps", "1.5c rp…
#> $ year          <dbl> 2030, 2030, 2030, 2050, 2050, 2050, 2030, 2030, 2030, 20…
#> $ risk_category <chr> "high", "medium", "low", "high", "medium", "low", "high"…
#> $ value         <dbl> 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0,…
```

``` r
has_no_duplicates <- identical(anyDuplicated(product), 0L)
expect_true(has_no_duplicates)

has_no_duplicates <- identical(anyDuplicated(company), 0L)
expect_true(has_no_duplicates)
```

## At product level

``` r
n_products_per_company <- unique(count(product, companies_id, clustered)$n)
# FIXME? bit.ly/3ISwI2y. We expect 2 or 4 but after removing duplicates we may
# also get 1 and 3
expect_equal(sort(n_products_per_company), c(1:4))
```

## At company level

``` r
rows_per_company <- unique(count(company, companies_id)$n)
expect_equal(sort(rows_per_company), c(1L, 6L, 12L))
```
