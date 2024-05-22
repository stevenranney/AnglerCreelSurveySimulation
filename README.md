
<!-- badges: start -->

[![Lifecycle:experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![Travis-CI Build Status](https://travis-ci.org/stevenranney/AnglerCreelSurveySimulation.svg?branch=master)](https://travis-ci.org/stevenranney/AnglerCreelSurveySimulation)
[![R-CMD-check](https://github.com/stevenranney/AnglerCreelSurveySimulation/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/stevenranney/AnglerCreelSurveySimulation/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/github/stevenranney/AnglerCreelSurveySimulation/branch/master/graphs/badge.svg)](https://codecov.io/github/stevenranney/AnglerCreelSurveySimulation) 
[![License](https://img.shields.io/badge/license-GPL0%28%3E=03%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-3.0.html)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/AnglerCreelSurveySimulation)](https://cran.r-project.org/package=AnglerCreelSurveySimulation)
![](https://cranlogs.r-pkg.org/badges/grand-total/AnglerCreelSurveySimulation?color=brightgreen)

<!--badges: end -->

*Functions to allow fisheries managers to simulate a bus route creel survey*

* [Submit bugs and feature requests](https://github.com/stevenranney/AnglerCreelSurveySimulation/issues)

Creel surveys allow fisheries scientists and managers the ability to sample anglers in a fishery and achieve statistically-valid estimates of catch rate, harvest rate, and in some cases, fish populations.  Depending upon the size of the fishery, creel surveys can be challenging to implement correctly.  Further, creel surveys can be costly.  Much research has been spent on identifying methods for creel surveys.  However, relatively little research time has been spent on answering the question _what is the best creel-survey type to implement in **my** fishery?_  The package(s) and code contained in this repository include functions to allow fisheries managers the ability to simulate a creel survey with *a priori* data.

Install the stable released version of `AnglerCreelSurveySimulation` from CRAN:

```r

install.packages("AnglerCreelSurveySimulation")

```

Or the development version from Github:

```r

devtools::install_github("stevenranney/AnglerCreelSurveySimulation")

```

Additional information:
* `mean_trip_length` and `catch_rate` are estimated from the `gamma` distribution
* The Bus Route Estimator is used to estimate `effort` (Jones and Pollock 2012)
* The Ratio of Means is used to estimate `catch` (Malvestuto 1996; Jones and Pollock 2012)
* Creel surveys can be estimated as a 'one-off' or bus route-type surveys (e.g., multiple stops along a route)
* Simulations can be run to estimate `>= 1` surveys
* Resulting values for estimated catch and estimated effort can be plotted as a function of true catch and true effort to evaluate how accurately the survey reflects reality.

# References 

Jones, C. M., and K. H. Pollock. 2012. Recreational survey 
 methods: estimation of effort, harvest, and released catch. Pages 883-919 
 in A. V. Zale, D. L. Parrish, and T. M. Sutton, editors. Fisheries 
 Techniques, 3rd edition. American Fisheries Society, Bethesda, Maryland.
 
Malvestuto, S. P. 1996. Sampling the recreational creel. Pages 
 591-623 in B. R. Murphy and D. W. Willis, editors. Fisheries techniques, 
 2nd edition. American Fisheries Society, Bethesda, Maryland.
