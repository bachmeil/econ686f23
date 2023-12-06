library(tstools)
u <- import.fred("unrate.csv")
plot(u)
# AR(1)
ar1 <- tsreg(u, lags(u,1))
ar1
# Exclude pandemic time period
dum <- time.dummy(u, c(2020,1), c(2021,12))
inter <- dum*u
ar.dum <- tsreg(u, lags(u %~% inter, 1))
ar.dum


cars
plot(cars)
lm(cars$dist ~ cars$speed)
abline(a=-17.579, b=3.932)
plot(cars, main="Relationship Between Speed and Distance")
plot(cars, 
     main="Relationship Between Speed and Distance",
     sub="Source: Ezekiel (1930)")
plot(cars, 
     main="Relationship Between Speed and Distance",
     sub="Source: Ezekiel (1930)",
     xlab="Speed (MPH)",
     ylab="",
     xaxt="n")
autos <- import.fred("domestic.csv")
plot(autos)
dautos <- window(pctChange(autos, 12),
                 start=c(2016,1),
                 end=c(2017,12))
plot(dautos)
time(dautos)
clearDates(time(dautos))
length(dautos)
index <- seq(3, 24, by=3)
index
