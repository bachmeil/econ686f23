library(tstools)
library(urca)
rgdp <- import.fred("rgdp.csv")
plot(rgdp)
# Test for a unit root
# If we don't reject H0, treat real GDP
# as nonstationary
df.none <- ur.df(y=rgdp, type="none",
                 selectlags="AIC")
summary(df.none)
# t-stat is +8.2
# Obviously cannot reject H0
df.drift <- ur.df(y=rgdp, 
                  type="drift",
                  selectlags="AIC")
summary(df.drift)
# t-stat is +3.0
# Cannot reject H0
df.trend <- ur.df(y=rgdp, 
                  type="trend",
                  selectlags="AIC")
summary(df.trend)
# t-stat is negative!
# See if we can reject H0
# But is t-stat negative enough?
# Critical value is -3.42
# Not negative enough
# Do not reject H0
# Same conclusion for all three
# Conclude: RGDP has a unit root
# or is nonstationary
# Take the percentage change
drgdp <- pctChange(rgdp)
# Serial correlation messes up
# the test
# ADF test (Augmented DF)
# Used AIC to choose lag length
# To use BIC
df.trend <- ur.df(y=rgdp, 
                  type="trend",
                  selectlags="BIC")
df.trend <- ur.df(y=rgdp, 
                  type="trend",
                  selectlags="Fixed",
                  lags=4)


autos <- import.fred("domestic.csv")
plot(autos)
# There's a time trend
# It's negative
# Regress on a time trend
# Detrended series is the residual
tr <- make.trend(autos)
fit.trend <- tsreg(autos, tr)
autos.notrend <- fit.trend$resids
plot(autos.notrend)

# Remove seasonality (deseasonalize)
dum <- month.dummy(autos.notrend, "Jan")
fit.seasonal <- tsreg(autos.notrend, dum)
autos.cyclical <- fit.seasonal$resids
plot(autos.cyclical)

stepwise.selection(autos.notrend,
                   dum, AIC)
# Stepwise selection w/AIC: Use all
# dummies
stepwise.selection(autos.notrend,
                   dum, BIC)
# W/BIC: Almost all dummies
# Thus, proceed with all of them

# Now model the cyclical component
# Use an ARMA model
# ARMA(3,1)
arma31 <- armafit(autos.cyclical,
                  ar=3, ma=1)
arma31
# To select the model
arma.best <- armafit(autos.cyclical,
                  ar=6, ma=6,
                  auto=TRUE)
arma.best
# ARMA(1,2) is the best model of
# the cyclical component
predict(arma.best, 12)
# Predict terrible sales even
# conditioning on the month
# and downward trend


