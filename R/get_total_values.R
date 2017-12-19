
get_total_values <- structure(
function # Conduct a creel survey of a population of anglers at a site

  # ##############################################################################
  # File:  GetTotalValues.R
  ## author<< Steven H. Ranney
  ## Contact: \email{sranney@gw-env.com}
  # Created: 12/19/13  
  # Last Edited: 4/9/14 by SHR
  ##description<<This function uses the output from \code{MakeAnglers} to 
  ## conduct a bus-route or traditional access point creel survey of the 
  ## population of anglers from \code{MakeAnglers} and provide clerk-observed
  ## counts of anglers and their effort.
  # Returns: This function returns a dataFrame called 'tmp' of creel survey 
  # metrics sampled from the MakeAnglers function.  
  #
  # TODO: add RData for example
  # TODO: add testing section
  # ##############################################################################

  (data,##<<The dataframe returned from \code{\link{make_anglers()}} 
       ## function
  start_time = NULL, ##<< The start time of the creel clerk at this site 
  end_time = NULL, ##<< The end time of the creel clerk at this site
  wait_time = NULL, ##<< The wait time of the creel clerk at this site
  sampling_prob = 1, ##<<The sampling probability for the survey.  The default is 
                   ## \code{1} but will need to be changed if the survey is conducted
                   ## during only half of the fishing day (\code{.5}) or over 
                   ## longer time periods (e.g., \code{9.5/12}, if the survey is
                   ## 9.5 hours long).
  mean_catch_rate = NULL, ##<< The mean catch rate for the fishery.  
  ... ##<<Arguments to be passed to other functions
  ){
  
  ##details<<Total effort is the sum of the trip lengths from \code{data}.
  t_effort <- sum(data$trip_length)
  
  ##details<<The total number of anglers is equal to the \code{nrow} of the dataframe in \code{data}.
  n_anglers <- nrow(data)

  ##details<<Catch rates are assigned to anglers based upon the Gamma distribution
  ## with a mean of \code{mean_catch_rate}.
  lambda <- rgamma(n_anglers, mean_catch_rate)
  
  #Calculate true total catch for all anglers
  total_catch <- sum(data$trip_length * lambda)  
  
  data$catch <- data$trip_length * lambda
  
  # Obtain a starting time for the surveyor
  
  ##details<<If both \code{end_time=NULL} and \code{wait_time=NULL} then \code{wait_time} 
  ## will be 0.5 (one-half hour).  If a value is passed to \code{end_time}, then 
  ## \code{wait_time} becomes \code{end_time - start_time}.
  
  #Provide a 'standard' wait time of .5 hours for the clerk
  if(is.null(wait_time) & is.null(end_time)){
  wait_time <- 0.5
  }
  
  if(!is.null(end_time)){
  wait_time <- end_time - start_time
  }
  
  ##details<<If \code{start_time=NULL}, then a \code{start_time} is generated from the 
  ## uniform distribution between \code{0} and \code{11.5} hours into the fishing day.
  if(is.null(start_time)){
    start_time <- runif(1, 0, 11.5)
  }
  
  ##details<<If \code{end_time=NULL}, then \code{end_time = start_time+wait_time}
  # how long into the fishing day did the creel clerk arrive?
  if(is.null(end_time)){
    end_time <- start_time + wait_time # how long into the fishing day did the creel clerk depart?
  }
   
  ##details<<Incomplete trip effort is observed two ways: 1) by counting anglers
  ## that were at the site for the entire time that the surveyor was at the site
  ## and 2) counting anglers that arrived after the surveyor arrived at the site
  ## but remained at the site after the surveyor left.  These anglers are counted
  ## and their effort calculated based upon surveyor \code{start_time} and 
  ## \code{end_time}.
  
  ################
  #Effort of anglers that were onsite for the duration of the time that the clerk
  # was onsite
  #How many anglers were at the site the entire time the creel surveyor was there?
  n_anglers_entire_time <- length(which(data$start_time < start_time & data$departure_time > end_time))
  entire_time <- which(data$start_time <= start_time & data$departure_time >= end_time)

  #how long were the anglers that arrived after the creel there before the clerk left?
  if(n_anglers_entire_time > 0){
    entire_time_sum_effort <- n_anglers_entire_time * (wait_time)
  } else {
    entire_time_sum_effort <- 0
  }
  
  ################
  #Effort of anglers that arrived after the clerk arrived and stayed beyond the 
  # clerk's wait time
  #how many anglers arrived while the clerk was on site?
  angler_arrivals <- length(which(data$start_time > start_time & data$start_time < end_time & data$departure_time > end_time))
  arrivals <- which(data$start_time > start_time & data$start_time < end_time & data$departure_time > end_time)

  #how long were the anglers that arrived after the creel there before the clerk left?
  if(angler_arrivals > 0){
    arrival_sum_effort <- sum(end_time - data$start_time[arrivals])
  } else {
    arrival_sum_effort <- 0
  }
  
  ##details<<Completed trip effort is observed two ways: 1) by interviewing anglers 
  ## that left while the surveyor was at the site.  The surveyor can determine
  ## effort and catch.  2) by interviewing anglers that both arrived and departed 
  ## while the surveyor was on site.  When \code{wait_time} is short, these cases are
  ## are rare; however, when \code{wait_time} is long (e.g., all day), then these 
  ## cases are much more likely.
  
  ################
  #Completed trip information; i.e., anglers that LEFT while the creel clerk 
  # was on site
  #Did any anglers depart (complete their trips?) while the creel clerk was there
  #OR did any anglers both arrive AND depart while the clerk was on site?
  angler_departures <- length(which(data$start_time < start_time & (start_time < data$departure_time) & (data$departure_time < end_time)))
  which_angler_departures <- which(data$start_time < start_time & (start_time < data$departure_time) & (data$departure_time < end_time))
  arr_dep <- length(which(data$start_time > start_time & data$departure_time < end_time))
  which_arr_dep <- which(data$start_time > start_time & data$departure_time < end_time)
  completed_trips <- c(which(data$start_time < start_time & data$departure_time < end_time & data$departure_time > start_time), 
                          which(data$start_time > start_time & data$departure_time < end_time))
  
  if((angler_departures + arr_dep) > 0){
    total_completed_trip_effort <- sum(data$trip_length[completed_trips]/sampling_prob)
    total_completed_trip_catch <- sum(data$catch[completed_trips]/sampling_prob)
  } else {
    total_completed_trip_effort <- 0
    total_completed_trip_catch <- 0
  }
  
  #Convert tripLengths
  data$trip_length[entire_time] <- wait_time
  data$trip_length[arrivals] <- end_time - data$start_time[arrivals]
  data$trip_length[which_angler_departures] <- data$departure_time[which_angler_departures] - start_time
  data$trip_length[which_arr_dep]
  
  ##details<<Trip lengths of observed trips (both incomplete and complete) are 
  ## scaled by the \code{sampling_prob} value.  The \code{sampling_prob} is used to estimate
  ## effort and catch.
  
  ##references<<Pollock, K. H., C. M. Jones, and T. L. Brown. 1994. Angler survey 
  ## methods and their applications in fisheries management. American Fisheries 
  ## Society, Special Publication 25, Bethesda, Maryland. 

  #Scale triplength based upon the sampling probability
  data$trip_length_adj <- data$trip_length/sampling_prob
  
  observed_trips <- data$trip_length_adj[c(entire_time,  arrivals, which_angler_departures, which_arr_dep)]
  n_observed_trips <- length(observed_trips)
  total_observed_trip_effort <- sum(observed_trips)
  
  return_df <- 
    data.frame(n_observed_trips = n_observed_trips, 
               total_observed_trip_effort = total_observed_trip_effort, 
               n_completed_trips = sum(angler_departures, arr_dep), 
               total_completed_trip_effort = total_completed_trip_effort, 
               total_completed_trip_catch = total_completed_trip_catch, 
               start_time = start_time, 
               wait_time = wait_time, 
               total_catch = total_catch, 
               true_effort = sum(data$trip_length), 
               mean_lambda = mean(lambda))
  
  return(return_df)
  
  }, ex = function() {
  
  set.seed(256)
    
  start_time = .001 #start of fishing day
  end_time = 12 #end of fishing day
  mean_catch_rate = 0.1 #this will cause VERY few fish to be caught!

  make_anglers(100) %>%  
    get_total_values(start_time = start_time, 
                     end_time = end_time, mean_catch_rate = mean_catch_rate)

  start_time = .001 #start of fishing day
  end_time = 6 #halfway through the fishing day
  sampling_prob = .5 #this needs to be .5 because we are sampling only 50% of the fishing day
  mean_catch_rate = 0.1 #this will cause VERY few fish to be caught!
  
  make_anglers(100) %>%  
    get_total_values(start_time = start_time, end_time = end_time, 
                     sampling_prob = sampling_prob, mean_catch_rate = mean_catch_rate)
  
  })
