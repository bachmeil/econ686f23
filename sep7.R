library(tstools)
rgdp <- import.fred("rgdp.csv")
# Cubic time trend
# Add term to make.trend
trend.cubic <- make.trend(rgdp, 3)
trend.cubic
plot(trend.cubic, plot.type="single")

trend.quadratic <- make.trend(rgdp, 2)
fit2 <- tsreg(rgdp, trend.quadratic)
fit2
f2 <- fit2$fitted
values <- ts.combine(f2, rgdp)
plot(values, plot.type="single")

fit3 <- tsreg(rgdp, trend.cubic)
f3 <- fit3$fitted
values <- ts.combine(f3, rgdp)
plot(values, plot.type="single")
# Similar to the quadratic fit
fits <- ts.combine(f2, f3)
plot(fits, plot.type="single")
# Not much to gain from cubic trend model

trend.linear <- make.trend(rgdp)
fit <- tsreg(rgdp, trend.linear)
f <- fit$fitted
values <- ts.combine(f, rgdp)
plot(values, plot.type="single")

# Choose which trend model using the AIC
AIC(fit)
AIC(fit2)
# Quadratic time trend model is better
# for forecasting
AIC(fit3)
# Cubic model is your best choice

BIC(fit)
BIC(fit2)
BIC(fit3)
# BIC also selects the cubic trend model