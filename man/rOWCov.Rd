\name{rOWCov}
\Rdversion{1.1}
\alias{rOWCov}
\title{Realized Outlyingness Weighted Covariance}

\description{
Function returns the Realized Outlyingness Weighted Covariance, defined in Boudt et al. (2008).

Let \eqn{r_{t,i}}, for \eqn{i=1,...,M} be a sample
of \eqn{M} high-frequency \eqn{(N x 1)} return vectors and \eqn{d_{t,i}}
their outlyingness given by the squared Mahalanobis distance between
the return vector and zero in terms of the reweighted MCD covariance
estimate based on these returns.

Then, the rOWCov is given by
\deqn{
\mbox{rOWCov}_{t}=c_{w}\frac{\sum_{i=1}^{M}w(d_{t,i})r_{t,i}r'_{t,i}}{\frac{1}{M}\sum_{i=1}^{M}w(d_{t,i})},
}
The weight  \eqn{w_{i,\Delta}} is one if the multivariate jump test statistic for \eqn{r_{i,\Delta}} in Boudt et al. (2008) is less 
than the 99.9\% percentile of the chi-square distribution with \eqn{N} degrees of freedom and zero otherwise. 
The scalar \eqn{c_{w}} is a correction factor ensuring consistency of the rOWCov for the Integrated Covariance, 
under the Brownian Semimartingale with Finite Activity Jumps model. 
}

\usage{
rOWCov(rdata, cor = FALSE, align.by = NULL, align.period = NULL, 
       makeReturns = FALSE, seasadjR = NULL, wfunction = "HR", alphaMCD = 0.75, 
       alpha = 0.001, ...) 
}

\arguments{
  \item{rdata}{ a \eqn{(M x N)} matrix/zoo/xts object containing the \eqn{N}
return series over period \eqn{t}, with \eqn{M} observations during \eqn{t}.}
  \item{cor}{ boolean, in case it is TRUE, the correlation is returned. FALSE by default.}
  \item{align.by}{a string, align the tick data to "seconds"|"minutes"|"hours".}
  \item{align.period}{an integer, align the tick data to this many [seconds|minutes|hours].}  
  \item{makeReturns}{boolean, should be TRUE when rdata contains prices instead of returns. FALSE by default.}
  \item{seasadjR}{ a \eqn{(M x N)} matrix/zoo/xts object containing 
the seasonaly adjusted returns. This is an optional argument.}
   \item{wfunction}{ determines whether 
a zero-one weight function (one if no jump is detected based on \eqn{d_{t,i}} and 0 otherwise)
or 
Soft Rejection ("SR") weight function is to be used.
By default a zero-one weight function (wfunction = "HR") is used.}
   \item{alphaMCD}{ a numeric parameter, controlling the size of 
the subsets over which the determinant is minimized. 
Allowed values are between 0.5 and 1 and 
the default is 0.75. See Boudt et al. (2008) or the \code{covMcd} function in the
robustbase package.}
   \item{alpha}{ is a parameter between 0 en 0.5, 
that determines the rejection threshold value 
(see Boudt et al. (2008) for details).}
\item{...}{additional arguments.}
}

\value{
an \eqn{N x N} matrix
}

\details{
Advantages of the rOWCov compared to the \code{\link{rBPCov}} include a higher statistical efficiency, positive semidefiniteness and affine equivariance.
However, the rOWCov suffers from a curse of dimensionality.
Indeed, the rOWCov gives a zero weight to a return vector
if at least one of the components is affected by a jump.
In the case of independent jump occurrences, the average proportion of observations
with at least one component being affected by jumps increases fast with the dimension
of the series. This means that a potentially large proportion of the returns receives
a zero weight, due to which the rOWCov can have a low finite sample efficiency in higher dimensions
}

\references{
Boudt, K., C. Croux, and S. Laurent (2008). Outlyingness weighted covariation. Mimeo.
}

\author{Jonathan Cornelissen and Kris Boudt}

\examples{
 # Realized Outlyingness Weighted Variance/Covariance for CTS aligned   
 # at 5 minutes.
 data(sample_tdata); 
 data(sample_5minprices_jumps);
 
 # Univariate: 
 rvoutw = rOWCov( rdata = sample_tdata$PRICE, align.by ="minutes", 
                    align.period =5, makeReturns=TRUE); 
 rvoutw 
 
 # Multivariate: 
 rcoutw = rOWCov( rdata = sample_5minprices_jumps['2010-01-04'], makeReturns=TRUE); 
 rcoutw
}

\keyword{volatility}
