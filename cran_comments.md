## Test environments
* local Windows7 install, R 3.3.3
* ubuntu 14.04 (on travis-ci): oldrel, release, devel
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE:
  
  * checking dependencies in R code ... NOTE
Namespace in Imports field not imported from: 'R6'

R6 is a build-time dependency.

