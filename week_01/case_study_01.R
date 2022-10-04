# load the iris data set
data(iris)

# Read the help file for the function that calculates the mean
?mean

# Calculate mean of the Petal.length field
petal_length_mean <- mean(iris$Petal.Length)

# Plot the distribution of the Petal.length
hist(iris$Petal.Length, main="Mean Iris Petal Length", xlab="Petal Length", ylim=c(0,40), col="Sky Blue")

dev.off()