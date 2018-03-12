context("calculate_rse() tests")

test_that("calculate_rse() errors with x == NULL", {
  
  x <- NULL
  
  expect_error(calculate_rse(x))
  
  })

test_that("calculate_rse() errors when length(x) < 2)", {
  
  x <- rnorm(1)
  
  expect_error(calculate_rse(x))
  
})
