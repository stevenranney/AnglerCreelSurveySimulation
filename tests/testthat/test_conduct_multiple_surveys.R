context("Test of conduct_multiple_surveys")

test_that("Conducting n_simulations produces n_sims rows", {
  
  n_sims <- 4
  start_time <- 0
  wait_time <- 8
  fishing_day_length <- 12
  n_anglers <- 100
  n_sites <- 1
  mean_catch_rate <- 4
  sampling_prob <- wait_time/fishing_day_length
  
  vals <- conduct_multiple_surveys(n_sims = n_sims, 
                                   start_time = start_time,
                                   wait_time = wait_time, 
                                   n_anglers = n_anglers, 
                                   n_sites = n_sites, 
                                   sampling_prob = sampling_prob, 
                                   mean_catch_rate = mean_catch_rate,
                                   fishing_day_length = fishing_day_length)
  
  expect_equal(nrow(vals), n_sims)
  
})

