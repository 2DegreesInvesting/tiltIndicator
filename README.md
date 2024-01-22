
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tiltIndicator

<!-- badges: start -->

[![tiltIndicator status
badge](https://2degreesinvesting.r-universe.dev/badges/tiltIndicator)](https://2degreesinvesting.r-universe.dev/tiltIndicator)
[![R-CMD-check](https://github.com/2DegreesInvesting/tiltIndicator/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/2DegreesInvesting/tiltIndicator/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/2DegreesInvesting/tiltIndicator/branch/main/graph/badge.svg)](https://app.codecov.io/gh/2DegreesInvesting/tiltIndicator?branch=main)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of tiltIndicator is to implement the core business logic of the
‘TILT’ indicators.

## Installation

You can install the latest release from
[r-universe](https://r-universe.dev/) with:

``` r
install.packages("tiltIndicator", repos = c("https://2degreesinvesting.r-universe.dev", getOption("repos")))
```

Or the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("2DegreesInvesting/tiltIndicator")
```

Having trouble? Try it on a fresh new project on <https://posit.cloud/>
(free).

## Example

``` r

library(tiltIndicator)
library(tiltToyData)
library(readr)
options(readr.show_col_types = FALSE)

companies <- read_csv(toy_emissions_profile_any_companies())
products <- read_csv(toy_emissions_profile_products_ecoinvent())

both <- emissions_profile(companies, products)
both
#> # A tibble: 72 × 3
#>    companies_id                       product           company          
#>    <chr>                              <list>            <list>           
#>  1 antimonarchy_canine                <tibble [36 × 6]> <tibble [18 × 3]>
#>  2 celestial_lovebird                 <tibble [36 × 6]> <tibble [18 × 3]>
#>  3 nonphilosophical_llama             <tibble [72 × 6]> <tibble [18 × 3]>
#>  4 asteria_megalotomusquinquespinosus <tibble [36 × 6]> <tibble [18 × 3]>
#>  5 quasifaithful_amphiuma             <tibble [36 × 6]> <tibble [18 × 3]>
#>  6 spectacular_americanriverotter     <tibble [36 × 6]> <tibble [18 × 3]>
#>  7 contrite_silkworm                  <tibble [36 × 6]> <tibble [18 × 3]>
#>  8 harmless_owlbutterfly              <tibble [36 × 6]> <tibble [18 × 3]>
#>  9 fascist_maiasaura                  <tibble [36 × 6]> <tibble [18 × 3]>
#> 10 charismatic_islandwhistler         <tibble [36 × 6]> <tibble [18 × 3]>
#> # ℹ 62 more rows

both |> unnest_product()
#> # A tibble: 2,736 × 7
#>    companies_id        grouped_by  risk_category profile_ranking clustered
#>    <chr>               <chr>       <chr>                   <dbl> <chr>    
#>  1 antimonarchy_canine all         low                    0.167  tent     
#>  2 antimonarchy_canine all         high                   1      tent     
#>  3 antimonarchy_canine all         high                   0.778  tent     
#>  4 antimonarchy_canine all         medium                 0.667  tent     
#>  5 antimonarchy_canine all         low                    0.0556 tent     
#>  6 antimonarchy_canine all         medium                 0.611  tent     
#>  7 antimonarchy_canine isic_4digit medium                 0.5    tent     
#>  8 antimonarchy_canine isic_4digit high                   1      tent     
#>  9 antimonarchy_canine isic_4digit low                    0.333  tent     
#> 10 antimonarchy_canine isic_4digit high                   1      tent     
#> # ℹ 2,726 more rows
#> # ℹ 2 more variables: activity_uuid_product_uuid <chr>, co2_footprint <dbl>

both |> unnest_company()
#> # A tibble: 1,296 × 4
#>    companies_id        grouped_by  risk_category value
#>    <chr>               <chr>       <chr>         <dbl>
#>  1 antimonarchy_canine all         high          0.333
#>  2 antimonarchy_canine all         medium        0.333
#>  3 antimonarchy_canine all         low           0.333
#>  4 antimonarchy_canine isic_4digit high          0.5  
#>  5 antimonarchy_canine isic_4digit medium        0.167
#>  6 antimonarchy_canine isic_4digit low           0.333
#>  7 antimonarchy_canine tilt_sector high          0.5  
#>  8 antimonarchy_canine tilt_sector medium        0    
#>  9 antimonarchy_canine tilt_sector low           0.5  
#> 10 antimonarchy_canine unit        high          0.5  
#> # ℹ 1,286 more rows
```

For more examples see [Get
started](https://2degreesinvesting.github.io/tiltIndicator/articles/tiltIndicator.html).
