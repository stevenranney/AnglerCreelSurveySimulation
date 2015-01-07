\name{GetTotalValues}
\alias{GetTotalValues}
\title{Conduct a creel survey of a population of anglers at a site}
\description{This function uses the output from \code{MakeAnglers} to 
conduct a bus-route or traditional access point creel survey of the 
population of anglers from \code{MakeAnglers} and provide clerk-observed
counts of anglers and their effort.}
\usage{GetTotalValues(ang = anglers, teffort = trueeffort, nanglers = length(anglers$starttime), 
    startTime = NULL, endTime = NULL, waitTime = NULL, samplingProb = 1, 
    meanCatchRate = NULL, ...)}
\arguments{
  \item{ang}{This argument renames the output from the \code{MakeAnglers}
function.}
  \item{teffort}{This argument renames the output from the
\code{MakeAnglers} function.}
  \item{nanglers}{Defines the size of the angler population
based upon the length of the \code{anglers}
from the \code{MakeAnglers} function}
  \item{startTime}{The start time of the creel clerk at this site}
  \item{endTime}{The end time of the creel clerk at this site}
  \item{waitTime}{The wait time of the creel clerk at this site}
  \item{samplingProb}{The sampling probability for the survey.  The default is
\code{1} but will need to be changed if the survey is conducted
during only half of the fishing day (\code{.5}) or over 
longer time periods (e.g., \code{9.5/12}, if the survey is
9.5 hours long).}
  \item{meanCatchRate}{The mean catch rate for the fishery.}
  \item{\dots}{Arguments to be passed to other functions}
}
\details{Catch rates are assigned to anglers based upon the Gamma distribution
with a mean of \code{meanCatchRate}.


If both \code{endTime=NULL} and \code{waitTime=NULL} then \code{waitTime} 
will be 0.5 (one-half hour).  If a value is passed to \code{endTime}, then 
\code{waitTime} becomes \code{endTime - startTime}.


If \code{startTime=NULL}, then a \code{startTime} is generated from the 
uniform distribution between \code{0} and \code{11.5} hours into the fishing day.


If \code{endTime=NULL}, then \code{endTime = startTime+waitTime}
Incomplete trip effort is observed two ways: 1) by counting anglers
that were at the site for the entire time that the surveyor was at the site
and 2) counting anglers that arrived after the surveyor arrived at the site
but remained at the site after the surveyor left.  These anglers are counted
and their effort calculated based upon surveyor \code{startTime} and 
\code{endTime}.


Completed trip effort is observed two ways: 1) by interviewing anglers 
that left while the surveyor was at the site.  The surveyor can determine
effort and catch.  2) by interviewing anglers that both arrived and departed 
while the surveyor was on site.  When \code{waitTime} is short, these cases are
are rare; however, when \code{waitTime} is long (e.g., all day), then these 
cases are much more likely.


Trip lengths of observed trips (both incomplete and complete) are 
scaled by the \code{samplingProb} value.  The \code{samplingProb} is used to estimate
effort and catch.}

\references{Pollock, K. H., C. M. Jones, and T. L. Brown. 1994. Angler survey 
methods and their applications in fisheries management. American Fisheries 
Society, Special Publication 25, Bethesda, Maryland. }
\author{Steven Ranney}
\examples{
#The MakeAnglers() function must be run before GetTotalValues(); otherwise, there
# will be no data from which GetTotalValues() can calculate values.
#MakeAnglers(100)
startTime = .001 #start of fishing day
endTime = 12 #end of fishing day
meanCatchRate = 0.1 #this will cause VERY few fish to be caught!
#GetTotalValues()
#MakeAnglers(100)
startTime = .001 #start of fishing day
endTime = 6 #halfway through the fishing day
samplingProb = .5 #this needs to be .5 because we are sampling only 50\% of the fishing day
meanCatchRate = 0.1 #this will cause VERY few fish to be caught!
#GetTotalValues()
}
