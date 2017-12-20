\name{make_anglers}
\alias{make_anglers}
\title{Create a population of anglers}
\description{Creates a population of \code{n_anglers} with trip length and
fishing day length provided by the user.}
\usage{make_anglers(n_anglers = 100, mean_trip_length = 3.88, fishing_day_length = 12)}
\arguments{
  \item{n_anglers}{The number of anglers in the population}
  \item{mean_trip_length}{The mean trip length to be used in the function.
\code{3.88} is the default.  The default is from data
from the 2008 Lake Roosevelt Fishing Evaluation Program.}
  \item{fishing_day_length}{The fishing day length to be used in the function.
Anglers are not be allowed to be fishing past this 
day length.  The default here is set to 12 hours, which 
may not be a suitable day length for fisheries at higher
latitudes (i.e., sunrise-sunset is > 12 hours) or
during shorter seasons.}
}
\details{All trip lengths will be limited so that anglers have finished
their fishing trip by the end of the fishing day.  The function uses a 
\code{while} loop to ensure that the number of anglers = \code{n_anglers} 
provided in the function argument.  \code{fishing_day_length} is passed to the 
argument.  The default is set to 12 hours.

\code{starttimes} are assigned by the uniform distribution

\code{triplengths} are assigned by the gamma distribution where the default mean 
value comes from the 2008 Lake Roosevelt Fisheries Evaluation Program data.}


\author{Steven Ranney}




\examples{

make_anglers(100, mean_trip_length = 4, fishing_day_length = 10)
make_anglers(10000)

}
