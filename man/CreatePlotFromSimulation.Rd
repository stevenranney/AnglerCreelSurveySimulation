\name{CreatePlotFromSimulation}
\alias{CreatePlotFromSimulation}
\title{Create a plot from a creel survey simulation}
\description{Generates a plot of either \code{Ehat} or \code{Ehat*catchRateROM}
as a function of \code{trueEffort} or \code{trueCatch}, respectively.}
\usage{CreatePlotFromSimulation(dataFrame, value = "effort", color = "black")}
\arguments{
  \item{dataFrame}{
}
  \item{value}{
}
  \item{color}{
}
}



\author{Steven Ranney}




\examples{

startTime <- c(0) 
waitTime <- c(8) 
nanglers <- c(50) 
nsites <- 1
samplingProb <- sum(waitTime)/12
meanCatchRate <- 3

tmp <- ConductMultipleSurveys(91, startTime, waitTime, nanglers, nsites, samplingProb, 
                     meanCatchRate, fishingDayLength = 12, meanTripLength = 4)

CreatePlotFromSimulation(tmp, "catch")

}
