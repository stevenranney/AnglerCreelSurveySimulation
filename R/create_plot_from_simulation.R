
CreatePlotFromSimulation <- structure(
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

  (dataFrame, ##The data frame from which to draw the \code{Ehat} and \code{trueEffort}
              ## values.
  value = "effort", ##The value of interest from the simulation.  Other values include
                   ##\code{"catch"}
  color = "black" ##The color of the points in the plot, passed to \code{\link{ggplot}}.
  ){
  
  library(ggplot2)

  if(value == "effort"){
   mod <- lm(Ehat~trueEffort, data = dataFrame)
    g <- qplot(trueEffort, Ehat, data = dataFrame)
    g <- g + geom_point(colour = color) + labs(ylab("Estimated effort")) +
             labs(xlab("Actual effort")) + 
             geom_abline(intercept = mod$coefficients[1], slope = mod$coefficients[2], 
                         colour = "red", size = 1.01)
  }
  if(value == "catch"){
    mod <- lm((Ehat*catchRateROM)~trueCatch, data = dataFrame)
    g <- qplot(trueCatch, Ehat*catchRateROM, data = dataFrame)
    g <- g + geom_point(colour = color) + labs(ylab("Estimated catch")) +
             labs(xlab("Actual Catch")) + 
             geom_abline(intercept = mod$coefficients[1], slope = mod$coefficients[2], 
                         colour = "red", size = 1.01)
  }
  
  print(g)
  return(summary(mod))

  }, ex = function() {
  
  startTime <- c(0) 
  waitTime <- c(8) 
  nanglers <- c(50) 
  nsites <- 1
  samplingProb <- sum(waitTime)/12
  meanCatchRate <- 3

  tmp <- ConductMultipleSurveys(91, startTime, waitTime, nanglers, nsites, samplingProb, 
                       meanCatchRate, fishingDayLength = 12, meanTripLength = 4)
  
  CreatePlotFromSimulation(tmp, "catch")
  
  })
