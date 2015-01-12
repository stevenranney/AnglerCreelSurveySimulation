\name{PlotMultipleObjects}
\alias{PlotMultipleObjects}
\title{Plot multiple ggplots in one window}
\description{This function takes multiple \code{\link{ggplot}} objects and 
puts them in one plot window. }
\usage{PlotMultipleObjects(..., plotlist = NULL, file, cols = 1, layout = NULL)}
\arguments{
  \item{\dots}{The plots to include in the window.}
  \item{plotlist}{If a \code{plotlist} exists, it should be included here.}
  \item{file}{A plot file}
  \item{cols}{How many columns should the window have?}
  \item{layout}{A matrix specifying the layout. If present, 'cols' is ignored..}
}
\details{If the layout is something like \code{matrix(c(1,2,3,3), nrow=2, byrow=TRUE)},
then plot 1 will go in the upper left, 2 will go in the upper right, and
3 will go all the way across the bottom.}


\author{Steven H. Ranney
Contact: \email{Steven.Ranney@gmail.com}
Steven Ranney}





