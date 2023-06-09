% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pstr.R, R/pstr_at_product_level.R, R/xctr.R
\name{pstr}
\alias{pstr}
\alias{pstr_at_product_level}
\alias{pstr_at_company_level}
\title{Calculate the PSTR indicator}
\usage{
pstr(
  companies,
  scenarios,
  low_threshold = ifelse(scenarios$year == 2030, 1/9, 1/3),
  high_threshold = ifelse(scenarios$year == 2030, 2/9, 2/3)
)

pstr_at_product_level(
  companies,
  scenarios,
  low_threshold = ifelse(scenarios$year == 2030, 1/9, 1/3),
  high_threshold = ifelse(scenarios$year == 2030, 2/9, 2/3)
)

pstr_at_company_level(data)
}
\arguments{
\item{companies}{A dataframe like \link{pstr_companies}.}

\item{scenarios}{A dataframe like \link{xstr_scenarios}.}

\item{low_threshold}{A numeric value to segment low and medium reduction
targets.}

\item{high_threshold}{A numeric value to segment medium and high reduction
targets.}

\item{data}{A dataframe. The output at product level.}
}
\value{
A data frame with the column \code{companies_id}, and the nested columns \code{product} and \code{company} holding the outputs at product and company level. Unnesting \code{product} yields a data frame with at least columns \code{companies_id}, \code{grouped_by}, \code{risk_category}. Unnesting \code{company} yields a data frame with at least columns \code{companies_id}, \code{grouped_by}, \code{risk_category}, \code{value}.
}
\description{
The Product Sector Transition Risk Indicator measures the transition risk of
products based on the sector's emissions targets the product belongs to. Those
sector emission reduction targets vary across scenarios (e.g., net zero
scenario or 1.5° scenario) and the time horizon (e.g., reduction needed in
2030, 2040, 2050 to achieve the targets).

After assessing each product, all the products with the same category are
aggregated and set in relation to all products of the company. We, therefore,
derive company-level information.
}
\examples{
library(dplyr, warn.conflicts = FALSE)
library(tidyr)

companies <- pstr_companies
scenarios <- xstr_scenarios

# Product level
companies |>
  pstr_at_product_level(scenarios)

# Company level
companies |>
  pstr_at_product_level(scenarios) |>
  pstr_at_company_level()

# Or
both <- pstr(companies, scenarios)
both

# Product level
both |> unnest_product()

# Company level
both |> unnest_company()
}
\concept{PSTR functions}
