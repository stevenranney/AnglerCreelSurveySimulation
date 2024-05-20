context("Test of assign_times")

test_that("Test that function fails when no times are provided.", {
  
  expect_error(check_times(start_time = NULL, 
                            end_time = NULL, 
                            wait_time = NULL, 
                            fishing_day_length = 12), 
               "Two of start_time, wait_time, and end_time must be provided.")
  
})

test_that("Test that function fails when no times are provided.", {
  
  expect_error(check_times(start_time = 2, 
                            end_time = 2, 
                            wait_time = 2, 
                            fishing_day_length = NULL), 
               "Please provide value for fishing_day_length.")
  
})


test_that("Test that function fails when only start_time is provided.", {

  expect_error(check_times(start_time = 1, 
                              end_time = NULL, 
                              wait_time = NULL, 
                              fishing_day_length = 12), 
               "Two of start_time, wait_time, and end_time must be provided.")

})

test_that("Test that function fails when only end_time is provided.", {
  
  expect_error(check_times(start_time = NULL, 
                            end_time = 2, 
                            wait_time = NULL, 
                            fishing_day_length = 12), 
               "Two of start_time, wait_time, and end_time must be provided.")
  
})

test_that("Test that function fails when only wait_time is provided.", {
  
  expect_error(check_times(start_time = NULL, 
                            end_time = NULL, 
                            wait_time = 3, 
                            fishing_day_length = 12), 
               "Two of start_time, wait_time, and end_time must be provided.")
  
})

test_that("Test that if start and end are provided, returned wait is expected.", {
  
  start_time <- 2
  end_time <- 6
  
  out <- check_times(start_time = start_time, 
                      end_time = end_time, 
                      wait_time = NULL, 
                      fishing_day_length = 12)
  
  expect_equal(out$wait_time, end_time - start_time)
  
})

test_that("Test that if wait and end are provided, returned start is expected.", {
  
  wait_time <- 2
  end_time <- 6
  
  out <- check_times(start_time = NULL, 
                      end_time = end_time, 
                      wait_time = wait_time, 
                      fishing_day_length = 12)
  
  expect_equal(out$start_time, end_time - wait_time)
  
})

test_that("Test that if start and wait are provided, returned end is expected.", {
  
  start_time <- 2
  wait_time <- 4
  
  out <- check_times(start_time = start_time, 
                      end_time = NULL, 
                      wait_time = wait_time, 
                      fishing_day_length = 12)
  
  expect_equal(out$end_time, start_time + wait_time)
  
})


test_that("Test that end_time does not extend beyond fishing day length.", {
  
  wait_time <- 2
  end_time <- sample(seq(12.01, 20, 0.01), size = 1)
  
  expect_error(check_times(start_time = NULL, 
                            end_time = end_time, 
                            wait_time = wait_time, 
                            fishing_day_length = 12), 
               "end_time cannot be greater than fishing_day_length.")
  
  
})

test_that("Test that calculated end_time does not extend beyond fishing_day_length.", {
  
  start_time <- 9
  wait_time <- 4
  fishing_day_length <- 12
  
  expect_error(check_times(start_time = start_time, 
                            end_time = NULL, 
                            wait_time = wait_time, 
                            fishing_day_length = fishing_day_length), 
               "end_time cannot be greater than fishing_day_length.")
  
  
})