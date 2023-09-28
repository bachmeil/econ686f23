gas.raw <- read.csv("dailygas.csv",
                    header=FALSE)
head(gas.raw)
# Tell it we want the first column
# Necessary even though there is only one
# There could be many variables
gas <- ts(gas.raw[,1], start=1,
          frequency=1)
# Treating each day as one observation
plot(gas)

# Forecast one and two days ahead
# Is this series predictable?
library(tstools)
dgas <- pctChange(gas)
plot(dgas)

fit <- armafit(dgas, ar=2, ma=2)
fit
sd(dgas)

# Data for the forecast
last(dgas, 2)
last(residuals(fit), 2)
-0.8946*(-0.02385) - 0.787*(-0.0138) +
  0.9165*(-0.0246) + 0.8229*(-0.0146)
# Prediction for Tuesday
# -0.24%
# SD is 2.7%

# Predict T+2 (Wednesday)
-0.8946*(-0.00236343) - 0.787*(-0.02385) +
  0.9165*(0) + 0.8229*(-0.0246)
# Basically zero
# Future value of the variable
# Plug in the forecast
# Future value of the residual
# Plug in zero


plot(residuals(fit))