library(tstools)
rgdp <- import.fred("rgdp.csv")
trend.quadratic <- make.trend(rgdp, 2)

# Training sample
# Estimate using data through 2009Q4
fit2 <- tsreg(rgdp, trend.quadratic,
              end=c(2009,4))
fit2
# OOS validation
# 2010Q1 and later
# 2010Q1
2225.8540 + 10.1568*(253) + 0.1797*(253^2)
# 2010Q2
2225.8540 + 10.1568*(254) + 0.1797*(254^2)
# Trend values for 2010Q1-end
# 253 through 306
oos2 <- 2225.8540 + 10.1568*(253:306) + 
  0.1797*((253:306)^2)
# Do for the cubic
oos3 <- 2290 + 4.353*(253:306) +
  0.2619*((253:306)^2) -
  0.0002756*((253:306)^3)
oos3

# Now compare with what actually happened
predictions.oos2 <- ts(oos2, start=c(2010,1),
                       frequency=4)
predictions.oos3 <- ts(oos3, start=c(2010,1),
                       frequency=4)
# This is what actually happened
# in the validation period
actual.values <- window(rgdp, start=c(2010,1))

# Now look at the errors for both models
# Which model has errors closer to zero
# on average
error.oos2 <- actual.values - predictions.oos2
plot(error.oos2)

error.oos3 <- actual.values - predictions.oos3
plot(error.oos3)

mse.oos2 <- mean(error.oos2^2)
mse.oos2
mse.oos3 <- mean(error.oos3^2)
mse.oos3
# Cubic is clear winner
# MSE over the validation sample is about 5%
# of the quadratic MSE


make.trend(rgdp)

trend.cubic <- make.trend(rgdp, 3)
fit3 <- tsreg(rgdp, trend.cubic, end=c(2009,4))
fit3
start(rgdp)

# Use a locally linear approach
# Estimate linear trend starting in 2000
trend.linear <- make.trend(rgdp)
fit.2000 <- tsreg(rgdp, trend.linear,
                  start=c(2000,1))
fit.2000

fit.linear <- tsreg(rgdp, trend.linear)
fit.linear

fit.2008 <- tsreg(rgdp, trend.linear,
                  start=c(2008,1))
fit.2008
# Caution: Want the long-term trend
# Too few observations tell you about
# the ups and downs, not the trend

# Take the log
plot(log(rgdp))
fit.log <- tsreg(log(rgdp), trend.linear)
fit.log
plot(fit.log$fitted)

values <- ts.combine(fit.log$fitted, log(rgdp))
plot(values, plot.type="single")

# Detrend log RGDP
bus.cycle <- log(rgdp) - fit.log$fitted
plot(bus.cycle)

# header=FALSE -> First row not the names
world.co2 <- read.csv("world-co2.csv", 
                      header=FALSE)
w.co2 <- ts(world.co2, end=2021)
plot(w.co2)
us.co2 <- read.csv("us-co2.csv", 
                      header=FALSE)
u.co2 <- ts(us.co2, end=2021)
plot(u.co2)
china.co2 <- read.csv("china-co2.csv", 
                   header=FALSE)
ch.co2 <- ts(china.co2, end=2021)
plot(ch.co2)
india.co2 <- read.csv("india-co2.csv", 
                      header=FALSE)
in.co2 <- ts(india.co2, end=2021)
plot(in.co2)

us.coal <- read.csv("us-coal.csv", 
                   header=FALSE)
u.coal <- ts(us.coal, end=2021)
plot(u.coal)
