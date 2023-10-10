# Read the file as a csv
st <- read.csv("salestax.txt")
st
st <- read.csv("salestax.txt",
               sep="\t")
st
# Reading as numerical data?
class(st[,3])
# Reading as characters
# Use regular expressions to identify
# and remove the unwanted characters
# gsub: Substitute for all instances
# \\$ is regex to identify $
# Repeated substitution
st.text <- readLines("salestax.txt")
st.text
# Do the substitution
gsub("\\$", "", st.text)
# Hold the result
st.text1 <- gsub("\\$", "", st.text)
# Now remove * \\*
st.text2 <- gsub("\\*", "", st.text1)
st.text2
# Need to remove tabs, possibly
# with a space in between
# \t\\s*\t
# \t is its own regex
# \\s: space
# \\s*
st.text3 <- gsub("\t\\s*\t",
                 ",", st.text2)
st.text3

# Now save st.text3 to a file
cat(st.text3, file="salestax.csv",
    sep="\n")
# Check salestax.csv
# Need to stack the columns starting
# with column 2, column 3, ...
# Convert data to a matrix
# Stack matrix columns
# Convert the vector to a ts
# Drop missing observations
st <- read.csv("salestax.csv",
               header=TRUE)
st
# Convert to a matrix
dim(st)
st.mat <- as.matrix(st[,2:33])
m <- matrix(1:9, ncol=3)
m
as.vector(m)
st.vector <- as.vector(st.mat)
st.vector
# This is right, but it's a vector
length(st.vector)
# Drop last two observations
# Create a ts
st.data <- ts(st.vector[1:382],
              start=c(1983,1),
              frequency=12)
plot(st.data)
attr(st.data, "raw source") <-
  "KLRD"
attr(st.data, "cleaned by") <-
  "Lance Bachmeier"
saveRDS(st.data, "salestax.RDS")

salestax <- readRDS("salestax.RDS")
attributes(salestax)
plot(salestax)
