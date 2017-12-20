
create_plot_from_simulation <- structure(
function # Create a plot from a creel survey simulation

  # ##############################################################################
  # File:  CreatePlotFromSimulation.R
  ## author<< Steven H. Ranney
  ## Contact: \email{steven.ranney@gmail.com}
  # Created: 1/10/15
  # Last Edited: 1/14/15 
  ##description<<Generates a plot of either \code{Ehat} or \code{Ehat*catchRateROM}
  ## as a function of \code{trueEffort} or \code{trueCatch}, respectively.  Adds 
  ## \code{link{lm()}} to the plot and returns the \code{link{summary()}} of the
  ## fitted model.
  #
  # TODO: add RData for example
  # TODO: add testing section
  # ##############################################################################

  (data, ##The data frame from which to draw the \code{Ehat} and \code{trueEffort}
              ## values.
  value = "effort", ##The value of interest from the simulation.  Other values include
                   ##\code{"catch"}
  color = "black" ##The color of the points in the plot, passed to \code{\link{ggplot}}.
  ){
  
  library(ggplot2)

  if(value == "effort"){
   mod <- lm(Ehat~true_effort, data = data)
    g <- qplot(true_effort, Ehat, data = data)
    g <- g + geom_point(colour = color) + labs(ylab("Estimated effort")) +
             labs(xlab("Actual effort")) + 
             geom_abline(intercept = mod$coefficients[1], slope = mod$coefficients[2], 
                         colour = "red", size = 1.01)
  }
  if(value == "catch"){
    mod <- lm((Ehat*catch_rate_ROM)~true_catch, data = data)
    g <- qplot(true_catch, Ehat*catch_rate_ROM, data = data)
    g <- g + geom_point(colour = color) + labs(ylab("Estimated catch")) +
             labs(xlab("Actual Catch")) + 
             geom_abline(intercept = mod$coefficients[1], slope = mod$coefficients[2], 
                         colour = "red", size = 1.01)
  }
  
  print(g)
  return(summary(mod))

  }, ex = function() {
  
  start_time <- c(0) 
  wait_time <- c(8) 
  n_anglers <- c(50) 
  n_sites <- 1
  sampling_prob <- sum(wait_time)/12
  mean_catch_rate <- 3

  tmp <- conduct_multiple_surveys(91, start_time, wait_time, n_anglers, n_sites, sampling_prob, 
                                  mean_catch_rate, fishing_day_length = 12, mean_trip_length = 4)
  
  create_plot_from_simulation(tmp, "catch")
  
  })
