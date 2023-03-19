wrap_rmd <- function(path) {
  tmp_dir <- withr::local_tempdir()
  tmp_rmd <- fs::path(tmp_dir, fs::path_file(path))
  fs::file_copy(path, tmp_rmd)

  withr::local_dir(tmp_dir)
  rmarkdown::render(tmp_rmd, quiet = TRUE)

  csv <- fs::dir_ls(tmp_dir, regexp = "[.]csv")
  nms <- fs::path_ext_remove(fs::path_file(csv))
  out <- lapply(csv, function(x) readr::read_csv(x, show_col_types = FALSE))
  out <- stats::setNames(out, nms)
  out
}
