context("Tests of get_total_values()")

test_that("Wait time passed to fx is equal to returned wait time", {
  
  anglers <- make_anglers()
  
  start_time <- 2
  wait_time <- 4
  mean_catch_rate <- 3
  
  vals <- get_total_values(anglers, 
                           start_time = start_time, 
                           wait_time = wait_time, 
                           mean_catch_rate = mean_catch_rate, 
                           fishing_day_length = 12)
  
  expect_equal(vals$wait_time , wait_time)
  
  })

test_that("When wait time is zero, effort, completed trips, and catch is 0", {

  anglers <- make_anglers()

  start_time <- 2
  wait_time <- 0
  mean_catch_rate <- 3

  vals <- get_total_values(anglers,
                           start_time = start_time,
                           wait_time = wait_time,
                           mean_catch_rate = mean_catch_rate,
                           fishing_day_length = 12)

  expect_equal(is.na(vals$total_observed_trip_effort), TRUE)
  expect_equal(vals$n_completed_trips, 0)
  expect_equal(vals$total_completed_trip_effort, 0)
  expect_equal(vals$total_completed_trip_catch, 0)

})

test_that("True effort is the same as the sum of anglers$trip_length", {

  anglers <- make_anglers()

  start_time <- 2
  wait_time <- 2
  mean_catch_rate <- 3

  vals <- get_total_values(anglers,
                           start_time = start_time,
                           wait_time = wait_time,
                           mean_catch_rate = mean_catch_rate,
                           fishing_day_length = 12)

  expect_equal(sum(anglers$trip_length), vals$true_effort)

})
