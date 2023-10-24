library(tstools)
inf <- import.fred("inflation.csv")
u <- import.fred("unrate.csv")
# AR(1)
# Lag length discussion later
fit <- tsreg(inf, lags(inf,1))

last(inf)
last(u)
# Aug forecast of inflation using AR(1)
fit
0.045 + 0.985*3.3
# ARX with one lag of each
fit.arx <- tsreg(inf, lags(inf %~% u, 1))
# %~% is short for ts.combine
fit.arx
# Compare ARX with AR(1)
last(inf)
last(u,2)
0.095 + 0.985*3.3 - 0.0089*3.5
# Slight change vs AR(1)
# Straightforward extension
# Multiple steps
# Forecast September inflation
# Do this using July data

# Estimate a VAR(1)
fit.inf <- tsreg(inf, lags(inf %~% u, 1))
fit.u <- tsreg(u, lags(inf %~% u, 1))
fit.inf
fit.u

# Forecast inflation(T+2)
`inf(T+1)` <- 0.095 + 0.985*3.3 - 0.0089*3.5
`inf(T+1)`
`u(T+1)` <- 0.14 + 0.01*3.3 + 0.97*3.5
`u(T+1)`
`inf(T+2)` <- 0.095 + 0.985*3.31 - 0.0089*3.57
`inf(T+2)`

# Manageable: T+2, 2 variables, one lag
# In practice, quite tedious
# Let the computer do the work
library(vars)
dataset <- ts.combine(inf, u)
dataset
varfit <- VAR(dataset, p=1)
varfit
# VAR(12)
varfit <- VAR(dataset, p=12)
varfit
# Make a prediction
predict(varfit, n.ahead=2)
# Lag length selection
VARselect(dataset)$selection["AIC(n)"]
# Consider up to 13 lags
VARselect(dataset, lag.max=13)
# Include linear time trend
VARselect(dataset, lag.max=13, type="both")
# No intercept
VARselect(dataset, lag.max=13, type="none")
# No intercept but linear time trend
VARselect(dataset, lag.max=13, type="trend")
# Select the lag length when estimating
# the model
varfit <- VAR(dataset, lag.max=6, ic="AIC")
varfit
predict(varfit, n.ahead=4)

