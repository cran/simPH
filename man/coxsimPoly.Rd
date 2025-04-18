% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coxsimPoly.R
\name{coxsimPoly}
\alias{coxsimPoly}
\title{Simulate quantities of interest for a range of values for a polynomial
nonlinear effect from Cox Proportional Hazards models}
\usage{
coxsimPoly(
  obj,
  b = NULL,
  qi = "Relative Hazard",
  pow = 2,
  Xj = NULL,
  Xl = NULL,
  nsim = 1000,
  ci = 0.95,
  spin = FALSE,
  extremesDrop = TRUE
)
}
\arguments{
\item{obj}{a \code{\link[survival]{coxph}} class fitted model object with a polynomial
coefficient. These can be plotted with \code{\link{simGG}}.}

\item{b}{character string name of the coefficient you would like to simulate.
To find the quantity of interest using only the polynomial and not the
polynomial + the linear terms enter the polynomial created using
\code{\link{I}}, e.g. \code{I(natreg^2)} as a string.}

\item{qi}{quantity of interest to simulate. Values can be
\code{"Relative Hazard"}, \code{"First Difference"}, \code{"Hazard Ratio"},
and \code{"Hazard Rate"}. The default is \code{qi = "Relative Hazard"}. If
\code{qi = "Hazard Rate"} and the \code{coxph} model has strata, then hazard
rates for each strata will also be calculated.}

\item{pow}{numeric polynomial used in \code{coxph}.}

\item{Xj}{numeric vector of fitted values for \code{b} to simulate for.}

\item{Xl}{numeric vector of values to compare \code{Xj} to. If \code{NULL},
then it is automatically set to 0.}

\item{nsim}{the number of simulations to run per value of \code{Xj}. Default
is \code{nsim = 1000}.}

\item{ci}{the proportion of simulations to keep. The default is
\code{ci = 0.95}, i.e. keep the middle 95 percent. If \code{spin = TRUE}
then \code{ci} is the confidence level of the shortest probability interval.
Any value from 0 through 1 may be used.}

\item{spin}{logical, whether or not to keep only the shortest probability
interval rather than the middle simulations. Currently not supported for
hazard rates.}

\item{extremesDrop}{logical whether or not to drop simulated quantity of
interest values that are \code{Inf}, \code{NA}, \code{NaN} and
\eqn{> 1000000} for \code{spin = FALSE} or \eqn{> 800} for \code{spin = TRUE}.
These values are difficult to plot \code{\link{simGG}} and may prevent
\code{spin} from finding the central interval.}
}
\value{
a \code{simpoly}, \code{coxsim} object
}
\description{
\code{coxsimPoly} simulates quantities of interest for polynomial covariate
effects estimated from Cox Proportional Hazards models. These can be plotted
with \code{\link{simGG}}.
}
\details{
Simulates quantities of interest for polynomial covariate effects.
For example if a nonlinear effect is modeled with a second order
polynomial--i.e. \eqn{\beta_{1}x_{i} + \beta_{2}x_{i}^{2}}{\beta[1]x[i] +
\beta[2]x[i]^2}--we can draw \eqn{n} simulations from the
multivariate normal distribution for both \eqn{\beta_{1}}{\beta[1]} and
\eqn{\beta_{2}}{\beta[2]}. Then we simply calculate quantities of interest
for a range of values and plot the results as before. For example, we find
the first difference for a second order polynomial with:
\deqn{\%\triangle h_{i}(t) = (\mathrm{e}^{\beta_{1}x_{j-1} +
\beta_{2}x_{j-l}^{2}} - 1) * 100}{FD(h[i](t)) = exp(\beta[1]x[j-1] +
\beta[2]x[j-l]^2) - 1) * 100}
where \eqn{x_{j-l} = x_{j} - x_{l}}{x[j-l] = x[j] - x[l]}.

Note, you must use \code{\link{I}} to create the polynomials.
}
\examples{
# Load Carpenter (2002) data
data("CarpenterFdaData")

# Load survival package
library(survival)

# Run basic model
M1 <- coxph(Surv(acttime, censor) ~ prevgenx + lethal + deathrt1 +
            acutediz + hosp01  + hhosleng + mandiz01 + femdiz01 +
            peddiz01 + orphdum + natreg + I(natreg^2) +
            I(natreg^3) + vandavg3 + wpnoavg3 +
            condavg3 + orderent + stafcder, data = CarpenterFdaData)

# Simulate simpoly First Difference
Sim1 <- coxsimPoly(M1, b = "natreg", qi = "First Difference",
                pow = 3, Xj = seq(1, 150, by = 5), nsim = 100)

\dontrun{
# Simulate simpoly Hazard Ratio with spin probibility interval
Sim2 <- coxsimPoly(M1, b = "natreg", qi = "Hazard Ratio",
              pow = 3, Xj = seq(1, 150, by = 5), spin = TRUE)
}

}
\references{
Gandrud, Christopher. 2015. simPH: An R Package for Illustrating
Estimates from Cox Proportional Hazard Models Including for Interactive and
Nonlinear Effects. Journal of Statistical Software. 65(3)1-20.

Keele, Luke. 2010. ''Proportionally Difficult: Testing for
Nonproportional Hazards in Cox Models.'' Political Analysis 18(2): 189-205.

Carpenter, Daniel P. 2002. ''Groups, the Media, Agency Waiting Costs, and
FDA Drug Approval.'' American Journal of Political Science 46(3): 490-505.

King, Gary, Michael Tomz, and Jason Wittenberg. 2000. ''Making the Most of
Statistical Analyses: Improving Interpretation and Presentation.'' American
Journal of Political Science 44(2): 347-61.

Liu, Ying, Andrew Gelman, and Tian Zheng. 2013. ''Simulation-Efficient
Shortest Probability Intervals.'' Arvix.
\url{http://arxiv.org/pdf/1302.2142v1}.
}
\seealso{
\code{\link{simGG.simpoly}}, survival,
\code{\link[survival]{strata}}, and \code{\link[survival]{coxph}}
}
