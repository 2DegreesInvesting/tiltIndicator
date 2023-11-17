
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

companies <- read_csv(toy_emissions_profile_any_companies())
products <- read_csv(toy_emissions_profile_products())

both <- emissions_profile(companies, products)
both
#> # A tibble: 8 × 3
#>   companies_id                             product           company          
#>   <chr>                                    <list>            <list>           
#> 1 fleischerei-stiefsohn_00000005219477-001 <tibble [12 × 6]> <tibble [18 × 3]>
#> 2 pecheries-basques_fra316541-00101        <tibble [6 × 6]>  <tibble [18 × 3]>
#> 3 hoche-butter-gmbh_deu422723-693847001    <tibble [6 × 6]>  <tibble [18 × 3]>
#> 4 vicquelin-espaces-verts_fra697272-00101  <tibble [6 × 6]>  <tibble [18 × 3]>
#> 5 bst-procontrol-gmbh_00000005104947-001   <tibble [6 × 6]>  <tibble [18 × 3]>
#> 6 leider-gmbh_00000005064318-001           <tibble [6 × 6]>  <tibble [18 × 3]>
#> 7 cheries-baqu_neu316541-00101             <tibble [6 × 6]>  <tibble [18 × 3]>
#> 8 ca-coity-trg-aua-gmbh_00000384-001       <tibble [1 × 6]>  <tibble [3 × 3]>

both |> unnest_product()
#> # A tibble: 49 × 7
#>    companies_id               grouped_by risk_category profile_ranking clustered
#>    <chr>                      <chr>      <chr>                   <dbl> <chr>    
#>  1 fleischerei-stiefsohn_000… all        high                    1     stove    
#>  2 fleischerei-stiefsohn_000… isic_4dig… high                    1     stove    
#>  3 fleischerei-stiefsohn_000… tilt_sect… high                    1     stove    
#>  4 fleischerei-stiefsohn_000… unit       high                    1     stove    
#>  5 fleischerei-stiefsohn_000… unit_isic… high                    1     stove    
#>  6 fleischerei-stiefsohn_000… unit_tilt… high                    1     stove    
#>  7 fleischerei-stiefsohn_000… all        high                    0.8   oven     
#>  8 fleischerei-stiefsohn_000… isic_4dig… medium                  0.5   oven     
#>  9 fleischerei-stiefsohn_000… tilt_sect… medium                  0.667 oven     
#> 10 fleischerei-stiefsohn_000… unit       medium                  0.5   oven     
#> # ℹ 39 more rows
#> # ℹ 2 more variables: activity_uuid_product_uuid <chr>, co2_footprint <dbl>

both |> unnest_company()
#> # A tibble: 129 × 4
#>    companies_id                             grouped_by  risk_category value
#>    <chr>                                    <chr>       <chr>         <dbl>
#>  1 fleischerei-stiefsohn_00000005219477-001 all         high            1  
#>  2 fleischerei-stiefsohn_00000005219477-001 all         medium          0  
#>  3 fleischerei-stiefsohn_00000005219477-001 all         low             0  
#>  4 fleischerei-stiefsohn_00000005219477-001 isic_4digit high            0.5
#>  5 fleischerei-stiefsohn_00000005219477-001 isic_4digit medium          0.5
#>  6 fleischerei-stiefsohn_00000005219477-001 isic_4digit low             0  
#>  7 fleischerei-stiefsohn_00000005219477-001 tilt_sector high            0.5
#>  8 fleischerei-stiefsohn_00000005219477-001 tilt_sector medium          0.5
#>  9 fleischerei-stiefsohn_00000005219477-001 tilt_sector low             0  
#> 10 fleischerei-stiefsohn_00000005219477-001 unit        high            0.5
#> # ℹ 119 more rows
```

For more examples see [Get
started](https://2degreesinvesting.github.io/tiltIndicator/articles/tiltIndicator.html).
