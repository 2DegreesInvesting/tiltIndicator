test_that("check_matches_name() handles multiple matches (#762)", {
  expect_no_error(check_matches_name(tibble(x = 1, xx = 1), "x"))
})
