test_that("with missing obligatory arguments errors gracefully", {
  companies <- pstr_toy_companies()
  ep_weo <- pstr_toy_ep_weo()
  weo <- pstr_toy_weo_2022()

  expect_error(pstr_add_reductions_old(companies, ep_weo = ep_weo), "weo_2022")
  expect_error(pstr_add_reductions_old(companies, weo_2022 = weo_2022), "ep_weo")
  expect_error(pstr_add_reductions_old(ep_weo = ep_weo, weo = weo), "companies")
})

test_that("returns a tibble", {
  companies <- pstr_toy_companies()
  ep_weo <- pstr_toy_ep_weo()
  weo <- pstr_toy_weo_2022()

  out <- pstr_add_reductions_old(companies, ep_weo, weo)

  expect_s3_class(out, "tbl_df")
})

test_that("with pstr_toy_* companies outputs the expected columns", {
  companies <- pstr_toy_companies()
  ep_weo <- pstr_toy_ep_weo()
  weo <- pstr_toy_weo_2022()

  out <- pstr_add_reductions_old(companies, ep_weo, weo)

  expected <- c(
    "company_id",
    "company_name",
    "products",
    "sector",
    "subsector",
    "EP_categories_id",
    "EP_group",
    "weo_product_mapper",
    "weo_flow_mapper",
    "publication",
    "scenario",
    "region",
    "category",
    "unit",
    "year",
    "value",
    "reductions"
  )
  expect_named(out, expected)
})

test_that("additional columns appear in the output", {
  companies <- pstr_toy_companies(x = 1)
  ep_weo <- pstr_toy_ep_weo(y = 1)
  weo <- pstr_toy_weo_2022(z = 1)

  out <- pstr_add_reductions_old(companies, ep_weo, weo)
  expect_true(hasName(out, "x"))
  expect_true(hasName(out, "y"))
  expect_true(hasName(out, "z"))
})

test_that("outputs columns of the same type as in `companies`", {
  companies <- pstr_toy_companies()
  ep_weo <- pstr_toy_ep_weo()
  weo <- pstr_toy_weo_2022()

  out <- pstr_add_reductions_old(companies, ep_weo, weo)

  x <- unname(purrr::map_chr(companies, typeof))
  y <- unname(purrr::map_chr(out[names(companies)], typeof))
  expect_equal(x, y)
})

test_that("with 0-row companies outputs 0 rows", {
  companies <- pstr_toy_companies()
  ep_weo <- pstr_toy_ep_weo()
  weo <- pstr_toy_weo_2022()
  empty <- companies[0L, ]

  out <- pstr_add_reductions_old(empty, ep_weo, weo)

  expect_equal(nrow(out), 0L)
})

test_that("still adds reductions without any products", {
  companies <- pstr_toy_companies()
  ep_weo <- pstr_toy_ep_weo()
  weo <- pstr_toy_weo_2022()
  empty_products <- pstr_toy_companies("products" = NA)

  out <- pstr_add_reductions_old(companies, ep_weo, weo)
  out_1 <- pstr_add_reductions_old(empty_products, ep_weo, weo)

  expect_equal(out$reductions, out_1$reductions)
})
