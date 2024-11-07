###################################
###################################
########                   ########
########   Data Science 2  ########
########       Lab 3       ######## 
########  29th Oct. 2024   ########
########                   ########
###################################
###################################

#Benita Adomako
# Some exercises to practice what we learned this week.

# 1. In the country of Examplia, it is known that people's heights are precisely normally distributed,
#    with a mean of 170cm and a standard deviation of 15cm.
#    Amir is 194cm tall. In what height percentile of the population is he? Round to the nearest integer number.
#    (Remember: 1st percentile = shortest 1 percent of the population, 99th percentile: tallest 1 percent of the population)

amir_height <- 194

# Calculating the percentile
percentile <- pnorm(amir_height,170,15) * 100

# Round to the nearest integer
percentile_rounded <- round(percentile)
percentile_rounded

#Answer = 95





# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?


# Calculating the height threshold for the shortest 2.5% (2.5th percentile)
short_threshold <- qnorm(0.025,170,15)

# Calculating the height threshold for the tallest 2.5% (97.5th percentile)
tall_threshold <- qnorm(0.975, 170,15)

# Print the thresholds
short_threshold
# Answer 140.6005
tall_threshold
#Answer 199.3995

#Interpretation
#Since Amir is 194 cm tall, which is below the 199.4 cm threshold, he would not be accepted into the TSC.




# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?


# Calculating the acceptable height range
lower_bound <- mean_height - (0.1 * 170)
upper_bound <- mean_height + (0.1 * 170)

# Print the range
lower_bound
upper_bound

# Calculating the cumulative probabilities for the bounds
lower_percentile <- pnorm(lower_bound,170, 15)
upper_percentile <- pnorm(upper_bound, 170, 15)

# Calculate the percentage within this range
percentage_in_range <- (upper_percentile - lower_percentile) * 100

# Print the percentage
percentage_in_range
#Answer  74.29257
#Therefore 74% of total population is eligible to join


# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 

# Probability of not being eligible for either club
prob_not_eligible <- 1 - 0.793

# Probability that none of the 10 selected people are eligible
probability10_none_eligible <- prob_not_eligible^10
probability10_none_eligible
#Answer 1.444453e-07

# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?

p <- 0.743# probability of being eligible for the APC

# Calculate the probability of exactly 2 people being eligible for the APC
probability_exactly_2 <- dbinom(2,10, prob = p)
probability_exactly_2

#Answer 0.0004727757
#The probability that exactly 2 are eligible to join the APC and the rest are not is 0.0004727757



# 6. What is the probability that at least 3 of them are eligible to join the TSC?

p <- 0.025 + 0.025  # probability of being eligible for the TSC

probability_at_least_3 <- 1 - pbinom(2,10, prob = p)
probability_at_least_3

#Answer 0.01150356
#The probability that at least 3 of them are eligible to join the TSC is 0.01150356