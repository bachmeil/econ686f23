harvest <- c(150,145,55,70,180,150)
rain <- c(30,32,18,24,38,32)
lm(harvest ~ rain)
lm(harvest ~ 1)
mean(harvest)

# Extensions of linear regression
# Multiple variables
fertilizer <- c(100,110,100,50,80,100)
lm(harvest ~ rain + fertilizer)
-113.8 + 6.7*40 + 0.5*1000
# Nearest neighbor
# Quite difficult because you have
# two variables
# Plotting: Not realistic
# Time series regression
# Maintain time series properties
# tsreg

library(tstools)
rgdp <- import.fred("rgdp.csv")
plot(rgdp)
# Can we do better than a simple model?
mean(rgdp)
last(rgdp)
# Random walk: can do better

# Create trend variable
1:80
rgdp.trend <- make.trend(rgdp)
rgdp.trend
fit <- tsreg(rgdp, gdp.trend)
fit
# Growing 61.39 per quarter
# What units? Billions of dollars
# Plot actual and fitted values
# Fitted values
f <- fit$fitted
plot(f)
# Compare with actuals
values <- ts.combine(f, rgdp)
plot(values, plot.type="single")
last(rgdp.trend)

-239.6 + 61.3*307
# 2023:Q3 -> 18.58T
-239.6 + 61.3*308
# 2023:Q4 -> 18.64T
# Linear approximation works well
# for "normal" observations
# End of sample approach
last(rgdp)
last(rgdp) + 61.3
last(rgdp) + 2*61.3
# 2023:Q3 forecast -> 20465
# 2023:Q4 forecast -> 20526
rgdp.trend2 <- rgdp.trend^2
rgdp.trend2
fit2 <- tsreg(rgdp,
    ts.combine(rgdp.trend, rgdp.trend2))
fit2
f2 <- fit2$fitted
values <- ts.combine(f2, rgdp)
plot(values, plot.type="single")
# Forecast 2023:Q3 using fitted
# value approach
first(rgdp)
1886.9 + 19.96*307 + 0.1349*(307^2)
last(rgdp)
# In the right ballpark
# To use the end of sample approach
(1886.9 + 19.96*307 + 0.1349*(307^2))-
  (1886.9 + 19.96*306 + 0.1349*(306^2))
# Growing 102.65 each quarter
# End of sample
last(rgdp) + 102.65
last(rgdp) + 2*102.65