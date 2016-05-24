AnglerCreelSurveySimulation
===========

*Functions to allow fisheries managers to simulate a bus route creel survey*

* [Submit bugs and feature requests](https://github.com/stevenranney/AnglerCreelSurveySimulation/issues)

Creel surveys allow fisheries scientists and managers the ability to sample anglers in a fishery and achieve statisticaly-valid estimates of catch rate, harvest rate, and in some cases, fish populations.  Depending upon the size of the fishery, creel surveys can be challenging to implement correctly.  Further, creel surveys can be costly.  Much research has been spent on identifying methods for creel surveys.  However, relatively little research time has been spent on answering the question _what is the best creel-survey type to implement in **my** fishery?_  The package(s) and code contained in this repository include functions to allow fisheries managers the ability to simulate a creel survey with *a priori* data.

A short 'walk through' of the package is available at [Steven-Ranney.com](http://www.stevenranney.com/creelSurveys.html)

To install the stable version of `AnglerCreelSurveySimulation` from CRAN:
```r
install.packages("AnglerCreelSurveySimulation")
```

Install the latest (development) version of `AnglerCreelSurveySimulation` from GitHub with [devtools](https://github.com/hadley/devtools) and the following code:
```r
devtools::install_github("stevenranney/AnglerCreelSurveySimulation")
```
### Changes in the development version

1. The biggest change from `v0.2.1` to `v0.2.2` is that `MakeAnglers()` no longer assigns a variable to a users global environment.  Originally, a `list` was assigned (i.e., `<<-`) to the `R` environment.  That list was used by all of the other functions.  In `v0.2.2`, `MakeAnglers()` returns a data frame rather than assigning a `list` to the environment.
2. Other changes include the addition of the functions `CalculateRSE()` and `CreatePlotFromSimulation()`.  These functions allow for ease of caluclation of the Relative Standard Error from Malvestuto (1996) and to easily plot estimated effort or catch as a function of observed effort and catch.


Additional general package information:
* `meanTripLength` and `catchRate` are estimated from the `gamma` distribution
* The Bus Route Estimator is used to estimate `effort` (Jones and Pollock 2012)
* The Ratio of Means is used to estiate `catch` (Malvestuto 1996; Jones and Pollock 2012)
* Creel surveys can be estimated as a 'one-off' or bus route-type surveys (e.g., multiple stops along a route)
* Simulations can be run to estimate `>= 1` surveys
* Resulting values for estimated catch and estimated effort can be plotted as a function of true catch and true effort to evaluate how accurately the survey reflects reality.

#####References 

Jones, C. M., and K. H. Pollock. 2012. Recreational survey 
 methods: estimation of effort, harvest, and released catch. Pages 883-919 
 in A. V. Zale, D. L. Parrish, and T. M. Sutton, editors. Fisheries 
 Techniques, 3rd edition. American Fisheries Society, Bethesda, Maryland.
 
Malvestuto, S. P. 1996. Sampling the recreational creel. Pages 
 591-623 in B. R. Murphy and D. W. Willis, editors. Fisheries techniques, 
 2nd edition. American Fisheries Society, Bethesda, Maryland.
