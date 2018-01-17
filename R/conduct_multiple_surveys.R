
# Created 3/25/14

#' Conduct multiple simulations of a survey
#' 
#' @author Steven H. Ranney
#' 
#' @description This function uses \code{make_anglers} and \code{get_total_values} 
#' to  conduct multiple bus-route or traditional access point creel surveys (from 
#' the number provided to the \code{n_sims} argument) of a population of anglers.
#' 
#' @return Estimate catch (Ehat), the catch rate calculated by the ratio of means, 
#' the true, observed catch, and the actual catch rate (mean_lambda).
#' 
#' @param n_sims The number of simulations to be conducted in the simulation of interest.
#' @param ... Arguments to be passed to other subfunctions
#' 
#' @details Because this function is merely a wrapper for the \code{\link{simulate_bus_route}}
#' code, the user still needs to set \code{start_time}, \code{wait_time}, 
#' \code{n_anglers}, \code{n_sites}, and \code{sampling_prob} as objects.  These 
#' can be passed through the \code{...} argument or through setting \code{wait_time}
#' and others outside of the function call itself.
#' 
#' @seealso \code{\link{make_anglers}}
#' @seealso \code{\link{get_total_values}}
#' @seealso \code{\link{simulate_bus_route}}
#' 
#' @examples 
#' 
#' library(dplyr)
#' #Simulation 1
#' start_time <- c(1, 3.5, 6.5) 
#' wait_time <- c(2, 2, 3) 
#' n_anglers <- c(10,10,50) 
#' n_sites <- 3
#' sampling_prob <- sum(wait_time)/12
#' mean_catch_rate <- 3
#' 
#' n_sims <- 10
#' 
#' set.seed(256)
#' 
#' conduct_multiple_surveys(n_sims = n_sims, start_time = start_time, wait_time = wait_time, 
#'                          n_anglers = n_anglers, n_sites = n_sites, 
#'                          sampling_prob = sampling_prob, mean_catch_rate = mean_catch_rate)
#' 
#' #Simulation 2
#' start_time <- 0 
#' wait_time <- 8
#' n_anglers <- 100
#' n_sites <- 1
#' sampling_prob <- 8/10
#' mean_catch_rate <- 2.5
#' 
#' #One survey/week for a year
#' conduct_multiple_surveys(n_sims = 52, start_time, wait_time, n_anglers, n_sites, sampling_prob, 
#'                          mean_catch_rate, fishing_day_length = 10)
#'                          
#' @export                          


conduct_multiple_surveys <- function(n_sims, ...){ 
    
  
  bus_route <- as.data.frame(matrix(data = NA, ncol = 5, nrow = n_sims, byrow=T))
  names(bus_route) <- c("Ehat", "catch_rate_ROM", "true_catch", "true_effort", "mean_lambda")
  
  for(i in 1:nrow(bus_route)){
    bus_route[i,] <- simulate_bus_route(...)
  }
    
  return(bus_route)
  
  }