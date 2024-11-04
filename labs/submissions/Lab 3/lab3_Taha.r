###################################
###################################
########                   ########
########   Data Science 1  ########
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

#Examplia Data
me.an <- 1.70
s.d <- .15
amir.height <- 1.94

#percentile
percentile <- 100 * pnorm(amir.height, mean = me.an, sd = s.d)

#rounded:
percentile.rounded <- round(percentile)
percentile.rounded
#Z-score:

z.score <- (amir.height - me.an)/s.d













# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?

# Given values
mean_height <- 170
sd_height <- 15

# Tallest 2.5% (97.5th percentile)
tallest_2_5_percent <- qnorm(0.975, mean = mean_height, sd = sd_height)

# Bottom 2.5% (2.5th percentile)
bottom_2_5_percent <- qnorm(0.025, mean = mean_height, sd = sd_height)

# Output the results
tallest_2_5_percent
bottom_2_5_percent

# Check if Amir would be accepted
amir.height <- 1.94
amir_accepted <- amir.height >= tallest_2_5_percent || amir_height <= bottom_2_5_percent
amir_accepted
#Makes sense, 194cm. A Giraffe.

# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?

# Range of heights within 0.1 standard deviations from the mean
left.tail <- me.an - 0.1 * s.d
right.tail <- me.an + 0.1 * sd_height

# Percentage of the total population within this range
lower.percentile <- pnorm(left.tail, me.an, s.d)
upper.percentile <- pnorm(right.tail, me.an, s.d)
percentage.eligible <- (upper.percentile - lower.percentile) * 100

# Output the results
left.tail
right.tail
percentage.eligible

# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 
#p(Not(TSC) & Not(APC))

lower_bound_apc <- me.an - 0.1 * s.d
upper_bound_apc <- me.an + 0.1 * s.d

p.not.tsc <- 1 - (pnorm(bottom_2_5_percent, me.an, s.d) + (1 - pnorm(tallest_2_5_percent, me.an, s.d)))

p_not_apc <- 1 - (pnorm(upper_bound_apc, me.an, s.d) - pnorm(lower_bound_apc, me.an, s.d))

p_not_tsc_and_not_apc <- p_not_tsc * p_not_apc

n <- 10

probability_none_eligible <- dbinom(0, size = n, prob = 1 - p_not_tsc_and_not_apc)


# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?

probability <- dbinom(2,10,1-p_not_apc)


# 6. What is the probability that at least 3 of them are eligible to join the TSC?

#p(x >= 3) = 1 - [p(0) + p(1) + p(2)]

p_tsc = 1 - p_not_tsc

probability_at_least_3 <- 1 - sum((dbinom(0:2, size = n, prob = p_tsc)))

#OR#

probability_at_least_3 <- sum((dbinom(3:10, size = n, prob = p_tsc)))

# Output the result
probability_at_least_3