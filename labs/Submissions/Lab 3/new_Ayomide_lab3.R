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

pnorm(194, 170, 15) * 100 # he is in the 95th percentile of the population
pnorm(194, 170, 15, lower.tail = F) * 100 # in other words he is inthe top 5% of the population








# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population
#    OR the bottom 2.5% of the population in height to be let in.
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?
c(qnorm((2.5 / 100), 170, 15), qnorm((2.5 / 100), 170, 15, lower.tail = F)) # you have to be shorter than 140.6 or taller than 199.4
# Amir will not be accepted to the club, he needs to grow taller

# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?

range_of_heights <- c(170 + (.1 * 15), 170 - (.1 * 15)) # he has to be between 168.5 and 171.5 cm
(pnorm(171.5, 170, 15) - pnorm(168.5, 170, 15)) * 100 # about 8%


# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC?
p1 <- 5 / 100 # prob of TSC
p2 <- 8 / 100 # prob of APC
x <- p1 + p2
pbinom(0, 10, x) # the probability is 25 percent

# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?
dbinom(2, 10, p2) # the probability is 14.8 percent


# 6. What is the probability that at least 3 of them are eligible to join the TSC?
pbinom(2, 10, p1, lower.tail = F) * 100 # the probability is 1.15 percent
