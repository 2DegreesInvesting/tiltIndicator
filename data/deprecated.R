warn_deprecates <- function(new,
                            old,
                            when,
                            package = toy_package()) {
  .Deprecated(msg = glue::glue(
    "`{old}` was deprecated in {when}.
    Please use `{new}` in {package}."
  ))

  invisible(new)
}

read_toy_dataset <- function(dataset, ...) {
  file <- sprintf("%s.%s", dataset, toy_ext())
  path <- toy_path(file)
  readr::read_csv(path, show_col_types = FALSE, ...)
}

toy_path <- function(file) {
  system.file("extdata", file, package = toy_package(), mustWork = TRUE)
}

toy_package <- function() {
  "tiltToyData"
}

toy_ext <- function() {
  "csv.gz"
}

.when <- "tiltIndicator 0.0.0.9089"

delayedAssign("companies", value = {
  "emissions_profile_any_companies" |>
    warn_deprecates("companies", when = .when) |>
    read_toy_dataset()
})

delayedAssign("products", value = {
  "emissions_profile_products" |>
    warn_deprecates("products", when = .when) |>
    read_toy_dataset(col_types = readr::cols(isic_4digit = readr::col_character()))
})

delayedAssign("inputs", value = {
  "emissions_profile_upstream_products" |>
    warn_deprecates("inputs", when = .when) |>
    read_toy_dataset(col_types = readr::cols(input_isic_4digit = readr::col_character()))
})

delayedAssign("pstr_companies", value = {
  "sector_profile_companies" |>
    warn_deprecates("pstr_companies", when = .when) |>
    read_toy_dataset()
})
