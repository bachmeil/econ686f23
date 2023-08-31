library(tstools)
inf <- import.fred("inflation.csv")
lags(inf, 1)
lags(inf, 0:1)
# Wrong way
lag(inf, 1)
# Feb 1948 inflation
tsobs(inf, c(1948,2))
# Correct way
lag(inf, -1)
plot(inf)
# first difference
inf - lags(inf,1)
diff(inf)

rgdp <- import.fred("rgdp.csv")
plot(rgdp)
plot(window(diff(rgdp), 
            end=c(2019,4)))
tsp(rgdp)
# Change 1947:Q1 through 1956:Q4
tsobs(rgdp, c(1956,4))
tsobs(rgdp, c(1947,1))
2975.209 - 2034.45

tsobs(rgdp, c(2019,4))
tsobs(rgdp, c(2010,1))
19215.69 - 15456.06
# First difference not meaningful
# Take percentage change
drgdp <- pctChange(rgdp)
plot(drgdp)

harvest <- c(150,145,55,70,180,150)
rain <- c(30,32,18,24,38,32)
plot(rain,harvest)
# Add line to the plot
abline(a=0,b=10)
abline(a=-120,b=10)
abline(a=-120,b=8)
abline(a=-75,b=7)
# Linear regression:
# Minimize sum of squared distance
# to all points on this graph
# Line is the prediction
# Points are observations
lm(harvest ~ rain)
# Now forecast for rain=36
-75.407 + 6.911*36
# Forecast harvest=173
lm(rain ~ harvest)



