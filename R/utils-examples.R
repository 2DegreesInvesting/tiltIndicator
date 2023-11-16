#' @examples
#' tmp <- template_to_rmd("example-emissions_profile.R")
#' writeLines(readLines(tmp))
#' @noRd
template_to_rmd <- function(file) {
  path <- extdata_path(file.path("roxygen/templates", file))
  lines <- readLines(path)
  lines <- gsub("@examples", "", lines)
  lines <- gsub("#'", "", lines)
  lines <- trimws(lines)
  tmp <- tempfile(fileext = ".Rmd")
  writeLines(c("```{r}", lines, "```"), tmp)
  tmp
}


fs::dir_copy("man/roxygen", "inst/extdata/roxygen", overwrite = TRUE)
