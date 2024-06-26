% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_total_values.R
\name{get_total_values}
\alias{get_total_values}
\title{Conduct a creel survey of a population of anglers at an access site.}
\usage{
get_total_values(
  data,
  start_time = NULL,
  end_time = NULL,
  wait_time = NULL,
  circuit_time = 8,
  fishing_day_length = NULL,
  mean_catch_rate = NULL,
  scale = 1,
  ...
)
}
\arguments{
\item{data}{A dataframe returned from \code{\link{make_anglers}}}

\item{start_time}{The start time of the clerk.}

\item{end_time}{The end time of the clerk.}

\item{wait_time}{The wait time of the clerk.}

\item{circuit_time}{The total time it takes a surveyor to complete their sampling circuit.}

\item{fishing_day_length}{The length of the fishing day, in hours.}

\item{mean_catch_rate}{The mean catch rate for the fishery.}

\item{scale}{The scale parameter must be positive and is passed to the \code{\link{rgamma}} function to randomly 
generate angler trip lengths}

\item{...}{Arguments to be passed to other functions.}
}
\description{
This function uses the output from \code{make_anglers} to conduct 
a bus-route or traditional access point creel survey of the population of anglers 
from \code{make_anglers} and provide clerk-observed counts of anglers and their effort.
}
\details{
Total effort is the sum of the trip lengths from \code{data}

The total number of anglers is equal to the \code{nrow()} of the 
dataframe in \code{data}

Catch rates are assigned to anglers based upon the Gamma distribution 
with a mean of \code{mean_catch_rate}

If both \code{end_time=NULL} and \code{wait_time=NULL} then \code{wait_time} 
will be 0.5 (one-half hour).  If a value is passed to \code{end_time}, then 
\code{wait_time} becomes \code{end_time - start_time}.

If \code{start_time=NULL}, then a \code{start_time} is generated from the 
uniform distribution between \code{0} and \code{fishing_day_length - 0.5} hours into the fishing day.

If \code{end_time=NULL}, then \code{end_time = start_time+wait_time}

Incomplete trip effort is observed two ways: 1) by counting anglers 
that were at the site for the entire time that the surveyor was at the site
and 2) counting anglers that arrived after the surveyor arrived at the site
and remained at the site after the surveyor left.  These anglers are counted
and their effort calculated based upon surveyor \code{start_time} and \code{end_time}.

Completed trip effort is observed two ways: 1) by interviewing anglers 
that left while the surveyor was at the site.  The surveyor can determine
effort and catch.  2) by interviewing anglers that both arrived and departed 
while the surveyor was on site.  When \code{wait_time} is short, these cases are
are rare; however, when \code{wait_time} is long (e.g., all day), then these 
cases are much more likely.

Trip lengths of observed trips (both incomplete and complete) are 
scaled by the \code{sampling_prob} value.  The \code{sampling_prob} is used to estimate
effort and catch.
}
\examples{
library(dplyr)   
set.seed(256)

start_time <- .001 #start of fishing day
end_time <- 12 #end of fishing day
mean_catch_rate <- 0.1 #this will cause VERY few fish to be caught!
fishing_day_length <- 12

make_anglers(100) \%>\%  
  get_total_values(start_time = start_time, 
                   end_time = end_time, mean_catch_rate = mean_catch_rate,
                   fishing_day_length = fishing_day_length)

start_time <- .001 #start of fishing day
end_time <- 6 #halfway through the fishing day
mean_catch_rate <- 0.1 #this will cause VERY few fish to be caught!
fishing_day_length <- 12

make_anglers(100) \%>\%  
  get_total_values(start_time = start_time, end_time = end_time, 
                   mean_catch_rate = mean_catch_rate, 
                   fishing_day_length = fishing_day_length)
                   
}
\references{
Pollock, K. H., C. M. Jones, and T. L. Brown. 1994. Angler survey 
methods and their applications in fisheries management. American Fisheries 
Society, Special Publication 25, Bethesda, Maryland.
}
\author{
Steven H. Ranney
}
