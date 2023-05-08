
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

packageVersion("tiltIndicator")
#> [1] '0.0.0.9045'

companies
#> # A tibble: 9 × 4
#>   activity_uuid_product_uuid                          clustered company_id unit 
#>   <chr>                                               <chr>     <chr>      <chr>
#> 1 0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0… stove     fleischer… unit 
#> 2 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200… oven      fleischer… unit 
#> 3 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5… steel     pecheries… kg   
#> 4 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c… aged che… hoche-but… kg   
#> 5 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c… aged che… vicquelin… kg   
#> 6 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c… cheese    bst-proco… kg   
#> 7 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb… cream     leider-gm… kg   
#> 8 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb… rubber    cheries-b… kg   
#> 9 <NA>                                                apple     ca-coity-… <NA>

# ICTR
inputs
#> # A tibble: 33 × 6
#>    input_co2_footprint input_tilt_sector input_unit input_isic_4digit
#>                  <dbl> <chr>             <chr>                  <dbl>
#>  1             7.07e+0 Inudstry          kg                      2560
#>  2             3.99e+1 Inudstry          kwh                     2560
#>  3             5.12e-1 Inudstry          kg                      2560
#>  4             1.24e+0 Inudstry          kg                      2560
#>  5             2.12e+1 Inudstry          kwh                     2560
#>  6             1.24e-9 Inudstry          kg                      2560
#>  7             7   e-9 Inudstry          kg                      2560
#>  8             1.04e+0 Inudstry          kg                      2560
#>  9             1.12e+0 Inudstry          kg                      2560
#> 10             3.51e+0 Inudstry          kg                      2560
#> # ℹ 23 more rows
#> # ℹ 2 more variables: input_activity_uuid_product_uuid <chr>,
#> #   activity_uuid_product_uuid <chr>

companies |>
  xctr_at_product_level(co2 = inputs)
#> # A tibble: 324 × 7
#>    companies_id        grouped_by risk_category clustered activity_uuid_produc…¹
#>    <chr>               <chr>      <chr>         <chr>     <chr>                 
#>  1 fleischerei-stiefs… all        high          stove     0a242b09-772a-5edf-8e…
#>  2 fleischerei-stiefs… isic_sec   high          stove     0a242b09-772a-5edf-8e…
#>  3 fleischerei-stiefs… tilt_sec   high          stove     0a242b09-772a-5edf-8e…
#>  4 fleischerei-stiefs… unit       high          stove     0a242b09-772a-5edf-8e…
#>  5 fleischerei-stiefs… unit_isic… high          stove     0a242b09-772a-5edf-8e…
#>  6 fleischerei-stiefs… unit_tilt… high          stove     0a242b09-772a-5edf-8e…
#>  7 fleischerei-stiefs… all        high          stove     0a242b09-772a-5edf-8e…
#>  8 fleischerei-stiefs… isic_sec   high          stove     0a242b09-772a-5edf-8e…
#>  9 fleischerei-stiefs… tilt_sec   high          stove     0a242b09-772a-5edf-8e…
#> 10 fleischerei-stiefs… unit       high          stove     0a242b09-772a-5edf-8e…
#> # ℹ 314 more rows
#> # ℹ abbreviated name: ¹​activity_uuid_product_uuid
#> # ℹ 2 more variables: input_activity_uuid_product_uuid <chr>,
#> #   input_co2_footprint <dbl>

companies |>
  xctr_at_product_level(co2 = inputs) |>
  xctr_at_company_level()
#> # A tibble: 144 × 4
#>    companies_id                           grouped_by risk_category value
#>    <chr>                                  <chr>      <chr>         <dbl>
#>  1 bst-procontrol-gmbh_00000005104947-001 all        high          0.143
#>  2 bst-procontrol-gmbh_00000005104947-001 all        medium        0.429
#>  3 bst-procontrol-gmbh_00000005104947-001 all        low           0.429
#>  4 bst-procontrol-gmbh_00000005104947-001 isic_sec   high          0.429
#>  5 bst-procontrol-gmbh_00000005104947-001 isic_sec   medium        0.286
#>  6 bst-procontrol-gmbh_00000005104947-001 isic_sec   low           0.286
#>  7 bst-procontrol-gmbh_00000005104947-001 tilt_sec   high          0.429
#>  8 bst-procontrol-gmbh_00000005104947-001 tilt_sec   medium        0.286
#>  9 bst-procontrol-gmbh_00000005104947-001 tilt_sec   low           0.286
#> 10 bst-procontrol-gmbh_00000005104947-001 unit       high          0.286
#> # ℹ 134 more rows

