library(tstools)
inf <- import.fred("inflation.csv")
plot(inf)
# Estimate a model of inflation
ar1 <- armafit(inf, ar=1)
# Look at the unpredictable part
inf.error <- residuals(ar1)
plot(inf.error)
inf.error2 <- inf.error^2
plot(inf.error2)
# Model of volatility
ar.vol <- armafit(inf.error2, ar=1)
ar.vol

# ARCH model of gas prices
gas <- import.fred("gas.csv")
dgas <- pctChange(gas)
end(dgas)
# rugarch does lots of good stuff
# fGarch is really easy
library(fGarch)
fit <- garchFit(~ garch(1,0), data=dgas)
summary(fit)
# Mean fitted values
# Predictions of change in gas price
fit@fitted
# Get the predicted volatility in sample
fit@h.t
# Convert to time series
volatility <- ts(fit@h.t, end=c(2023,7),
                 frequency=12)
plot(volatility)
# Predict volatility for the future
predict(fit, n.ahead=4)

# More lags
fit <- garchFit(~ garch(4,0), data=dgas)
# ARMA model for mean equation
fit <- garchFit(~ arma(1,0) + garch(1,0),
                data=dgas)
summary(fit)
# ARMA model for mean equation
fit <- garchFit(~ arma(1,0) + garch(1,1),
                data=dgas)
