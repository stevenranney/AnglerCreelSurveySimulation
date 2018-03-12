context("Simple Make Anglers test")

test_that("nrow() of make_anglers() output is equal to what was given", {
  
  n <- 100
  expect_equal(make_anglers(n_anglers = n) %>% nrow(), n)
})


test_that("no departure time is > fishing_day_length", {
  
  day_length = 10
  anglers <- make_anglers(fishing_day_length = day_length)
  expect_equal(max(anglers$departure_time) < day_length, TRUE)
  
  day_length = 4
  anglers <- make_anglers(fishing_day_length = day_length)
  expect_equal(max(anglers$departure_time) < day_length, TRUE)
  
})

test_that("no start_time is < 0", {
  
  expect_equal(min(make_anglers()$start_time) > 0, TRUE)

})