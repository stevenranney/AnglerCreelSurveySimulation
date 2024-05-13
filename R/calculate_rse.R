

#' Calculate the Relative Standard Error of a numeric vector
#' 
#' @author Steven H. Ranney
#' 
#' @description Calculates relative standard error of a vector of numbers. 
#' 
#' @return This function returns a single value that is the relative standard 
#' error of a vector of numbers.
#' 
#' @param x The numeric vector of numbers from which relative standard error 
#' should be calculated.
#' 
#' @details Relative standard error is returned as a proportion.  It is sometimes
#'  also referred to as "proportional standard error."
#'  
#' @details Relative standard error is the standard error divided by the mean:
#' \deqn{Relative Standard Error = \frac{\frac{s}{\sqrt{n}}}{\bar{x}}}
#' 
#' @references Malvestuto, S. P. 1996. Sampling the recreational creel. Pages 
#' 591-623 in B. R. Murphy and D. W. Willis, editors. Fisheries techniques, 
#' 2nd edition. American Fisheries Society, Bethesda, Maryland.
#' 
#' @examples
#' calculate_rse(rnorm(100, 10, 3))
#' 
#' @export

calculate_rse <- function(x){
  
  if(is.null(x) | length(x) < 2){
    stop("Value is either NULL or length(x) is < 2.")
  } else {
    std_error <- sd(x)/sqrt(length(x))
    
    return(std_error/mean(x))
  }
  
  }
