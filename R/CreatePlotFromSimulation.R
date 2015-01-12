
CreatePlotFromSimulation <- structure(
function # Create a plot from a creel survey simulation

  # ##############################################################################
  # File:  CreatePlotFromSimulation.R
  ## author<< Steven H. Ranney
  ## Contact: \email{steven.ranney@gmail.com}
  # Created: 1/10/15
  # Last Edited: 
  ##description<<Generates a plot of either \code{Ehat} or \code{Ehat*catchRateROM}
  ## as a function of \code{trueEffort} or \code{trueCatch}, respectively.
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
    g <- qplot(trueEffort, Ehat, data = dataFrame)
    g <- g + geom_point(colour = color) + labs(ylab("Estimated effort")) +
             labs(xlab("Actual effort"))
  }
  if(value == "catch"){
    g <- qplot(Ehat*catchRateROM, trueCatch, data = dataFrame)
    g <- g + geom_point(colour = color) + labs(ylab("Estimated catch")) +
             labs(xlab("Actual catch"))
  }
  
  return(g)

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
