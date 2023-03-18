
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tiltIndicator (public)

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/2DegreesInvesting/tiltIndicator/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/2DegreesInvesting/tiltIndicator/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of tiltIndicator is to help you calculate each TILT indicator.

This repository hosts only public code and may only show only fake data.

## Installation

You can install the development version of tiltIndicator from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("2DegreesInvesting/tiltIndicator")
```

## Example

Private data must be stored outside this repository.

``` r
private_data <- tiltIndicator::data_dir()
fs::dir_tree(private_data)
#> ~/.local/share/tiltIndicator
#> └── product-carbon-tr
#>     ├── ep
#>     │   ├── categories.csv
#>     │   ├── categories_lookup.csv
#>     │   ├── companies.csv
#>     │   ├── products.csv
#>     │   └── products_lookup.csv
#>     └── input_data
#>         ├── MVP_sample_dataset.csv
#>         └── ecoinvent_activities.csv
```
