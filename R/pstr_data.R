#' A dataset with fake companies, products, sectors and subsectors
#'
#' * TODO: Does it have any relationship with tiltData?
#' * FIXME: Rename to match existing tiltData, e.g. `company_id` -> `companies_id`
#'
#' @family datasets for product sector transition risk
#' @examples
#' companies
"companies"

#' A bridge between sector and subsectors in europages and in `weo_2022`.
#'
#' * TODO: Where does it come from and what wrangling did you do?
#' * FIXME: Rename to match existing tiltData and to use lowercase. E.g. removing
#' the prefix "ep_" makes it more compatible with tiltData and makes it easier
#' to join.
#'
#' @family datasets for product sector transition risk
#' @examples
#' ep_weo
"ep_weo"

#' A dataset with scenario, year, product and reductions information
#'
#' * TODO: Where does it come from and what wrangling did you do?
#'
#' @family datasets for product sector transition risk
#' @examples
#' weo_2022
"weo_2022"
