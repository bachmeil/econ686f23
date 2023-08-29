library(tstools)

# import.fred loads data
# Adds ts properties
gas <- import.fred("gas.csv")
plot(gas)
mean(gas)
# 1992 is not relevant to today
mean(window(gas, start=c(2013,1)))
# 2.87 is "normal" in this time period
# Reasonable going out far enough
# Into the future

# Naive or random walk
last(gas)
# 3.60 is the forecast
# Probably works well in short run

# Forecast Sep 2023
# Using naive seasonal
tsobs(gas, c(2022, 9))

# Seasonal average
# Last five years for September
mean(c(tsobs(gas, c(2022, 9)),
  tsobs(gas, c(2021, 9)),
  tsobs(gas, c(2020, 9)),
  tsobs(gas, c(2019, 9)),
  tsobs(gas, c(2018, 9))))
# 2.90 is the forecast
dgas <- pctChange(gas)
plot(dgas)
tsobs(dgas, c(2022, 9))
# Fell in Sep 2022 from Aug 2022
mean(window(dgas, start=c(2022,1)))
# On average, doesn't change

# Real GDP
rgdp <- import.fred("rgdp.csv")
plot(rgdp)
drgdp <- pctChange(rgdp)
plot(drgdp)
mean(drgdp)
mean(window(drgdp, start=c(2000,1)))
# Drift model: Drifts upward
# over time