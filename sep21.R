library(tstools)
rgdp <- import.fred("rgdp.csv")
drgdp <- pctChange(rgdp)
plot(drgdp)
drgdp.pre <- window(drgdp, c(2010,1),
                    c(2019,4))
plot(drgdp.pre)
mean(drgdp.pre)
# After plotting, use abline
abline(a=0.006, b=0)
# acf gives autocorrelations
ac <- acf(drgdp,1)
ac$acf
ac <- acf(drgdp,2)
ac$acf
# Look at correlations back 3 years
ac <- acf(drgdp,12)
ac$acf

lags(drgdp,0:2)
# Autocorrelation function said two quarters
# held the useful information
# Estimate a second-order autoregression
# AR(2)
ar2 <- tsreg(drgdp, lags(drgdp,1:2))
ar2
last(drgdp,2)
0.006 + 0.1*0.005 + 0.11*0.006

# To forecast multiple steps ahead
# Use an iterative process
0.006 + 0.1*0.00716 + 0.11*0.005
# Forecast for 2023Q4 is 0.007266

# Look at domestic auto sales
cars <- import.fred("domestic.csv")
plot(cars)
dcars <- pctChange(cars, 12)
plot(dcars)
ac <- acf(dcars, 36)
ac$acf

ar2 <- tsreg(dcars, lags(dcars,1:2))
ar2
# Knowing what happened last month
# tells us most of the predictable
# part of this series
ar6 <- tsreg(dcars, lags(dcars,1:6))
ar6
ar1 <- tsreg(dcars, lags(dcars,1))
ar2 <- tsreg(dcars, lags(dcars,1:2))
ar3 <- tsreg(dcars, lags(dcars,1:3))
ar4 <- tsreg(dcars, lags(dcars,1:4))
ar5 <- tsreg(dcars, lags(dcars,1:5))
ar6 <- tsreg(dcars, lags(dcars,1:6))
AIC(ar1)
AIC(ar2)
AIC(ar3)
AIC(ar4)
AIC(ar5)
AIC(ar6)
# AIC says forecast with an AR(2) model