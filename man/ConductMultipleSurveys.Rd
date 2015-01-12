\name{ConductMultipleSurveys}
\alias{ConductMultipleSurveys}
\title{Conduct multiple simulations of a bus-route survey}
\description{This function uses \code{MakeAnglers} and \code{GetTotalValues} 
to  conduct multiple bus-route or traditional access point creel surveys (from
the number provided to the \code{nsims} argument) of a population of anglers.}
\usage{ConductMultipleSurveys(nsims, ...)}
\arguments{
  \item{nsims}{The number of simulations to be conducted in the simulation of interest.}
  \item{\dots}{Arguments to be passed to other subfunctions}
}
\details{Because this function is merely a wrapper for the \code{\link{SimulateBusRoute}}
code, the user still needs to set \code{startTime}, \code{waitTime}, 
\code{nanglers}, \code{nsites}, and \code{samplingProb} as objects.  These 
can be passed through the \code{...} argument or through setting \code{waitTime}
and others outside of the function call itself.}


\author{Steven Ranney}



\seealso{\code{\link{MakeAnglers}}

\code{\link{GetTotalValues}}

\code{\link{SimulateBusRoute}}}
\examples{

#These objects are not used directly in the ConductMultipleSurveys() function
# but will be used in the SimulateBusRoute() function
startTime <- c(1, 2,3,4,5) 
waitTime <- c(.5, .5, .5, .5, 2) 
nanglers <- c(10,10,10,10,50) 
nsites <- 5
samplingProb <- .5
meanCatchRate <- 3

nsims <- 100

tmp <- ConductMultipleSurveys(100, startTime = startTime, waitTime = waitTime, 
                            nanglers = nanglers, nsite = nsites, 
                            samplingProb = samplingProb, meanCatchRate = meanCatchRate)
 

#To change fishingDayLength used in the MakeAnglers function
ConductMultipleSurveys(nsims, startTime, waitTime, nanglers, nsites, samplingProb, 
                       meanCatchRate, fishingDayLength = 9.5)
}
