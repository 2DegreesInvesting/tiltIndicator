#' Dictionary of example data
#'
#' This dataset is created from a noramalized set of tables to allow developers
#' to add or change example datasets in a very compact and consistent way.
#'
#' @param remove_id Remove table id's?
#' @keywords internal
#' @export
#' @return A [tibble()].
#' @examples
#' example_dictionary() |> print(n = Inf)
example_dictionary <- memoise(function(remove_id = TRUE) {
  out <- example_id() |>
    left_join(example_column(), by = "column_id") |>
    left_join(example_table(), by = "table_id") |>
    left_join(example_value(), by = "value_id")

  if (remove_id) {
    out <- select(out, -ends_with("_id"))
  }

  out
})

example_table <- function() {
  tribble(
    # styler: off
    ~table_id,      ~table,
           1L, "companies",
           2L, "scenarios",
           3L,  "products",
           4L,    "inputs"
    # styler: on
  )
}

example_value <- function() {
  tribble(
    # styler: off
    ~value_id,   ~value,
           1L,      "a",
           2L,  "total",
           3L, "energy",
           4L,    "ipr",
           5L,   "2050",
           6L,      "1",
           7L,   "'1234'"
    # styler: on
  )
}

example_column <- function() {
  tribble(
    # styler: off
    ~column_id,                 ~aka,                            ~column,
            1L,                "uid",       "activity_uuid_product_uuid",
            2L,            "cluster",                        "clustered",
            3L,       "co2footprint",                    "co2_footprint",
            4L,                 "id",                     "companies_id",
            5L,               "iuid", "input_activity_uuid_product_uuid",
            6L,      "ico2footprint",              "input_co2_footprint",
            7L,              "iisic",                "input_isic_4digit",
            8L,           "itsector",                "input_tilt_sector",
            9L,        "itsubsector",             "input_tilt_subsector",
           10L,              "iunit",                       "input_unit",
           11L,               "isic",                      "isic_4digit",
           12L,          "co2reduce",                       "reductions",
           13L,      "scenario_name",                         "scenario",
           14L,            "xsector",                           "sector",
           15L,         "xsubsector",                        "subsector",
           16L,            "tsector",                      "tilt_sector",
           17L,         "tsubsector",                   "tilt_subsector",
           18L,      "scenario_type",                             "type",
           19L,              "xunit",                             "unit",
           20L,              "xyear",                             "year"
    # styler: on
  )
}

example_id <- function() {
  tribble(
    # styler: off
    ~column_id, ~value_id, ~table_id,
            4L,        1L,        1L,
            2L,        1L,        1L,
            1L,        1L,        1L,
           14L,        2L,        1L,
           15L,        3L,        1L,
           16L,        1L,        1L,
           17L,        1L,        1L,
           18L,        4L,        1L,
           14L,        2L,        2L,
           15L,        3L,        2L,
           20L,        5L,        2L,
           12L,        6L,        2L,
           18L,        4L,        2L,
           13L,        1L,        2L,
            1L,        1L,        3L,
           16L,        1L,        3L,
           19L,        1L,        3L,
           11L,        7L,        3L,
            3L,        6L,        3L,
            1L,        1L,        4L,
            5L,        1L,        4L,
            8L,        1L,        4L,
            9L,        1L,        4L,
           10L,        1L,        4L,
            7L,        7L,        4L,
            6L,        6L,        4L,
           18L,        4L,        4L,
           14L,        2L,        4L,
           15L,        3L,        4L
    # styler: on
  )
}
