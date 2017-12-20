\name{simulate_bus_route}
\alias{simulate_bus_route}
\title{Simulate a bus route survey}
\description{This function uses the output from \code{make_anglers} 
and \code{get_total_values} to  conduct a bus-route or traditional access 
point creel survey of the population of anglers from \code{make_anglers} 
and provide clerk-observed counts of anglers and their effort.}
\usage{simulate_bus_route(start_time, wait_time, n_anglers, n_sites, 
    sampling_prob = 1, mean_catch_rate, ...)}
\arguments{
  \item{start_time}{The start time of the surveyor at each site.  This can be a vector of
start times to simulate a bus route or one \code{startTime} to simulate
a traditional access survey.}
  \item{wait_time}{The wait time of the surveyor at each site.  This can be a vector
of wait times to simulate a bus route or one \code{waitTime} to 
simulate a traditional access survey.}
  \item{n_anglers}{The number of anglers at each site, either a vector or a single
number.}
  \item{n_sites}{How many sites are being visited?}
  \item{sampling_prob}{What is the sampling probability for the survey?  If
all sites will be visited during the first or second half
of the fishing day, \code{samplingProb=0.5}.  If the
survey will take the entire fishing day, then 
\code{samplingProb=1}.}
  \item{mean_catch_rate}{The mean catch rate for the fishery.}
  \item{\dots}{Arguments to be passed to other subfunctions, specifically to the
\code{\link{make_anglers}} function, including \code{mean_trip_length} and 
\code{fishing_day_length}.}
}
\details{Effort and catch are estimated from the the Bus Route Estimator 
equation in Robson and Jones (1989), Jones and Robson (1991) and Pollock 
et al. 1994.

Catch rate is calculated from the Ratio of Means equation (see Malvestuto (1996) and
Jones and Pollock (2012) for discussions).

The Ratio of means is calculated by  
\deqn{\widehat{R_1} = \frac{\sum\limits_{i=1}^n{c_i/n}}{\sum\limits_{i=1}^n{L_i/n}}}

where

\emph{\eqn{c_i}} is the catch for the \emph{\eqn{i^{th}}} sampling unit 

and

\emph{\eqn{L_i}} is the  length of the fishing trip at the time of the interview. 
For incomplete surveys, \emph{\eqn{L_i}} represents in incomplete trip.

The bus route estimator is 
\deqn{\widehat{E} = T\sum\limits_{i=1}^n{\frac{1}{w_{i}}}\sum\limits_{j=1}^m{\frac{e_{ij}}{\pi_{j}}}}


where

\emph{E} = estimated total party-hours of effort;

\emph{T} = total time to complete a full circuit of the route, including travelling and waiting;

\emph{\eqn{w_i}} = waiting time at the \emph{\eqn{i^{th}}} site (where \emph{i} = 1, ..., \emph{n} sites); 

\emph{\eqn{e_{ij}}} = total time that the \emph{\eqn{j^{th}}} car is parked at the \emph{\eqn{i^{th}}} site while the agent is at
that site (where \emph{j} = 1, ..., \emph{n} sites).
}

\references{Jones, C. M., and D. Robson. 1991. Improving precision in angler surveys:
traditional access design versus bus route design. American Fisheries Society
Symposium 12:177-188.

Jones, C. M., and K. H. Pollock. 2012. Recreational survey 
methods: estimation of effort, harvest, and released catch. Pages 883-919 
in A. V. Zale, D. L. Parrish, and T. M. Sutton, editors. Fisheries 
Techniques, 3rd edition. American Fisheries Society, Bethesda, Maryland.

Malvestuto, S. P. 1996. Sampling the recreational creel. Pages 
591-623 in B. R. Murphy and D. W. Willis, editors. Fisheries techniques, 
2nd edition. American Fisheries Society, Bethesda, Maryland.

Pollock, K. H., C. M. Jones, and T. L. Brown. 1994. Angler survey 
methods and their applications in fisheries management. American Fisheries 
Society, Special Publication 25, Bethesda, Maryland.

Robson, D., and C. M. Jones. 1989. The theoretical basis of an access 
site angler survey design. Biometrics 45:83-98.}
\author{Steven Ranney}



\seealso{\code{\link{make_anglers}}

\code{\link{get_total_values}}}
\examples{

# To simulate one bus route survey that takes place in the morning, these values are used
#start time at access sites
startTimeAM <- c(1, 2,3,4,5) 
#wait time at access sites
waitTimeAM <- c(.5, .5, .5, .5, 2) 
#the number of anglers that will visit access site throughout the day
nanglersAM <- c(10,10,10,10,50) 
# the number of sites to be visited
nsitesAM <- 5
# the sampling probability.  Here it is .5 because we are only conducting this 
# survey during the first 50\% of the fishing day
sampling_prob <- .5
# the mean catch rate.  Here it is 2.5 which equals 2.5 fish/hour
mean_catch_rate <- 2.5

simulate_bus_route(start_time = startTimeAM, wait_time = waitTimeAM, n_anglers = nanglersAM, 
                   n_sites = nsitesAM, sampling_prob = sampling_prob, mean_catch_rate = mean_catch_rate)

# To simulate one traditional access point survey where the creel clerk arrives, 
# counts anglers, and interviews anglers that have completed their trips
start_time = 0.001 
wait_time = 8
#nanglers can be informed by previously-collected data
n_anglers = 1000 
n_sites = 1
# sampling probability here is 8/12 because we are staying at the access site
# for 8 hours of a 12-hour fishing day.  To adjust the fishing day length, an
# additional 'fishing_day_length' argument needs to be passed to this function.
sampling_prob <- (8/12)
# the mean catch rate.
mean_catch_rate <- 5

simulate_bus_route(start_time, wait_time, n_anglers, n_sites, sampling_prob, mean_catch_rate)
  
}
