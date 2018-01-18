context("Simple Make Anglers test")

test_that("nrow() of make_anglers() output is equal to what was given", {
  
  n <- 100
  expect_equal(make_anglers(n_anglers = n) %>% nrow(), n)
})