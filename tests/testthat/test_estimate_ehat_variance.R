context("Test of estimate_ehat_variance")

test_that("The estimate of ehat variance is > 0", {
  
  start_time = c(0, 1.5)
  wait_time = c(1, 6.5)
  fishing_day_length <- 12
  n_anglers = c(50, 300)
  n_sites = 2
  sampling_prob <- sum(wait_time)/fishing_day_length
  mean_catch_rate <- 2.5
  
  times <- 10
  
  sims <- 
    matrix(data = NA, nrow = times, ncol = 5) %>% 
    as.data.frame()
  
  names(sims) = c("Ehat", "catch_rate_ROM", "true_catch", "true_effort", "mean_lambda")
  
  for(i in 1:times){
    
    sims[i, ] <- simulate_bus_route(start_time = start_time, 
                                    wait_time = wait_time, 
                                    n_anglers = n_anglers, 
                                    n_site = n_sites, 
                                    sampling_prob = sampling_prob,
                                    mean_catch_rate = mean_catch_rate, 
                                    fishing_day_length = fishing_day_length)
    
  }
  
  expect_equal(estimate_ehat_variance(sims) > 0, TRUE)
  
})

