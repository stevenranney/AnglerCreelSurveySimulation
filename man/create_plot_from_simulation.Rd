\name{create_plot_from_simulation}
\alias{create_plot_from_simulation}
\title{Create a plot from a creel survey simulation}
\description{Generates a plot of either \code{Ehat} or \code{Ehat*catch_rate_ROM}
as a function of \code{true_effort} or \code{true_catch}, respectively.  Adds 
\code{link{lm()}} to the plot and returns the \code{link{summary()}} of the
fitted model.}
\usage{create_plot_from_simulation(data, value = "effort", color = "black")}
\arguments{
  \item{data}{
}
  \item{value}{
}
  \item{color}{
}
}



\author{Steven Ranney}




\examples{

start_time <- 0 
wait_time <- 8 
n_anglers <- 50 
n_sites <- 1
sampling_prob <- wait_time/12
mean_catch_rate <- 10

tmp <- conduct_multiple_surveys(91, start_time, wait_time, n_anglers, n_sites, sampling_prob, 
                                mean_catch_rate, fishing_day_length = 12, mean_trip_length = 4)

create_plot_from_simulation(tmp, "catch")

}
