
# Created: 12/19/13  

#' Conduct a creel survey of a population of anglers at an access site.
#' 
#' @author Steven H. Ranney
#' 
#' @description This function uses the output from \code{make_anglers} to conduct 
#' a bus-route or traditional access point creel survey of the population of anglers 
#' from \code{make_anglers} and provide clerk-observed counts of anglers and their effort.
#' 
#' @param data A dataframe returned from \code{\link{make_anglers}}
#' 
#' @param start_time The start time of the clerk.
#' 
#' @param end_time The end time of the clerk.
#' 
#' @param wait_time The wait time of the clerk.
#' 
#' @param circuit_time The total time it takes a surveyor to complete their sampling circuit.
#' 
#' @param fishing_day_length The length of the fishing day, in hours.
#' 
#' @param mean_catch_rate The mean catch rate for the fishery.
#' 
#' @param scale The scale parameter must be positive and is passed to the \code{\link{rgamma}} function to randomly 
#' generate angler trip lengths
#' 
#' @param ... Arguments to be passed to other functions.
#' 
#' @details Total effort is the sum of the trip lengths from \code{data}
#' 
#' @details The total number of anglers is equal to the \code{nrow()} of the 
#' dataframe in \code{data}
#' 
#' @details Catch rates are assigned to anglers based upon the Gamma distribution 
#' with a mean of \code{mean_catch_rate}
#' 
#' @details If both \code{end_time=NULL} and \code{wait_time=NULL} then \code{wait_time} 
#' will be 0.5 (one-half hour).  If a value is passed to \code{end_time}, then 
#' \code{wait_time} becomes \code{end_time - start_time}.
#' 
#' @details If \code{start_time=NULL}, then a \code{start_time} is generated from the 
#' uniform distribution between \code{0} and \code{fishing_day_length - 0.5} hours into the fishing day.
#' 
#' @details If \code{end_time=NULL}, then \code{end_time = start_time+wait_time}
#' 
#' @details Incomplete trip effort is observed two ways: 1) by counting anglers 
#' that were at the site for the entire time that the surveyor was at the site
#' and 2) counting anglers that arrived after the surveyor arrived at the site
#' and remained at the site after the surveyor left.  These anglers are counted
#' and their effort calculated based upon surveyor \code{start_time} and \code{end_time}.
#' 
#' @details Completed trip effort is observed two ways: 1) by interviewing anglers 
#' that left while the surveyor was at the site.  The surveyor can determine
#' effort and catch.  2) by interviewing anglers that both arrived and departed 
#' while the surveyor was on site.  When \code{wait_time} is short, these cases are
#' are rare; however, when \code{wait_time} is long (e.g., all day), then these 
#' cases are much more likely.
#' 
#' @details Trip lengths of observed trips (both incomplete and complete) are 
#' scaled by the \code{sampling_prob} value.  The \code{sampling_prob} is used to estimate
#' effort and catch.
#' 
#' @references Pollock, K. H., C. M. Jones, and T. L. Brown. 1994. Angler survey 
#' methods and their applications in fisheries management. American Fisheries 
#' Society, Special Publication 25, Bethesda, Maryland. 
#' 
#' @examples 
#' library(dplyr)   
#' set.seed(256)
#'
#' start_time <- .001 #start of fishing day
#' end_time <- 12 #end of fishing day
#' mean_catch_rate <- 0.1 #this will cause VERY few fish to be caught!
#' fishing_day_length <- 12
#' 
#' make_anglers(100) %>%  
#'   get_total_values(start_time = start_time, 
#'                    end_time = end_time, mean_catch_rate = mean_catch_rate
#'                    fishing_day_length = fishing_day_length)
#' 
#' start_time <- .001 #start of fishing day
#' end_time <- 6 #halfway through the fishing day
#' mean_catch_rate <- 0.1 #this will cause VERY few fish to be caught!
#' fishing_day_length <- 12
#' 
#' make_anglers(100) %>%  
#'   get_total_values(start_time = start_time, end_time = end_time, 
#'                    mean_catch_rate = mean_catch_rate, 
#'                    fishing_day_length = fishing_day_length)
#'                    
#' @export
#' @importFrom stats sd rgamma runif
#' @import dplyr ggplot2
#'


