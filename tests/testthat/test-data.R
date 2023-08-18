test_that("`inputs` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::inputs))
})

test_that("`products` has no duplicates in `activity_uuid_product_uuid` (#390)", {
  expect_false(any(duplicated(products$activity_uuid_product_uuid)))
})

test_that("`xstr_scenarios` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::xstr_scenarios))
})

test_that("`istr_inputs` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::istr_inputs))
})

test_that("`istr_companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::istr_companies))
})

test_that("`pstr_companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::pstr_companies))
})
