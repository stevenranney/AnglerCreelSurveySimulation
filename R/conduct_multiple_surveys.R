
# Created 3/25/14

#' Conduct multiple simulations of a survey
#' 
#' @author Steven H. Ranney
#' 
#' @description This function leverages \code{make_anglers}, \code{get_total_values}, 
#' and \code{simulate_bus_route} to  conduct multiple bus-route or traditional access 
#' point creel surveys (from the number provided to the \code{n_sims} argument) of a 
#' population of anglers.
#' 
#' @return Estimate catch (\eqn{\widehat{E}}), the catch rate calculated by the ratio of means, 
#' the true, observed catch, and the actual catch rate (\eqn{\overline{\lambda}}).
#' 
#' @param n_sims The number of simulations to be conducted in the simulation of interest.
#' @param ... Arguments to be passed to other subfunctions
#' 
#' @details Because this function is merely a wrapper for the \code{\link{simulate_bus_route}}
#' code, the user still needs to set two of \code{start_time}, \code{wait_time}, and \code{end_time},
#' \code{n_anglers}, \code{n_sites}, and \code{fishing_day_length} as objects.  These 
#' can be passed through the \code{...} argument.
#' 
#' @seealso \code{\link{make_anglers}}
#' @seealso \code{\link{check_times}}
#' @seealso \code{\link{get_total_values}}
#' @seealso \code{\link{simulate_bus_route}}
#' 
#' @examples 
#' 
#' #Simulation 1
#' start_time <- c(1, 3.5, 5.75) 
#' wait_time <- c(2, 2, 1) 
#' n_anglers <- c(10,10,50) 
#' n_sites <- 3
#' fishing_day_length <- 12
#' mean_catch_rate <- 3
#' 
#' n_sims <- 10
#' 
#' set.seed(256)
#' 
#' conduct_multiple_surveys(n_sims = n_sims, start_time = start_time, 
#'                          wait_time = wait_time, n_anglers = n_anglers, 
#'                          n_sites = n_sites, mean_catch_rate = mean_catch_rate, 
#'                          fishing_day_length = fishing_day_length)
#' 
#' #Simulation 2
#' start_time <- 0 
#' wait_time <- 8
#' n_anglers <- 100
#' n_sites <- 1
#' fishing_day_length <- 10
#' mean_catch_rate <- 2.5
#' 
#' #One survey/week for a year
#' conduct_multiple_surveys(n_sims = 52, start_time = start_time, 
#'                          wait_time = wait_time, n_anglers = n_anglers, 
#'                          n_sites = n_sites, mean_catch_rate, 
#'                          fishing_day_length = fishing_day_length)
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