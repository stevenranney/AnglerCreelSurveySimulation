context("Test of simulate_bus_route")

test_that("Simulating a bus route provides output", {
  
  start_time <- 0
  wait_time <- 8
  fishing_day_length <- 12
  n_anglers <- 100
  n_sites <- 1
  mean_catch_rate <- 4
  sampling_prob <- wait_time/fishing_day_length
  
  vals <- simulate_bus_route(start_time = start_time, wait_time = wait_time, 
                             n_anglers = n_anglers, n_sites = n_sites, 
                             sampling_prob = sampling_prob, 
                             mean_catch_rate = mean_catch_rate,
                             fishing_day_length = fishing_day_length)
  
  expect_equal(vals$Ehat & vals$catch_rate_ROM & vals$true_catch & vals$true_effort & vals$mean_lambda, TRUE)
  
})

test_that("Simulating a bus route with 0 wait time provides output for only some fields", {
  
  start_time <- 0
  wait_time <- 0
  fishing_day_length <- 12
  n_anglers <- 100
  n_sites <- 1
  mean_catch_rate <- 4
  sampling_prob <- wait_time/fishing_day_length
  
  vals <- simulate_bus_route(start_time = start_time, wait_time = wait_time, 
                             n_anglers = n_anglers, n_sites = n_sites, 
                             sampling_prob = sampling_prob, 
                             mean_catch_rate = mean_catch_rate,
                             fishing_day_length = fishing_day_length)
  
  expect_equal(is.nan(vals$Ehat) & is.nan(vals$catch_rate_ROM), TRUE)
  
})
