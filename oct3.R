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

cyclical.hat <- predict(arma.best, 12)$pred
cyclical.hat
plot(cyclical.hat)

# Seasonal forecast
fit.seasonal
seas <- fit.seasonal$coefficients
seas
seas[8:12]
seas[2:7]
c(seas[8:12], 0, seas[2:7])
# That is month-specific effect
# Still need the intercept (common effect)
tmp <- -89.6 + c(seas[8:12], 0, seas[2:7])
# Set time series properties
seasonal.hat <- ts(tmp, start=c(2023,8),
                   frequency=12)
seasonal.hat

# Linear trend forecast
fit.trend
length(autos)
752.9-0.6675*679
# 299.6675 is the starting point for our
# forecasts
(1:12)*-0.6675
299.6675 + (1:12)*-0.6675
trend.hat <- ts(299.6675 + (1:12)*-0.6675,
                start=c(2023,8),
                frequency=12)
trend.hat
autos.hat <- trend.hat +
  seasonal.hat + cyclical.hat
autos.hat
plot(autos.hat)
# Let's remove the axis labels and
# add a title
plot(autos.hat, xlab="", ylab="")
plot(autos.hat, xlab="", ylab="",
     main="US Sales of Domestic Autos, 000s Per Month",
     lwd=1.4)
plotdata <- c(window(autos, 
                     start=c(2020,8)),
              autos.hat)
plotdata <- c(window(autos, 
                     start=c(2020,8)),
                     autos.hat)
plotdata <- ts(c(window(autos, 
                     start=c(2020,8)),
                     autos.hat),
               start=c(2020,8),
               frequency=12)
plot(plotdata, xlab="", ylab="",
     main="US Sales of Domestic Autos, 000s Per Month",
     lwd=1.4)
abline(v=2023.6, lty=2, col="orange",
       lwd=2)

# YOY percentage change of autos
dautos <- pctChange(autos, 12)

# Predict dautos using an ARMA
arma.best <- armafit(dautos,
                     ar=6, ma=6,
                     auto=TRUE)
arma.best
dautos.hat <- predict(arma.best,
                      12)$pred
dautos.hat
dautos
# Get the base with the right
# time series properties
base <- window(autos, 
               start=c(2022,8))
base <- ts(base, start=c(2023,8),
           frequency=12)
autos.hat2 <- base * (1+dautos.hat)
ts.combine(autos.hat, autos.hat2)

plotdata <- ts(c(window(autos, 
              start=c(2020,8)),
              autos.hat2),
              start=c(2020,8),
              frequency=12)
plot(plotdata, xlab="", ylab="",
     main="US Sales of Domestic Autos, 000s Per Month",
     lwd=1.4)