get_total_values <- function(data, start_time = NULL, end_time = NULL, 
                             wait_time = NULL, circuit_time = 8, fishing_day_length = NULL, 
                             mean_catch_rate = NULL, scale = 1, ...){
  
  t_effort <- sum(data$trip_length)
  
  n_anglers <- nrow(data)
  
  times <- check_times(start_time = start_time, 
                       end_time = end_time, 
                       wait_time = wait_time, 
                       fishing_day_length = fishing_day_length)


  if(is.null(start_time)) {start_time <- times$start_time}
  if(is.null(end_time)) {end_time <- times$end_time}
  if(is.null(wait_time)) {wait_time <- times$wait_time}
  
  lambda <- rgamma(n = n_anglers, shape = mean_catch_rate, scale = scale)
  
  #Calculate true total catch for all anglers
  total_catch <- sum(data$trip_length * lambda)  
  
  data <- 
    data %>%
    mutate(catch = data$trip_length * lambda)

  sampling_prob <- wait_time/circuit_time
#  print(paste0("sampling_prob = ", sampling_prob))
  
  ################
  #Effort of anglers that were onsite for the duration of the time that the clerk
  # was onsite
  #How many anglers were at the site the entire time the creel surveyor was there?
  n_anglers_entire_time <- length(which(data$start_time <= start_time & data$departure_time >= end_time))
  entire_time <- which(data$start_time <= start_time & data$departure_time >= end_time)

  #how long were the anglers that arrived after the creel there before the clerk left?
  if(n_anglers_entire_time > 0){
    entire_time_sum_effort <- n_anglers_entire_time * (wait_time)
  } else {
    entire_time_sum_effort <- 0
  }
  
  ################
  #Effort of anglers that arrived after the clerk arrived and stayed beyond the 
  # clerk's wait time
  #how many anglers arrived while the clerk was on site?
  angler_arrivals <- length(which(data$start_time > start_time & data$start_time < end_time & data$departure_time > end_time))
  arrivals <- which(data$start_time > start_time & data$start_time < end_time & data$departure_time > end_time)

  #how long were the anglers that arrived after the creel there before the clerk left?
  if(angler_arrivals > 0){
    arrival_sum_effort <- sum(end_time - data$start_time[arrivals])
  } else {
    arrival_sum_effort <- 0
  }
  
  
  ################
  #Completed trip information; i.e., anglers that LEFT while the creel clerk 
  # was on site
  #Did any anglers depart (complete their trips?) while the creel clerk was there
  #OR did any anglers both arrive AND depart while the clerk was on site?
  angler_departures <- length(which(data$start_time < start_time & (start_time < data$departure_time) & (data$departure_time < end_time)))
  which_angler_departures <- which(data$start_time < start_time & (start_time < data$departure_time) & (data$departure_time < end_time))
  arr_dep <- length(which(data$start_time > start_time & data$departure_time < end_time))
  which_arr_dep <- which(data$start_time > start_time & data$departure_time < end_time)
  completed_trips <- c(which(data$start_time < start_time & data$departure_time < end_time & data$departure_time > start_time), 
                          which(data$start_time > start_time & data$departure_time < end_time))
  
  if((angler_departures + arr_dep) > 0){
    total_completed_trip_effort <- sum(data$trip_length[completed_trips]/sampling_prob)
    total_completed_trip_catch <- sum(data$catch[completed_trips]/sampling_prob)
  } else {
    total_completed_trip_effort <- 0
    total_completed_trip_catch <- 0
  }
  
  #Convert tripLengths based upon surveyors start_time and end_time
  data$trip_length[entire_time] <- wait_time
  data$trip_length[arrivals] <- end_time - data$start_time[arrivals]
  data$trip_length[which_angler_departures] <- data$departure_time[which_angler_departures] - start_time
  data$trip_length[which_arr_dep] <- data$departure_time[which_arr_dep] - data$start_time[which_arr_dep]
  data$trip_length[completed_trips] <- data$departure_time[completed_trips] - data$start_time[completed_trips]
  
  

  #Scale triplength based upon the sampling probability
  data <- 
    data %>%
    mutate(trip_length_adj = trip_length/sampling_prob, 
           trip_length_adj = ifelse(trip_length_adj > fishing_day_length, 
                                    fishing_day_length, 
                                    trip_length_adj))
  
  # print(data %>% head(10))
  
  observed_trips <- data$trip_length_adj[c(entire_time,  arrivals, which_angler_departures, which_arr_dep)]
  n_observed_trips <- length(observed_trips)
  total_observed_trip_effort <- sum(observed_trips)
  
  data.frame(n_observed_trips = n_observed_trips, 
             total_observed_trip_effort = total_observed_trip_effort, 
             n_completed_trips = sum(angler_departures, arr_dep), 
             total_completed_trip_effort = total_completed_trip_effort, 
             total_completed_trip_catch = total_completed_trip_catch, 
             start_time = start_time, 
             wait_time = wait_time, 
             total_catch = total_catch, 
             true_effort = t_effort, 
             mean_lambda = mean(lambda)) %>%
    return()
  
  }
