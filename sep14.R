library(tstools)
autos <- import.fred("domestic.csv")
plot(autos)

autos17 <- window(autos, start=c(2017,1),
                  end=c(2017,12))
plot(autos17)
m <- mean(autos17)
m
# 2017: 382,000 new domestic autos per month
autos17 - m

# What about other years
# Dummy variable model
dum <- month.dummy(autos, "Jan")
window(dum, start=c(2017,1),
       end=c(2017,12))
tsreg(autos, dum)

# If seasonality changed
tsreg(autos, dum, end=c(1999,12))
# Stepwise model selection
# Look at only a subset of
# models, but with a good guess
# for the subset.