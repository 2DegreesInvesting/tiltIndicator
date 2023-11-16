#' @examples
#' tmp <- template_to_rmd("example-emissions-profile.R")
#' writeLines(readLines(tmp))
#' @noRd
template_to_rmd <- function(file) {
  path <- here::here("man/roxygen/templates", file)
  lines <- readLines(path)
  lines <- gsub("@examples", "", lines)
  lines <- gsub("#'", "", lines)
  lines <- trimws(lines)
  tmp <- tempfile(fileext = ".Rmd")
  writeLines(c("```{r}", lines, "```"), tmp)
  tmp
}
