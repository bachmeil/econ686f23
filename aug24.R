vendor.loss <- function(M, F) {
  M*0.25 + F*1.50
}
  
vendor.loss(0,0)
vendor.loss(100,0)
vendor.loss(0,100)

vendor.loss2 <- function(M,F) {
  if (F>0) {
    M*0.25 + F*1.50
  } else {
    if (M == 0) {
      0
    } else {
      # Made too many
      # You get fired
      Inf
    }
  }
}
vendor.loss2(0, 10)
vendor.loss2(0, 0)
vendor.loss2(1, 0)

vendor.loss3 <- function(M, F) {
  (M + F)^2
}
vendor.loss3(2,0)
vendor.loss3(0,2)

x <- 2.4
3.6 -> y

# Data structures we'll use
# Vector
v <- c(3.6, 4.8, 1.2, -4)
v
v2 <- c(3.6, 4.8, 1.2, -4, "z")
v2
# R tries to figure out what you meant

# Indexing
v[1]
# Slicing
v[2:4]
2:4
v[c(2, 3, 4)]
# Grab arbitrary elements
v[c(1, 4)]
v[2] <- 1.12
v
v[2:3] <- 1.12
v
v[2:3] <- c(1.13, 1.14)
v
v[2:3] <- c(1.15, 1.16, 1.17)
v
v[] <- 1.189
v
v <- 1.189
v

# Matrix
m <- matrix(1:12, nrow=3)
m
m[1,2]
m[1:3, 1:2]
# No values -> all values
m[ ,2]
m[2, ]
m[] <- 2.45
m

# List
# Heterogeneous data structure
j <- list("a", 1:4, matrix(1:12, ncol=2))
j
# Return element
j[[1]]
# Return list
j[1]
j[1:2]
j <- list(x="a", y=1:4, z=matrix(1:12, ncol=2))
j[["x"]]
j$x
# Easier to get names right
j$"x"
j <- list("$32"="a", y=1:4, z=matrix(1:12, ncol=2))
j
j$"$32"
j$`$32`

# Data frame
# List but all elements are vectors of data
# All have same length
df <- data.frame(1:4, 5:8)
df
df[[1]]
df2 <- data.frame(1:4, 5:9)
df2
x <- 1:5
x
x[3]
x <- ts(1:5, start=c(2023,1),
        frequency=12)
x
window(x, start=c(2023,3))
diff(x)
