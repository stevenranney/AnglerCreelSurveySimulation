
#' Calculate within-day variance of estimated effort (Ehat)
#' 
#' @author Steven H. Ranney
#' 
#' @description This function multiple outputs from \code{\link{simulate_bus_route}} 
#' to estimate the variance in estimated effort, \eqn{\widehat{E}}.
#' 
#' @return The variance in estimated effort, \code{Ehat} (\eqn{\widehat{E}}), from Robson
#' and Jones (1989) and Jones et al. (1990).
#' 
#' @param data A dataframe of output from \code{\link{simulate_bus_route}}.
#' 
#' @details The variance in \eqn{\widehat{E}} is estimated from multiple simulated surveys
#' on a single theoretical day (Within-day variance of \eqn{\widehat{E}}. The variance is estimated by 
#' 
#' \deqn{\frac{1}{n(n-1)}\sum(\widehat{T}_{ph}-\overline{\widehat{T}}_{ph})^2}
#' 
#' where \eqn{\widehat{T}_{ph}} is the total estimated party hours for an individual survey 
#' (i.e., \eqn{\widehat{E}}), and \eqn{\overline{\widehat{T}}_{ph}} is the mean of the \eqn{\widehat{E}}, 
#' and \emph{n} is how many simulations were run. The equation above matches the variables
#' used in Jones et al. (1990).
#' 
#' Jones et al. (1990) stated that estimating within-day variance would require
#' several crews conducting two or more randomized surveys along a given route on the 
#' same day. They use this conservative estimator of variance for building confidence 
#' intervals around the estimates of effort.
#' 
#' @references Jones, C. M., D. Robson, D. Otis, S. Gloss. 1990. Use of a computer 
#' model to determine the behavior of a new survey estimator of recreational angling.
#' Transactions of the American Fisheries Society 119:41-54.
#' 
#' @references Robson, D., and C. M. Jones. 1989. The theoretical basis of an 
#' access site angler survey design. Biometrics 45:83-98.
#'
#' @examples
#'
#' #Set up a simulation to run repeatedly
#' \dontrun{
#' start_time = c(0, 1.5)
#' wait_time = c(1, 6.5)
#' fishing_day_length <- 12
#' n_anglers = c(50, 300)
#' n_sites = 2
#' sampling_prob <- sum(wait_time)/fishing_day_length
#' mean_catch_rate <- 2.5
#' 
#' # Simulate the creel survey n times
#' times <- 100
#' 
#' sims <- 
#'   matrix(data = NA, nrow = times, ncol = 5) %>% 
#'   as.data.frame()
#' 
#' names(sims) = c("Ehat", "catch_rate_ROM", "true_catch", "true_effort", "mean_lambda")
#' 
#' for(i in 1:times){
#'   
#' sims[i, ] <- simulate_bus_route(start_time, wait_time, n_anglers, n_sites, 
#'                                 sampling_prob, mean_catch_rate)
#'   
#' }
#' 
#' estimate_ehat_variance(sims)
#' }
#' 
#' @export
#'


estimate_ehat_variance <- function(data){
  
  var_est <- var(data$Ehat)
  
  var_est/nrow(data)
  
}
