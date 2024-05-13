
# Created: 12/19/13

#' @title Create a population of anglers.
#' 
#' @author Steven H. Ranney
#' 
#' @description Creates a population of \code{n_anglers} with trip length and fishing day length provided by the user.
#'
#' @param n_anglers The number of anglers in the population
#' 
#' @param mean_trip_length The mean trip length to be used in the function. \code{3.88} 
#' is the default.  The default is from data from the 2008 Lake Roosevelt (WA) Fishing 
#' Evaluation Program.
#'
#' @param fishing_day_length The fishing day length to be used in the function. 
#' Anglers are not be allowed to be fishing past this day length.  The default here 
#' is set to 12 hours, which may not be a suitable day length for fisheries at higher
#' latitudes (i.e., sunrise-sunset is > 12 hours) or during shorter seasons.
#' 
#' @param scale The scale parameter must be positive and is passed to the \code{\link{rgamma}} function to randomly 
#' generate angler trip lengths
#'
#' @details All trip lengths will be limited so that anglers have finished their 
#' fishing trip by the end of the fishing day.  The function uses a \code{while} 
#' loop to ensure that the number of anglers = \code{n_anglers} provided in the 
#' function argument.  \code{fishing_day_length} is passed to the argument. The 
#' default is set to 12 hours.
#'
#' @details \code{starttimes} are assigned by the uniform (\code{\link{runif}}) distribution
#' 
#' @details \code{triplengths} are assigned by the gamma distribution where the 
#' default mean value comes from the 2008 Lake Roosevelt Fisheries Evaluation Program data.
#'
#' @return A data frame called that includes variables \code{start_time}, \code{trip_length}, 
#' and \code{departure_time}. Summing the \code{trip_length} field returns the true 
#' fishing effort.
#'
#' @examples 
#' make_anglers(100, mean_trip_length = 4, fishing_day_length = 10)
#' #make_anglers(10000)
#' 
#' @export

make_anglers <- function(n_anglers = 100,
                         mean_trip_length = 3.88,
                         fishing_day_length = 12, 
                         scale = 1){
  
  i=1
  
  startTime=tripLength=departureTime=NULL
  
  while(i <= n_anglers){

    startTime.tmp <- c(runif(1, 0, fishing_day_length - 0.25))

    tripLength.tmp <- rgamma(1, mean_trip_length, scale = scale)  
    departureTime.tmp <- startTime.tmp+tripLength.tmp
  
    if(departureTime.tmp < fishing_day_length){
      i=i+1
      startTime <- c(startTime, startTime.tmp)
      tripLength <- c(tripLength, tripLength.tmp)
      departureTime <- c(departureTime, departureTime.tmp)
    }
  }
 
  anglers <- 
    data.frame(start_time = startTime, 
               trip_length = tripLength, 
               departure_time = departureTime)
  
  return(anglers)
 
  }
