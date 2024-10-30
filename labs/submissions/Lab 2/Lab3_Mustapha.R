###################################
###################################
########                   ########
########   Data Science 2  ########
########       Lab 3       ######## 
########  29th Oct. 2024   ########
########                   ########
###################################
###################################


# Some exercises to practice what we learned this week.

# 1. In the country of Examplia, it is known that people's heights are precisely normally distributed,
#    with a mean of 170cm and a standard deviation of 15cm.
#    Amir is 194cm tall. In what height percentile of the population is he? Round to the nearest integer number.
#    (Remember: 1st percentile = shortest 1 percent of the population, 99th percentile: tallest 1 percent of the population)

mean_1 <- 170
std_1 <- 15
amir_height <- 194
# Calculate the Z-score
z_score <- (amir_height - mean_1) / std_1
percentile <- pnorm(z_score) * 100
percentile_rounded <- round(percentile)
percentile_rounded
# This can also be done using one line of code
same_percentile <- round(pnorm(194,170,15)*100)
same_percentile

# Hence, Amir is in the 95th percentile of the population

# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?

# 
qnorm(0.025)
qnorm(0.975)

qnorm(0.025, 170, 15) # height for the lower percentile (2.5th)
qnorm(0.975, 170, 15) # height for the higher percentile (97.5th)

# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?

mean <-  170
sd <- 15
upper_limit <- mean + (0.1 * sd)
lower_limit <- mean - (0.1 * sd)
(pnorm(upper_limit,mean,sd) - pnorm(lower_limit,mean,sd))*100

# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 
p_not_eligible <- 1 - 0.05 - 0.08
# The probability that none of the 10 selected individuals are eligible
p_none_10 <- p_not_eligible ^ 10
p_none_10
# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?
n <- 10
k <- 2
p_APC <- 0.08

prob_exactly_2 <- dbinom(2,n,p_APC)
prob_exactly_2

# 6. What is the probability that at least 3 of them are eligible to join the TSC?
n <- 10
k <- 3
p_TSC <- 0.05

prob_atleast_3 <- 1- sum(dbinom(0:2,n,p_TSC))
prob_atleast_3
