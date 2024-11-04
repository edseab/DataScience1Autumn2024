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

amir_percentile <- pnorm(194,170,15)
# Amir is in the 95th percentile


# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?

tsc_lower_limit <- qnorm(0.025,170,15)
tsc_upper_limit <- qnorm(0.975,170,15)
# You would have to be either 140.6 cm or shorter OR
# 199.4cm or taller.

# Amir would not be accepted

# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?

mean = 170
sd = 15
#0.1 times the standard deviation is 1.5. Hence;
upper_limit = mean + (0.1 * sd)
lower_limit = mean - (0.1 * sd)
percentage_of_total <- round((pnorm(upper_limit,mean,sd) - pnorm(lower_limit,mean,sd)) * 100)

# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 


p_not_eligible = 1 - 0.05 - 0.08
p_10_not_eligible = p_not_eligible^10

# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?
p_eligible <- 1-p_not_eligible
p_exactly_2_eligible <- dbinom(2,10,p_eligible)

# 6. What is the probability that at least 3 of them are eligible to join the TSC?
#p(x>=3) = 1-p(x<3) = 1-[p(0)+p(1)+p(2)]
# p_at_least_3 <- 1 - dbinom(0:)

p_at_least_3 <- sum(dbinom(0:2, 10, 0.05))

