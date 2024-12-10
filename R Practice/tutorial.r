?pnorm

#If a dataset is normally distributed with a mean of 100 and a standard deviation of 15, what percentage of data falls between 85 and 115?
pnorm(115,100,15)
pnorm(85,100,15)
pnorm(115,100,15)-pnorm(85,100,15)


# What z-score corresponds to the top 5% of a standard normal distribution?
qnorm(0.95)

# For a normal distribution with a mean of 50 and a standard deviation of 10, what value corresponds to the 90th percentile?
qnorm(0.90)
qnorm(0.90,50,10)
z <- (62.81552 - 50) / 10

#The test scores of students in a class follow a normal distribution with a mean of 75 and a standard deviation of 10. What is the probability that a randomly selected student scores greater than 85?
pnorm(85,75,10)
1-pnorm(85,75,10) #OR 
pnorm(85,75,10,lower.tail=F)

# he heights of a population of adult women are normally distributed with a mean of 64 inches and a standard deviation of 3 inches. What is the probability that a randomly selected woman has a height between 60 inches and 67 inches?
pnorm(67,64,3)
pnorm(60,64,3)
pnorm(67,64,3)-pnorm(60,64,3)
# A company’s sales are normally distributed with a mean of $500 and a standard deviation of $75. What is the probability that the company’s sales are less than $400?
pnorm(400,500,75)
punif(8,2,10)-punif(4,2,10)
1-punif(6,2,10)
punif(-3,-5,2)-punif(2,-5,2)
dbinom(0,6,0.1)
data(mtcars)
mtcars
#7b
mtcars$transmission <- ifelse(mtcars$am == 1, 'Automatic', 'Manual')
#7c
hist(mtcars$mpg, breaks = seq(10,34,2), 
main = "Distribution of fuel efficiency (mpg)",
xlab = "mile per gallon", ylab = "frequency",
col = "yellow")
#7d
boxplot(mpg ~ transmission, data = mtcars, main = "Fuel efficiency by mode of transmission",
xlab = "Transmisson type", ylab = "Fuel efficiency (mpg)", col = c('orange', 'green'))
#7e
t_test_result <- t.test(mpg ~ transmission, data = mtcars)

#7f
mtcars$mpg_zscore <- scale (mtcars$mpg)
z_function <- function(x,m,s){
    return((x-mean(x))/sd(x))
}
mtcars$New_mpg_Z <- z_function(mtcars$mpg)

#7g
t_test_Z <- t.test(mpg_zscore ~ )