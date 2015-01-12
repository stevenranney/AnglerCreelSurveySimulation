\name{CalculateRSE}
\alias{CalculateRSE}
\title{Create the Relative Standard Error of a numeric vector}
\description{Calculates relative standard error of a vector of numbers.}
\usage{CalculateRSE(x)}
\arguments{
  \item{x}{The numeric vector of numbers from which relative standard error should
calculated}
}
\details{Relative standard error is returned as a proportion.  It is sometimes
also referred to as "proportional standard error."

Relative standard error is the standard error divided by the mean:
\deqn{Relative Standard Error = \fraq{\fraq{s}{\sqrt{n}}}{\bar{x}}}}

\references{Malvestuto, S. P. 1996. Sampling the recreational creel. Pages 
591-623 in B. R. Murphy and D. W. Willis, editors. Fisheries techniques, 
2nd edition. American Fisheries Society, Bethesda, Maryland.}
\author{Steven Ranney}




\examples{

CalculateRSE(rnorm(100, 10, 3))

}
