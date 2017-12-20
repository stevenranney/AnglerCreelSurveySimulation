\name{get_total_values}
\alias{get_total_values}
\title{Conduct a creel survey of a population of anglers at an access site}
\description{This function uses the output from \code{MakeAnglers} to 
conduct a bus-route or traditional access point creel survey of the 
population of anglers from \code{MakeAnglers} and provide clerk-observed
counts of anglers and their effort.}
\usage{get_total_values(data, start_time = NULL, end_time = NULL, wait_time = NULL, 
    sampling_prob = 1, mean_catch_rate = NULL, ...)}
\arguments{
  \item{data}{The dataframe returned from \code{\link{make_anglers}}
function}
  \item{start_time}{The start time of the creel clerk at this site}
  \item{end_time}{The end time of the creel clerk at this site}
  \item{wait_time}{The wait time of the creel clerk at this site}
  \item{sampling_prob}{The sampling probability for the survey.  The default is
\code{1} but will need to be changed if the survey is conducted
during only half of the fishing day (\code{.5}) or over 
longer time periods (e.g., \code{9.5/12}, if the survey is
9.5 hours long).}
  \item{mean_catch_rate}{The mean catch rate for the fishery.}
  \item{\dots}{Arguments to be passed to other functions}
}
\details{Total effort is the sum of the trip lengths from \code{data}.

The total number of anglers is equal to the \code{nrow} of the dataframe in \code{data}.

Catch rates are assigned to anglers based upon the Gamma distribution
with a mean of \code{mean_catch_rate}.

If both \code{end_time=NULL} and \code{wait_time=NULL} then \code{wait_time} 
will be 0.5 (one-half hour).  If a value is passed to \code{end_time}, then 
\code{wait_time} becomes \code{end_time - start_time}.

If \code{start_time=NULL}, then a \code{start_time} is generated from the 
uniform distribution between \code{0} and \code{11.5} hours into the fishing day.

If \code{end_time=NULL}, then \code{end_time = start_time+wait_time}

Incomplete trip effort is observed two ways: 1) by counting anglers
that were at the site for the entire time that the surveyor was at the site
and 2) counting anglers that arrived after the surveyor arrived at the site
but remained at the site after the surveyor left.  These anglers are counted
and their effort calculated based upon surveyor \code{start_time} and 
\code{end_time}.

Completed trip effort is observed two ways: 1) by interviewing anglers 
that left while the surveyor was at the site.  The surveyor can determine
effort and catch.  2) by interviewing anglers that both arrived and departed 
while the surveyor was on site.  When \code{wait_time} is short, these cases are
are rare; however, when \code{wait_time} is long (e.g., all day), then these 
cases are much more likely.

Trip lengths of observed trips (both incomplete and complete) are 
scaled by the \code{sampling_prob} value.  The \code{sampling_prob} is used to estimate
effort and catch.}

\references{Pollock, K. H., C. M. Jones, and T. L. Brown. 1994. Angler survey 
methods and their applications in fisheries management. American Fisheries 
Society, Special Publication 25, Bethesda, Maryland. }
\author{Steven Ranney}




\examples{

library(dplyr)
  
set.seed(256)
  
start_time = .001 #start of fishing day
end_time = 12 #end of fishing day
mean_catch_rate = 0.1 #this will cause VERY few fish to be caught!

make_anglers(100) \%>\%  
  get_total_values(start_time = start_time, 
                   end_time = end_time, mean_catch_rate = mean_catch_rate)

start_time = .001 #start of fishing day
end_time = 6 #halfway through the fishing day
sampling_prob = .5 #this needs to be .5 because we are sampling only 50\% of the fishing day
mean_catch_rate = 0.1 #this will cause VERY few fish to be caught!

make_anglers(100) \%>\%  
  get_total_values(start_time = start_time, end_time = end_time, 
                   sampling_prob = sampling_prob, mean_catch_rate = mean_catch_rate)

}
