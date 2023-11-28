library(tstools)
gas <- import.fred("gas.csv")
dgas <- pctChange(gas)
fit.ar1 <- tsreg(dgas, lags(dgas,1))
fit.ar1
# 1-step
last(dgas)
0.0008999 + 0.4261750*0.0072
# 2-step
0.0008999 + 0.4261750*0.004
fit2 <- tsreg(dgas, lags(dgas,2))
fit2
# Make forecast 2-steps ahead directly
0.00141 - 0.02936*0.0072
fit12 <- tsreg(dgas, lags(dgas,12))
fit12
# Forecast of July 2024
0.001433 + 0.079456*0.0072

# VAR forecast of dgas(T+12)
oil <- import.fred("wti.csv")/42
doil <- pctChange(oil)
fit.var12 <- tsreg(dgas, lags(dgas %~% doil, 12:13))
fit.var12
# Make forecast
last(dgas,2)
last(doil,4)
0.001159 + 0.140836*0.0072 + 0.043676*0.00448 -
  0.002546*0.0765 - 0.088201*-0.0189   
last(gas)
last(oil,3)/42
# Estimate the cointegrating relationship
fit.ci <- tsreg(gas, oil)
fit.ci
# Check how far we're out of equilibrium in July 2023
3.60 - 0.61 - 1.3*1.81
# Calculate deviation from equilibrium in all times
z <- gas - 0.61 - 1.3*oil
# Estimate a VEC model for gas 5 months ahead
fit.vec5 <- tsreg(dgas, lags(dgas %~% doil, 5:6) %~%
                     lags(z, 5))
fit.vec5
0.001420 + 0.128194*0.0072 + 0.026501*0.0048 +
  0.00962*0.0765 - 0.0776*-0.0189 + 0.016*0.637
3.60*1.015
# Not successful at all

# Use hstep to forecast six steps ahead
fit6 <- hstep(dgas, dgas %~% doil, k=2, h=6)
# arg 1: variable to forecast
# arg 2: variables on right side
# k: Number of lags
# h: Forecast horizon
fit6
predict(fit6)
# Six step ahead forecast is -0.00149
tstools::hstep
