
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

ictr(ictr_companies, ictr_inputs)
#> # A tibble: 15 × 6
#>    id           transition_risk score_all score_unit score_sector score_unit_sec
#>    <chr>        <chr>               <dbl>      <dbl>        <dbl>          <dbl>
#>  1 fleischerei… high                0.286      0.333        0.333         0.476 
#>  2 fleischerei… medium              0.381      0.476        0.429         0.429 
#>  3 fleischerei… low                 0.333      0.190        0.238         0.0952
#>  4 pecheries-b… high                0.333      0.333        0.556         0.556 
#>  5 pecheries-b… medium              0.556      0.556        0.333         0.222 
#>  6 pecheries-b… low                 0.111      0.111        0.111         0.222 
#>  7 hoche-butte… high                0          0            0             0     
#>  8 hoche-butte… medium              0.667      0.667        0.667         0.667 
#>  9 hoche-butte… low                 0.333      0.333        0.333         0.333 
#> 10 vicquelin-e… high                0.111      0.222        0.111         0.222 
#> 11 vicquelin-e… medium              0.444      0.444        0.556         0.667 
#> 12 vicquelin-e… low                 0.444      0.333        0.333         0.111 
#> 13 bst-procont… high                0.394      0.364        0.455         0.515 
#> 14 bst-procont… medium              0.333      0.424        0.333         0.333 
#> 15 bst-procont… low                 0.273      0.212        0.212         0.152

pctr(pctr_companies, pctr_ecoinvent_co2)
#> # A tibble: 9 × 5
#>   id                         transition_risk score_all score_unit score_unit_sec
#>   <chr>                      <chr>               <dbl>      <dbl>          <dbl>
#> 1 powerstartmanufacturinggm… high                 0.25      0.5           0.5   
#> 2 powerstartmanufacturinggm… medium               0.25      0.25          0.25  
#> 3 powerstartmanufacturinggm… low                  0.5       0.25          0.25  
#> 4 ebtor_0000000532489962183… high                 0.6       0.6           0.8   
#> 5 ebtor_0000000532489962183… medium               0.2       0.4           0.2   
#> 6 ebtor_0000000532489962183… low                  0.2       0             0     
#> 7 mbdgmbh_00000004773428001  high                 0.25      0.438         0.688 
#> 8 mbdgmbh_00000004773428001  medium               0.5       0.375         0.25  
#> 9 mbdgmbh_00000004773428001  low                  0.25      0.188         0.0625
```
