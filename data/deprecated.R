read_new_toy_data_and_warn_deprecation <- function(new,
                                                   old,
                                                   when = "tiltIndicator 0.0.0.9089",
                                                   package = "tiltToyData",
                                                   ...) {
  warn_new_deprecates_old(new, old, when, package)
  readr::read_csv(toy_path(toy_ext(new)), ..., show_col_types = FALSE)
}

warn_new_deprecates_old <- function(new,
                                    old,
                                    when = "tiltIndicator 0.0.0.9089",
                                    package = "tiltToyData") {
  .Deprecated(msg = glue::glue(
    "`{old}` was deprecated in {when}.
    Please use `{new}` in {package}."
  ))
  invisible(new)
}

toy_ext <- function(x) {
  fs::path_ext_set(x, ext = "csv.gz")
}

toy_path <- function(file) {
  system.file("extdata", file, package = "tiltToyData", mustWork = TRUE)
}

delayedAssign("companies", read_new_toy_data_and_warn_deprecation(
  new = "emissions_profile_any_companies", old = "companies"
))

delayedAssign("products", read_new_toy_data_and_warn_deprecation(
  new = "emissions_profile_products", old = "products",
  col_types = readr::cols(isic_4digit = readr::col_character())
))
