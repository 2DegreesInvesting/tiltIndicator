test_that("works", {
  scenarios <- pstr_new_dataset_scenarios()
  companies <- pstr_new_dataset_companies() |> slice(1)
  expect_s3_class(pstr_new_add_reductions(companies, scenarios), "tbl")
})
