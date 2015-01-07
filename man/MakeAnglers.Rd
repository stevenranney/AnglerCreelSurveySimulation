\name{MakeAnglers}
\alias{MakeAnglers}
\title{Create a population of anglers}
\description{Creates a population of \code{nanglers} with trip length and
fishing day length provided by the user.}
\usage{MakeAnglers(nanglers = 100, meanTripLength = 3.88, fishingDayLength = 12)}
\arguments{
  \item{nanglers}{The number of anglers in the population}
  \item{meanTripLength}{The mean trip length to be used in the function.
\code{3.88} is the default.  The default is from data
from the 2008 Lake Roosevelt Fishing Evaluation Program.}
  \item{fishingDayLength}{The fishing day length to be used in the function.
Anglers are not be allowed to be fishing past this 
day length.  The default here is set to 12 hours, which 
may not be a suitable day length for fisheries at higher
latitudes (i.e., sunrise-sunset is > 12 hours) or
during shorter seasons.}
}
\details{All trip lengths will be limited so that anglers have finished
their fishing trip by the end of the fishing day.  The function uses a 
\code{while} loop to ensure that the number of angles = \code{nanglers} 
provided in the function argument.  \code{fishingDayLength} is passed to the 
argument.  The default is set to 12 hours.
\code{starttimes} are assigned by the uniform distribution
\code{triplengths} are assigned by the gamma distribution where the default mean 
value comes from the 2008 Lake Roosevelt Fisheries Evaluation Program data.}
\author{Steven Ranney}
\examples{
MakeAnglers(100, meanTripLength = 4, fishingDayLength = 10)
MakeAnglers(10000)
}
