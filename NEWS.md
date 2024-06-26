
# v1.0.5

* Cleaned up a number of functions, including calculating sampling probability from wait time and circuit length
* Added `check_times.R` to check for missingness on important data
* Added many more unit tests
* Cleaned up cruft

# v1.0.3

* Allow users to pass a `scale` parameter to `make_anglers()` and `get_total_values()` functions.
* Cleaned up some cruft.
* Added more CI build tests 

# v1.0.2.9000

* Added `estimate_ehat_variance()`, useful when trying to determine the accuracy of `Ehat`.

# v1.0.2

* Now I *really* fixed the effort calculations in `get_total_values()`.
* 2018-03-13: Release 1.0.2 submitted to [CRAN](https://cran.r-project.org/package=AnglerCreelSurveySimulation)

# v1.0.1

* Fixed the true effort calculation in `get_total_values()`
* Added error handling to `calculate_rse()`
* Included tests of all functions used during simulating a creel survey

# v1.0.0

* 2018-01-19: Release 1.0.0 submitted to [CRAN](https://cran.r-project.org/)
