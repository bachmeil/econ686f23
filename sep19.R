library(seasonal)
plot(AirPassengers)
adj <- seas(AirPassengers)
# Seasonally adjusted series
ap.sa <- final(adj)
plot(ap.sa)
# Part that's removed
plot(resid(adj))
# Use the seasonally adjusted data
# for your analysis
2^30

# Upward stepwise selection
library(tstools)
rgdp <- import.fred("rgdp.csv")
trend <- make.trend(rgdp)
trend
dum <- quarter.dummy(rgdp, omit=4)

# Estimate all models with one
# predictor
fit1 <- tsreg(rgdp, trend)
fit2 <- tsreg(rgdp, dum[,"Q1"])
fit3 <- tsreg(rgdp, dum[,"Q2"])
fit4 <- tsreg(rgdp, dum[,"Q3"])
# Find the best
AIC(fit1)
AIC(fit2)
AIC(fit3)
AIC(fit4)
# Linear time trend is the best
# What about more?
# Consider two predictors
# But with the linear time trend
fit5 <- tsreg(rgdp, 
              ts.combine(trend, dum[,"Q1"]))
fit6 <- tsreg(rgdp, 
              ts.combine(trend, dum[,"Q2"]))
fit7 <- tsreg(rgdp, 
              ts.combine(trend, dum[,"Q3"]))
# Now find the best two-predictor model
AIC(fit5)
AIC(fit6)
AIC(fit7)
# Try three-predictor models
fit8 <- tsreg(rgdp, 
              ts.combine(trend, dum[,c("Q1","Q2")]))
fit9 <- tsreg(rgdp, 
              ts.combine(trend, dum[,c("Q1","Q3")]))
# Best three-predictor model
AIC(fit8)
AIC(fit9)
# Model 8 is better
# Only have one four-predictor model
fit10 <- tsreg(rgdp, 
              ts.combine(trend, dum))
AIC(fit10)

# stepwise.selection does the work for you
predictors <- ts.combine(trend, dum)
stepwise.selection(rgdp, predictors, BIC)
# Selects the linear time trend model
# Compare criteria for each number of
# predictors

# Shrinkage regression
# Ridge regression
# Pulls the coefficient to zero
# Lasso regression
# Chooses which variables have a zero
# coefficient in the regression