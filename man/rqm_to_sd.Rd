% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/transformStats.R
\name{rqm_to_sd}
\alias{rqm_to_sd}
\title{rqm_to_sd}
\usage{
rqm_to_sd(min, LQ, UQ, max, n)
}
\arguments{
\item{min}{Minimum value}

\item{LQ}{Lower 75th quartile}

\item{UQ}{Upper 75th quartile}

\item{max}{Maximum value}

\item{n}{Sample size}
}
\value{
Returns vector of standard deviation
}
\description{
Calculate the standard deviation from box plots
}
\author{
Joel Pick
}
