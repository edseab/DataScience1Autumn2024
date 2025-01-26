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



# Normally distributed
pnorm(194,170,15)
# He is in the 95th percentile




# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?
qnorm(0.025, 170, 15)
qnorm(0.025, 170, 15, lower.tail = FALSE)
# Lower 2.5% is 140.6cm and higer 2.5% is 199.4cm. Hence, Amir will not be acccepted.

# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?
# Lower range = 170 - 15* 0.1 = 168.5cm
# Upper range = 170 + 15* 0.1 = 171.5cm
pnorm(171.5,170,15) - pnorm(168.5,170,15)
# Eligible to join = 0.07965567, approximately 8% of the population is eligible to join.

# 4. I f we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC?
rnorm (10,170,15)
# 1 - (0.025 + 0.025 + pnorm(171.5,170,15)-pnorm(168.5,170,15))
# 0.8703443 ^ 10
# probability that none of the 10 exmaplians are eligible to join either the TSC or the APC is 0.2494

# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?
# size = 10, prob = norm(171.5,170,15)-pnorm(168.5,170,15),  x = 2
dbinom(2,10,pnorm(171.5,170,15)-pnorm(168.5,170,15))



 ( pnorm(171.5,170,15)-pnorm(168.5,170,15))^2 * (1-pnorm(171.5,170,15)-pnorm(168.5,170,15))^8

# 6. What is the probability that at least 3 of them are eligible to join the TSC?
# P(X>=3) = 1 - P(X<3)
1 - pbinom(2,10,0.05)