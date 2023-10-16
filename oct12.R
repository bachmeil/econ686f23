1.24 == 1.24
1.19+0.05
1.24 == 1.19+0.05

1.319+0.005
1.319+0.005 == 1.324
# Correct and expected behavior
# How can we do comparisons?
class(7)
class(7.0)
class(7L)
7+14 == 21

all.equal(1.324, 1.319+0.005)
# Difference is small enough that it might
# be floating point error

# Load the data you work with
# Test start and end dates
salestax <- readRDS("salestax.RDS")
start(salestax) == c(1983,1)
end(salestax) == c(2014,10)
library(tstools)
all.equal(as.numeric(
  tsobs(salestax, c(1983,1))), 39.9)
ts.check(salestax,
         list(c(1983,1),
              c(2014,10),
              c(1990,1)),
c(39.9, 181.5, 70.3))

# Create a database that holds all your
# academic tasks
# Class
# Item needs doing
# When it needs to be done
# Schema defines what the database holds
# Create table
# table name
# Name of item paired with the type








