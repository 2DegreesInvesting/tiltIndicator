# Avoid R CMD Check warning about undocumented data sets. See `?e`.
e <- new.env()

e$deprecate_stop <- function(new,
                              old,
                              when,
                              package = e$toy_package()) {
  if(e$on_rcmd()) return(invisible(new))

  stop(sprintf(
    "`%s` was deprecated in %s. Please use `%s` from %s.",
    old, when, new, package
  ), call. = FALSE)

  invisible(new)
}

e$toy_package <- function() {
  "tiltToyData"
}

e$on_rcmd <- function() {
  nzchar(Sys.getenv("R_CMD"))
}

e$when <- "tiltIndicator 0.0.0.9089"

delayedAssign("companies", value = {
  "emissions_profile_any_companies" |>
    e$deprecate_stop("companies", when = e$when)
})

delayedAssign("products", value = {
  "emissions_profile_products_ecoinvent" |>
    e$deprecate_stop("products", when = e$when)
})

delayedAssign("inputs", value = {
  "emissions_profile_upstream_products_ecoinvent" |>
    e$deprecate_stop("inputs", when = e$when)
})

delayedAssign("pstr_companies", value = {
  "sector_profile_companies" |>
    e$deprecate_stop("pstr_companies", when = e$when)
})

delayedAssign("istr_companies", value = {
  "sector_profile_upstream_companies" |>
    e$deprecate_stop("istr_companies", when = e$when)
})

delayedAssign("istr_inputs", value = {
  "sector_profile_upstream_products" |>
    e$deprecate_stop("istr_inputs", when = e$when)
})

delayedAssign("xstr_scenarios", value = {
  "sector_profile_any_scenarios" |>
    e$deprecate_stop("xstr_scenarios", when = e$when)
})
