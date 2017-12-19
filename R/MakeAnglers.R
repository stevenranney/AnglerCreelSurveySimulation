
make_anglers <- structure(
function # Create a population of anglers

  # ##############################################################################
  # File:  MakeAnglers.R
  ## author<< Steven H. Ranney
  ## Contact: \email{sranney@gw-env.com}
  # Created: 12/19/13
  # Last Edited: 12/19/17 by SHR
  ##description<<Creates a population of \code{n_anglers} with trip length and
  ##fishing day length provided by the user.
  # Returns: This function returns a data frame called that includes variables
  # start_time, trip_length, and departure_time. Summing the \code{trip_length} field 
  # returns the true effort.
  #
  # TODO: add RData for example
  # TODO: add testing section
  # ##############################################################################

  (n_anglers = 100,##<<The number of anglers in the population
  mean_trip_length = 3.88, ##<<The mean trip length to be used in the function. 
                        ## \code{3.88} is the default.  The default is from data
                        ## from the 2008 Lake Roosevelt Fishing Evaluation Program.
  fishing_day_length = 12 ##<<The fishing day length to be used in the function.
                        ## Anglers are not be allowed to be fishing past this 
                        ## day length.  The default here is set to 12 hours, which 
                        ## may not be a suitable day length for fisheries at higher
                        ## latitudes (i.e., sunrise-sunset is > 12 hours) or
                        ## during shorter seasons.
  ){

  anglers <- list() # The anglers location, start time, and trip length are
                    # stored in a list, as three seperate vectors, each of equal
                    # length equal to the number of anglers (n_anglers)

  # Give all anglers a start time representing 1 hour into the fishing day
  # and limit their fishing day to fishing_day_length hours long
  
  ##details<<All trip lengths will be limited so that anglers have finished
  ## their fishing trip by the end of the fishing day.  The function uses a 
  ## \code{while} loop to ensure that the number of anglers = \code{n_anglers} 
  ## provided in the function argument.  \code{fishing_day_length} is passed to the 
  ## argument.  The default is set to 12 hours.
  
  i=1
  startTime=tripLength=departureTime=NULL
  while(i <= n_anglers){

  ##details<<\code{starttimes} are assigned by the uniform distribution
    startTime.tmp <- c(runif(1, 0, fishing_day_length - 0.25))

  ##details<<\code{triplengths} are assigned by the gamma distribution where the default mean 
  ## value comes from the 2008 Lake Roosevelt Fisheries Evaluation Program data.
  
    tripLength.tmp <- rgamma(1, mean_trip_length, scale = 1)  
    departureTime.tmp <- startTime.tmp+tripLength.tmp
  
    if(departureTime.tmp < fishing_day_length){
      i=i+1
      startTime <- c(startTime, startTime.tmp)
      tripLength <- c(tripLength, tripLength.tmp)
      departureTime <- c(departureTime, departureTime.tmp)
    }
  }
 
  anglers$start_time <- startTime
  anglers$trip_length <- tripLength
  anglers$departure_time <- departureTime
  
  true_effort <- sum(anglers$trip_length)

  return(anglers %>% 
           bind_cols() %>% 
           as.data.frame())
 
  }, ex = function() {

  make_anglers(100, mean_trip_length = 4, fishing_day_length = 10)
  make_anglers(10000)
  
  })
