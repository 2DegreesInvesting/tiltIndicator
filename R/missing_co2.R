#' Stop the workflow with an error message if data is missing in co2 column
#'
#' @details
#' We can replace/delete the NA values later through this function if needed.
#' For now, it stops the workflow with an error message for user to act upon it.
#'
#' @param data
#'
#' @export
#'
#' @examples
#' data <- demo_ictr_data(input_co2 = c(1, NA))
#' missing_co2(data)
missing_co2 <- function(data) {
  if (anyNA(data$input_co2)) {
    stop("Each `input_co2` must not be missing.")
  }
}
