num <- sample(1, 100, replace = FALSE)
return(num)

num <- sample(1:100, 1)
num
?sample


numbers_vector <- c(1,2,3,4,5,6,7,8,9,10)
numbers_vector[9] <- "samuel" 
numbers_vector


students <- c('Jochebed', 'John', 'Samuel', 'Isaac')
winner <- sample (students,2)
winner

men_heights <- c(172, 134, 144, 187, 177)
sd(men_heights)
women_heights <- c(182, 164, 147, 180, 177)
t_test <- t.test(men_heights ,women_heights )

plot(men_heights)

xlim <- c(-2, 7)
ylim<- c(0, 0.2)
plot(1, type = "n", xlim, ylim, xlab = "X-axis", ylab = "Y-axis", main = "Empty Plot with Limits")
plot(f(x))

punif(4, 0, 5)

n <- 6  # Number of outcomes (e.g., rolling a die)
p <- 1/n  # Equal probability for each outcome
outcome <- 3
probability <- p
print(probability)
?set.seed

set.seed(123)
random_numbers <- runif(5)
print(random_numbers)

# Simulate rolling a fair die 10 times
set.seed(42)  # For reproducibility
sample(1:6, size = 10, replace = TRUE)
?set.seed(42)

?punif

punif(q=4, min = 0, max = 5, lower.tail = TRUE)

# Simulate random numbers

set.seed(42)
random_numbers <- runif(1000, min = 0, max = 1)

# Plot histogram
hist(random_numbers, breaks = 20, probability = TRUE,
     col = "skyblue", main = "Histogram of Uniform Distribution",
     xlab = "Random Numbers", ylab = "Density")
# Simulate random numbers
set.seed(42)
random_numbers <- runif(1000, min = 0, max = 1)

# Plot histogram
hist(random_numbers, breaks = 20, probability = TRUE,
     col = "skyblue", main = "Histogram of Uniform Distribution",
     xlab = "Random Numbers", ylab = "Density")

# Add the true PDF for reference
curve(dunif(x, min = 0, max = 1), col = "red", lwd = 2, add = TRUE)
?lwd


# Simulate random numbers
set.seed(42)
random_numbers <- runif(500, min = 5, max = 15)

# Count numbers within the range [8, 12]
in_range <- random_numbers[random_numbers >= 8 & random_numbers <= 12]
proportion_in_range <- length(in_range) / length(random_numbers)

# Print results
print(proportion_in_range)  # Example output: ~0.4


z_amal <- pnorm(87, 67,12)
z_amal


?rt()

f <- uniform distribution
x_boundaries <- c(0, 5)
y_boundaries <- c(0.00, 0.20)
plot<- plot(f, main= Uniform_probability_density_function, xlab= x, ylab= f(x), xlim= c(-2,7), ylim=c(0.00, 0.20))
plot