# Same
companies |> xctr(co2 = inputs)
#> # A tibble: 144 × 4
#>    companies_id                           grouped_by risk_category value
#>    <chr>                                  <chr>      <chr>         <dbl>
#>  1 bst-procontrol-gmbh_00000005104947-001 all        high          0.143
#>  2 bst-procontrol-gmbh_00000005104947-001 all        medium        0.429
#>  3 bst-procontrol-gmbh_00000005104947-001 all        low           0.429
#>  4 bst-procontrol-gmbh_00000005104947-001 isic_sec   high          0.429
#>  5 bst-procontrol-gmbh_00000005104947-001 isic_sec   medium        0.286
#>  6 bst-procontrol-gmbh_00000005104947-001 isic_sec   low           0.286
#>  7 bst-procontrol-gmbh_00000005104947-001 tilt_sec   high          0.429
#>  8 bst-procontrol-gmbh_00000005104947-001 tilt_sec   medium        0.286
#>  9 bst-procontrol-gmbh_00000005104947-001 tilt_sec   low           0.286
#> 10 bst-procontrol-gmbh_00000005104947-001 unit       high          0.286
#> # ℹ 134 more rows

# PCTR
products
#> # A tibble: 7 × 6
#>   co2_footprint tilt_sector    unit  isic_4digit activity_uuid_product_uuid     
#>           <dbl> <chr>          <chr>       <dbl> <chr>                          
#> 1        176.   Industry       unit         2560 0a242b09-772a-5edf-8e82-9cb4ba…
#> 2         58.1  Industry       unit         2560 be06d25c-73dc-55fb-965b-0f3004…
#> 3          4.95 Steel & Metals kg           2870 977d997e-c257-5033-ba39-d0edee…
#> 4         12.5  Agriculture    kg           1780 ebb8475e-ff57-5e4e-937b-b57881…
#> 5         12.5  Agriculture    kg           1780 ebb8475e-ff57-5e4e-937b-b57881…
#> 6          2.07 Industry       kg           2679 2f7b77a7-1556-5c1b-b0aa-c4534d…
#> 7          1.98 Industry       kg           2679 2f7b77a7-1556-5c1b-b0aa-c4534d…
#> # ℹ 1 more variable: ei_activity_name <chr>

companies |>
  xctr_at_product_level(co2 = products)
#> # A tibble: 84 × 6
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
#>  9 fleischerei-stiefs… tilt_sec   high          oven      be06d25c-73dc-55fb-96…
#> 10 fleischerei-stiefs… unit       medium        oven      be06d25c-73dc-55fb-96…
#> # ℹ 74 more rows
#> # ℹ abbreviated name: ¹​activity_uuid_product_uuid
#> # ℹ 1 more variable: co2_footprint <dbl>

companies |>
  xctr_at_product_level(co2 = products) |>
  xctr_at_company_level()
#> # A tibble: 144 × 4
#>    companies_id                           grouped_by risk_category value
#>    <chr>                                  <chr>      <chr>         <dbl>
#>  1 bst-procontrol-gmbh_00000005104947-001 all        high            0.5
#>  2 bst-procontrol-gmbh_00000005104947-001 all        medium          0.5
#>  3 bst-procontrol-gmbh_00000005104947-001 all        low             0  
#>  4 bst-procontrol-gmbh_00000005104947-001 isic_sec   high            0.5
#>  5 bst-procontrol-gmbh_00000005104947-001 isic_sec   medium          0.5
#>  6 bst-procontrol-gmbh_00000005104947-001 isic_sec   low             0  
#>  7 bst-procontrol-gmbh_00000005104947-001 tilt_sec   high            0.5
#>  8 bst-procontrol-gmbh_00000005104947-001 tilt_sec   medium          0.5
#>  9 bst-procontrol-gmbh_00000005104947-001 tilt_sec   low             0  
#> 10 bst-procontrol-gmbh_00000005104947-001 unit       high            1  
#> # ℹ 134 more rows

# Same
companies |> xctr(co2 = products)
#> # A tibble: 144 × 4
#>    companies_id                           grouped_by risk_category value
#>    <chr>                                  <chr>      <chr>         <dbl>
#>  1 bst-procontrol-gmbh_00000005104947-001 all        high            0.5
#>  2 bst-procontrol-gmbh_00000005104947-001 all        medium          0.5
#>  3 bst-procontrol-gmbh_00000005104947-001 all        low             0  
#>  4 bst-procontrol-gmbh_00000005104947-001 isic_sec   high            0.5
#>  5 bst-procontrol-gmbh_00000005104947-001 isic_sec   medium          0.5
#>  6 bst-procontrol-gmbh_00000005104947-001 isic_sec   low             0  
#>  7 bst-procontrol-gmbh_00000005104947-001 tilt_sec   high            0.5
#>  8 bst-procontrol-gmbh_00000005104947-001 tilt_sec   medium          0.5
#>  9 bst-procontrol-gmbh_00000005104947-001 tilt_sec   low             0  
#> 10 bst-procontrol-gmbh_00000005104947-001 unit       high            1  
#> # ℹ 134 more rows
```
