context("Tests of get_total_values()")

test_that("nrow() of make_anglers() output is equal to what was given", {
  
  anglers <- make_anglers()
  
  wait_time <- 4
  mean_catch_rate = 3
  
  vals <- get_total_values(anglers, wait_time = wait_time, mean_catch_rate = mean_catch_rate)
  
  expect_equal(vals$wait_time , wait_time)
  
  })
