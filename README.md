
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tiltIndicator

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/2DegreesInvesting/tiltIndicator/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/2DegreesInvesting/tiltIndicator/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/2DegreesInvesting/tiltIndicator/branch/main/graph/badge.svg)](https://app.codecov.io/gh/2DegreesInvesting/tiltIndicator?branch=main)
<!-- badges: end -->

The goal of tiltIndicator is to help you develop each TILT indicator.

This repository hosts only public code and may only show only fake data.

## Installation

You can install the development version of tiltIndicator from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("2DegreesInvesting/tiltIndicator")
```

## Example

``` r
library(tiltIndicator)
library(tiltToyData)
library(readr)
options(readr.show_col_types = FALSE)

toy_files()
#> [1] "emissions_profile_any_companies.csv.gz"    
#> [2] "emissions_profile_products.csv.gz"         
#> [3] "emissions_profile_upstream_products.csv.gz"
#> [4] "sector_profile_any_scenarios.csv.gz"       
#> [5] "sector_profile_companies.csv.gz"           
#> [6] "sector_profile_upstream_companies.csv.gz"  
#> [7] "sector_profile_upstream_products.csv.gz"

companies <- toy_path("emissions_profile_any_companies.csv.gz") |>
  read_csv()

products <- toy_path("emissions_profile_products.csv.gz") |>
  read_csv(col_types = cols(isic_4digit = col_character()))

both <- emissions_profile(companies, products)
both
#> # A tibble: 8 × 3
#>   companies_id                             product           company          
#>   <chr>                                    <list>            <list>           
#> 1 fleischerei-stiefsohn_00000005219477-001 <tibble [12 × 5]> <tibble [18 × 3]>
#> 2 pecheries-basques_fra316541-00101        <tibble [6 × 5]>  <tibble [18 × 3]>
#> 3 hoche-butter-gmbh_deu422723-693847001    <tibble [6 × 5]>  <tibble [18 × 3]>
#> 4 vicquelin-espaces-verts_fra697272-00101  <tibble [6 × 5]>  <tibble [18 × 3]>
#> 5 bst-procontrol-gmbh_00000005104947-001   <tibble [6 × 5]>  <tibble [18 × 3]>
#> 6 leider-gmbh_00000005064318-001           <tibble [6 × 5]>  <tibble [18 × 3]>
#> 7 cheries-baqu_neu316541-00101             <tibble [6 × 5]>  <tibble [18 × 3]>
#> 8 ca-coity-trg-aua-gmbh_00000384-001       <tibble [1 × 5]>  <tibble [3 × 3]>

both |> unnest_product()
#> # A tibble: 49 × 6
#>    companies_id        grouped_by risk_category clustered activity_uuid_produc…¹
#>    <chr>               <chr>      <chr>         <chr>     <chr>                 
#>  1 fleischerei-stiefs… all        high          stove     0a242b09-772a-5edf-8e…
#>  2 fleischerei-stiefs… isic_sec   high          stove     0a242b09-772a-5edf-8e…
#>  3 fleischerei-stiefs… tilt_sec   high          stove     0a242b09-772a-5edf-8e…
#>  4 fleischerei-stiefs… unit       high          stove     0a242b09-772a-5edf-8e…
#>  5 fleischerei-stiefs… unit_isic… high          stove     0a242b09-772a-5edf-8e…
#>  6 fleischerei-stiefs… unit_tilt… high          stove     0a242b09-772a-5edf-8e…
#>  7 fleischerei-stiefs… all        high          oven      be06d25c-73dc-55fb-96…
#>  8 fleischerei-stiefs… isic_sec   medium        oven      be06d25c-73dc-55fb-96…
#>  9 fleischerei-stiefs… tilt_sec   medium        oven      be06d25c-73dc-55fb-96…
#> 10 fleischerei-stiefs… unit       medium        oven      be06d25c-73dc-55fb-96…
#> # ℹ 39 more rows
#> # ℹ abbreviated name: ¹​activity_uuid_product_uuid
#> # ℹ 1 more variable: co2_footprint <dbl>

both |> unnest_company()
#> # A tibble: 129 × 4
#>    companies_id                             grouped_by risk_category value
#>    <chr>                                    <chr>      <chr>         <dbl>
#>  1 fleischerei-stiefsohn_00000005219477-001 all        high            1  
#>  2 fleischerei-stiefsohn_00000005219477-001 all        medium          0  
#>  3 fleischerei-stiefsohn_00000005219477-001 all        low             0  
#>  4 fleischerei-stiefsohn_00000005219477-001 isic_sec   high            0.5
#>  5 fleischerei-stiefsohn_00000005219477-001 isic_sec   medium          0.5
#>  6 fleischerei-stiefsohn_00000005219477-001 isic_sec   low             0  
#>  7 fleischerei-stiefsohn_00000005219477-001 tilt_sec   high            0.5
#>  8 fleischerei-stiefsohn_00000005219477-001 tilt_sec   medium          0.5
#>  9 fleischerei-stiefsohn_00000005219477-001 tilt_sec   low             0  
#> 10 fleischerei-stiefsohn_00000005219477-001 unit       high            0.5
#> # ℹ 119 more rows
```
