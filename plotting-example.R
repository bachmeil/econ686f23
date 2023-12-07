# Plotting involves setting appropriate parameters
# R is famous for having strong plotting functionality, but that means there
# are many parameters you can set, and in many cases, there is no default
# set for you, or the default won't work
gas <- import.fred("gas.csv")
gas5 <- window(gas, start=c(2010,1), end=c(2014,12))
# Basic plot
plot(gas5)
# Add a title
plot(gas5, main="Retail Gasoline Price, 2010-2014")
# Remove the y label, since it provides no information
plot(gas5, main="Retail Gasoline Price, 2010-2014",
     ylab="")
# Set the lowest price to 0 and highest to $5.00
plot(gas5, main="Retail Gasoline Price, 2010-2014",
     ylab="", ylim=c(0,5))
# Make the curve a little thicker
plot(gas5, main="Retail Gasoline Price, 2010-2014",
     ylab="", ylim=c(0,5), lwd=1.4)
# Scale the font size used on the axes
# But you have to reset this to one or it will remain this way
par(cex.axis=1.2)
plot(gas5, main="Retail Gasoline Price, 2010-2014",
     ylab="", ylim=c(0,5), lwd=1.4)
# Make the title font a little bigger too
par(cex.main=1.1)
plot(gas5, main="Retail Gasoline Price, 2010-2014",
     ylab="", ylim=c(0,5), lwd=1.4)
# We don't need the "Time" label on the bottom
plot(gas5, main="Retail Gasoline Price, 2010-2014",
     ylab="", ylim=c(0,5), lwd=1.4, xlab="")
# Let's make the dates on the x-axis clearer
# Put a date every six months
dd <- graph.dates(gas5, every=6)
# Now do the plot, but without any info on the x-axis
plot(gas5, main="Retail Gasoline Price, 2010-2014",
     ylab="", ylim=c(0,5), lwd=1.4, xlab="", xaxt="n")
# Now fill in that information
# axis adds info to the last plot
axis(1, at=dd$at, labels=dd$labels)
# Put the date labels perpendicular rather than parallel
axis(1, at=dd$at, labels=dd$labels, las=2)
# Not enough space, so let's add to the margin at the bottom of
# the graph. This sets the bottom, left, top, and right margins
# The default is par(mar=c(5,4,4,2)+0.1) where the units are "lines"
par(mar=c(7,4,4,2)+0.1)
plot(gas5, main="Retail Gasoline Price, 2010-2014",
     ylab="", ylim=c(0,5), lwd=1.4, xlab="", xaxt="n")
axis(1, at=dd$at, labels=dd$labels, las=2)
# Now the whole thing fits on the screen


