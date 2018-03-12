context("calculate_rse() tests")

test_that("calculate_rse() errors with x == NULL", {
  
  x <- NULL
  
  expect_error(calculate_rse(x))
  
  })

test_that("calculate_rse() errors when length(x) < 2)", {
  
  x <- rnorm(1)
  
  expect_error(calculate_rse(x))
  
})

test_that("calculate_rse() returns appropriate output", {
  
  x <- c(2, 4)
  
  expected <- ((sd(x))/sqrt(length(x)))/mean(x)

  expect_equal(calculate_rse(x), expected)
  
})


