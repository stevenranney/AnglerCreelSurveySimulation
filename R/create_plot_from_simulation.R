
# Created: 1/10/15

#' Create a plot from a creel survey simulation
#' 
#' @author Steven H. Ranney
#' 
#' @description Generates a plot of either \code{Ehat} or \code{Ehat*catch_rate_ROM}
#'  as a function of \code{true_effort} or \code{true_catch}, respectively.  Adds 
#'  \code{link{lm()}} to the plot and returns the \code{link{summary()}} of the
#'   fitted model.
#'   
#' @param data The data frame from which to draw the \code{Ehat} and \code{true_effort}
#' values
#' @param value The value of interest from the simulation. Other values include 
#' \code{"catch"}
#' @param color The color of the points in the plot, passed to \code{\link{ggplot}}.
#' 
#' @examples
#' 
#' start_time <- 0 
#' wait_time <- 8 
#' n_anglers <- 50 
#' n_sites <- 1
#' sampling_prob <- wait_time/12
#' mean_catch_rate <- 10
#' 
#' tmp <- conduct_multiple_surveys(91, start_time, wait_time, n_anglers, n_sites, sampling_prob, 
#'                                 mean_catch_rate, fishing_day_length = 12, mean_trip_length = 4)
#' 
#' create_plot_from_simulation(tmp, "catch")
#' 
#' @export


create_plot_from_simulation <- function(data, value = "effort",color = "black"){

  library(ggplot2)
  library(dplyr)
  
  if(value == "effort"){
   mod <- lm(Ehat~true_effort, data = data)
   g <- 
     data %>% 
     ggplot2::ggplot(aes(x = true_effort, y = Ehat)) +
     ggplot2::geom_point(colour = color) + 
     ggplot2::labs(x = "Actual effort", y = "Estimated effort") +
     ggplot2::geom_abline(intercept = mod$coefficients[1], slope = mod$coefficients[2], 
                         colour = "red", size = 1.01)
  }
    
  if(value == "catch"){
    mod <- lm((Ehat*catch_rate_ROM)~true_catch, data = data)
    
    g <- 
      data %>%
      ggplot2::ggplot(aes(x = true_catch, y = Ehat*catch_rate_ROM)) +
      ggplot2::geom_point(colour = color) + 
      ggplot2::labs(x = "Actual catch", y = "Estimated catch") +
      ggplot2::geom_abline(intercept = mod$coefficients[1], slope = mod$coefficients[2], 
                  colour = "red", size = 1.01)
  }
  
  print(g)
  return(summary(mod))

  }
