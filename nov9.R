# Estimate equilibrium relationship
library(tstools)
gas <- import.fred("gas.csv")
oil <- import.fred("wti.csv")/42
mean(gas)
mean(oil)
eq <- tsreg(gas, oil)
eq
# Is gas price justified by price of
# oil?
last(gas)
last(oil,3)
0.62 + 1.3*1.81
# $3.60 per gallon was not justified
1.57/1.42
# How can we use this information to
# forecast gas prices?

dgas <- pctChange(gas)
doil <- pctChange(oil)
data <- ts.combine(dgas, doil)
# Estimate a VAR model
var.gas <- tsreg(dgas, lags(data, 1))
var.oil <- tsreg(doil, lags(data, 1))
# Estimate a VEC model
z <- eq$resids
vec.gas <- tsreg(dgas, lags(data%~%z, 1))
vec.oil <- tsreg(doil, lags(data%~%z, 1))

vec.gas
3.84/3.6
# Predict change in the price of gas
last(dgas)
last(doil,3)
last(z)
0.001 + 0.20*0.007 + 0.21*0.0765 +
  -0.03*0.63
