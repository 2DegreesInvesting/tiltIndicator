# Avoid R CMD Check warning about undocumented data sets. See `?e`.
e <- new.env()

e$warn_deprecates <- function(new,
                              old,
                              when,
                              package = e$toy_package()) {
  if(e$on_rcmd()) return(invisible(new))

  .Deprecated(msg = sprintf(
    "`%s` was deprecated in %s. Please use `%s` from %s.",
    old, when, new, package
  ))

  invisible(new)
}

e$toy_package <- function() {
  "tiltToyData"
}

e$on_rcmd <- function() {
  nzchar(Sys.getenv("R_CMD"))
}

e$read_toy_dataset <- function(dataset, ...) {
  path <- e$toy_path(e$toy_file(dataset))
  readr::read_csv(path, show_col_types = FALSE, ...)
}

e$toy_file <- function(dataset) {
  sprintf("%s.%s", dataset, e$toy_ext())
}

e$toy_path <- function(file) {
  system.file("extdata", file, package = e$toy_package(), mustWork = TRUE)
}

e$toy_ext <- function() {
  "csv.gz"
}

e$when <- "tiltIndicator 0.0.0.9089"

delayedAssign("companies", value = {
  "emissions_profile_any_companies" |>
    e$warn_deprecates("companies", when = e$when) |>
    e$read_toy_dataset()
})

delayedAssign("products", value = {
  "emissions_profile_products" |>
    e$warn_deprecates("products", when = e$when) |>
    e$read_toy_dataset(col_types = readr::cols(isic_4digit = readr::col_character()))
})

delayedAssign("inputs", value = {
  "emissions_profile_upstream_products" |>
    e$warn_deprecates("inputs", when = e$when) |>
    e$read_toy_dataset(col_types = readr::cols(input_isic_4digit = readr::col_character()))
})

delayedAssign("pstr_companies", value = {
  "sector_profile_companies" |>
    e$warn_deprecates("pstr_companies", when = e$when) |>
    e$read_toy_dataset()
})

delayedAssign("istr_companies", value = {
  "sector_profile_upstream_companies" |>
    e$warn_deprecates("istr_companies", when = e$when) |>
    e$read_toy_dataset()
})

delayedAssign("istr_inputs", value = {
  "sector_profile_upstream_products" |>
    e$warn_deprecates("istr_inputs", when = e$when) |>
    e$read_toy_dataset(col_types = readr::cols(input_isic_4digit = readr::col_character()))
})

delayedAssign("xstr_scenarios", value = {
  "sector_profile_any_scenarios" |>
    e$warn_deprecates("xstr_scenarios", when = e$when) |>
    e$read_toy_dataset()
})
