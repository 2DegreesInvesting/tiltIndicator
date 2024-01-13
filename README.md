
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
#> # A tibble: 72 × 3
#>    companies_id                       product          company         
#>    <chr>                              <list>           <list>          
#>  1 antimonarchy_canine                <tibble [1 × 6]> <tibble [1 × 3]>
#>  2 celestial_lovebird                 <tibble [1 × 6]> <tibble [1 × 3]>
#>  3 nonphilosophical_llama             <tibble [1 × 6]> <tibble [1 × 3]>
#>  4 asteria_megalotomusquinquespinosus <tibble [1 × 6]> <tibble [1 × 3]>
#>  5 quasifaithful_amphiuma             <tibble [1 × 6]> <tibble [1 × 3]>
#>  6 spectacular_americanriverotter     <tibble [1 × 6]> <tibble [1 × 3]>
#>  7 contrite_silkworm                  <tibble [1 × 6]> <tibble [1 × 3]>
#>  8 harmless_owlbutterfly              <tibble [1 × 6]> <tibble [1 × 3]>
#>  9 fascist_maiasaura                  <tibble [1 × 6]> <tibble [1 × 3]>
#> 10 charismatic_islandwhistler         <tibble [1 × 6]> <tibble [1 × 3]>
#> # ℹ 62 more rows

both |> unnest_product()
#> # A tibble: 72 × 7
#>    companies_id               grouped_by risk_category profile_ranking clustered
#>    <chr>                      <chr>      <chr>                   <dbl> <chr>    
#>  1 antimonarchy_canine        <NA>       <NA>                       NA tent     
#>  2 celestial_lovebird         <NA>       <NA>                       NA table hi…
#>  3 nonphilosophical_llama     <NA>       <NA>                       NA surface …
#>  4 asteria_megalotomusquinqu… <NA>       <NA>                       NA tent     
#>  5 quasifaithful_amphiuma     <NA>       <NA>                       NA tent     
#>  6 spectacular_americanriver… <NA>       <NA>                       NA open spa…
#>  7 contrite_silkworm          <NA>       <NA>                       NA tent     
#>  8 harmless_owlbutterfly      <NA>       <NA>                       NA tent     
#>  9 fascist_maiasaura          <NA>       <NA>                       NA tent     
#> 10 charismatic_islandwhistler <NA>       <NA>                       NA camper p…
#> # ℹ 62 more rows
#> # ℹ 2 more variables: activity_uuid_product_uuid <chr>, co2_footprint <dbl>

both |> unnest_company()
#> # A tibble: 72 × 4
#>    companies_id                       grouped_by risk_category value
#>    <chr>                              <chr>      <chr>         <dbl>
#>  1 antimonarchy_canine                <NA>       <NA>             NA
#>  2 celestial_lovebird                 <NA>       <NA>             NA
#>  3 nonphilosophical_llama             <NA>       <NA>             NA
#>  4 asteria_megalotomusquinquespinosus <NA>       <NA>             NA
#>  5 quasifaithful_amphiuma             <NA>       <NA>             NA
#>  6 spectacular_americanriverotter     <NA>       <NA>             NA
#>  7 contrite_silkworm                  <NA>       <NA>             NA
#>  8 harmless_owlbutterfly              <NA>       <NA>             NA
#>  9 fascist_maiasaura                  <NA>       <NA>             NA
#> 10 charismatic_islandwhistler         <NA>       <NA>             NA
#> # ℹ 62 more rows
```

For more examples see [Get
started](https://2degreesinvesting.github.io/tiltIndicator/articles/tiltIndicator.html).
