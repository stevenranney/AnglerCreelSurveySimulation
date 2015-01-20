
CalculateRSE <- structure(
function # Calculate the Relative Standard Error of a numeric vector

  # ##############################################################################
  # File:  CalculateRSE.R
  ## author<< Steven H. Ranney
  ## Contact: \email{steven.ranney@gmail.com}
  # Created: 1/10/15
  # Last Edited: 
  ##description<<Calculates relative standard error of a vector of numbers.
  # Returns: This function returns a single value that is the relative standard 
  # error of a vector of numbers.
  #
  # TODO: add RData for example
  # TODO: add testing section
  # ##############################################################################

  (x##<<The numeric vector of numbers from which relative standard error should 
    ## calculated
  ){
  
  ##details<<Relative standard error is returned as a proportion.  It is sometimes
  ## also referred to as "proportional standard error."
  
  ##details<<Relative standard error is the standard error divided by the mean:
  ##\deqn{Relative Standard Error = \fraq{\fraq{s}{\sqrt{n}}}{\bar{x}}}
 
  
  ##references<<Malvestuto, S. P. 1996. Sampling the recreational creel. Pages 
  ## 591-623 in B. R. Murphy and D. W. Willis, editors. Fisheries techniques, 
  ## 2nd edition. American Fisheries Society, Bethesda, Maryland.
  
  stdError <- sd(x)/sqrt(length(x))
  
  return(stdError/mean(x))
  
  }, ex = function() {
  
  CalculateRSE(rnorm(100, 10, 3))
  
  })
