

# Created: 05/20/24

#' Check that start, wait, or end times for a surveyor are provided and reasonable
#' 
#' @author Steven H. Ranney
#' 
#' @description This is a helper function used in \code{get_total_value} to check that 
#' surveyor for \code{start_time}, \code{wait_time}, or \code{end_time} 
#' are valid. 
#' 
#' @param start_time The start time of the clerk. An \code{int} between 0 and 
#' \code{fishing_day_length}. The default is \code{NULL}.
#' 
#' @param end_time the end time of the clerk. An \code{int} between 0 and 
#' \code{fishing_day_length}. The default is \code{NULL}.
#' 
#' @param wait_time the wait time of the clerk. The default is \code{NULL}. The default is 
#' \code{NULL}
#' 
#' @param circuit_time the total time it takes a surveyor to complete their sampling circuit.
#' 
#' @param fishing_day_length the total length of the fishing day, in hours, as \code{int}. 0800hrs to 2000hrs = 
#' fishing_day_length of 12 hours.
#' 
#' @details Two of the three \code{start_time}, \code{wait_time}, or \code{end_time} must be 
#' provided. The third will be calculated.
#' 
#' @examples 
#' library(dplyr)   
#' set.seed(256)
#'
#' start_time = NULL
#' end_time = NULL
#' wait_time = NULL
#' 
#' assign_generic_wait_time(start_time = start_time, end_time = end_time, wait_time = wait_time, 
#' fishing_day_length = 12)
#' 
#' start_time = 2
#' end_time = NULL
#' wait_time = NULL
#'
#' assign_generic_wait_time(start_time = start_time, end_time = end_time, wait_time = wait_time, 
#' fishing_day_length = 8)
#'                    
#' @export
#' 


check_times <- function(
    start_time = NULL, 
    wait_time = NULL, 
    end_time = NULL, 
    fishing_day_length = NULL){
  
  not_nulls <- sum(c(!is.null(start_time), !is.null(wait_time), !is.null(end_time)))
  
  if(not_nulls < 2){
    stop("Two of start_time, wait_time, and end_time must be provided.", call. = FALSE)
  }
  
  if(is.null(fishing_day_length)){
    stop("Please provide value for fishing_day_length.", call. = FALSE)
  }
  
  if(is.null(start_time)) { 
    start_time <- end_time - wait_time
    }
  if(is.null(wait_time)){
    wait_time <- end_time - start_time
  }
  if(is.null(end_time)){
    end_time <- start_time + wait_time
  }

  if(end_time > fishing_day_length){
    stop("end_time cannot be greater than fishing_day_length.")
  }
  
    return(list("start_time" = start_time, 
              'wait_time' = wait_time, 
              'end_time' = end_time))

  
}