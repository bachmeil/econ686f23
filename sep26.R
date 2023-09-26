library(tstools)
cars <- import.fred("domestic.csv")
dcars <- pctChange(cars, 12)
# Can't do a regular regression
# epsilons not observed variables
# Need to specify the order
# For MA, first two terms are zero
ma1 <- arima(dcars, order=c(0,0,1))
ma1
# Predict one step ahead
predict(ma1, 1)
# Prediction is 0.057
# Sales predicted to be 5.7% higher
# than Aug 2022 in Aug 2023
predict(ma1, 12)
plot(cars)
ma13 <- arima(dcars, order=c(0,0,13))
predict(ma13, 12)
plot(predict(ma13, 12)$pred)
# Predicts initially good sales
# Then back to the pessimistic
# Long-run pattern
# Make forecast by hand
last(residuals(ma1))
-0.0375 + 0.5574*0.169
# Within rounding error of the
# value calculated with predict
mean(dcars)
# Model selection
# Automate this
# General approach
# Write a function
# q is number of MA lags
# Estimates MA(q)
# Returns AIC for that model
ma.estimate <- function(q) {
  fit <- arima(dcars, order=c(0,0,q))
  AIC(fit)
}
ma.estimate(4)
ma.estimate(5)
lapply(1:15, ma.estimate)
# AIC says to use 13 lags MA(13)

# ARMA(1,1)
# order(AR terms, 0, MA terms)
arma11 <- arima(dcars, order=c(1,0,1))
predict(arma11, 12)
plot(predict(arma11, 12)$pred)
library(forecast)
auto.arima(dcars, max.p=6, max.q=6,
           max.P=0, max.Q=0)
# ARMA(2,1) is the best model
arma.best <- auto.arima(dcars, 
            max.p=6, max.q=6,
            max.P=0, max.Q=0)
predict(arma.best, 12)

rgdp <- import.fred("rgdp.csv")
drgdp <- pctChange(rgdp)
arma.best <- auto.arima(drgdp, 
              max.p=6, max.q=6,
              max.P=0, max.Q=0)
predict(arma.best, 8)
# 0.5% growth per quarter
# 2% annualized growth rate for
# real GDP
plot(predict(arma.best, 8)$pred,
     ylim=c(0,0.01))



