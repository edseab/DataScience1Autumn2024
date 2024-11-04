###################################
###################################
########                   ########
########   Data Science 2  ########
########       Lab 3       ######## 
########  29th Oct. 2024   ########
########                   ########
###################################
###################################

## Class heights

men <- c(174,180,178,185,178,189,175,165,174,197,171,163,173)

# Some exercises to practice what we learned this week.

# 1. In the country of Examplia, it is known that people's heights are precisely normally distributed,
#    with a mean of 170cm and a standard deviation of 15cm.
#    Amir is 194cm tall. In what height percentile of the population is he? Round to the nearest integer number.
#    (Remember: 1st percentile = shortest 1 percent of the population, 99th percentile: tallest 1 percent of the population)

# Amir is in the 95th percentile


# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?

# You would have to be either 140.6 cm or shorter OR
# 199.3cm or taller.

# Amir would not be accepted

# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?

mean = 170
sd = 15
upper_limit = 171.5
lower_limit = 168.5

# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 
p_not_eligible = 0.87
p_10_not_eligible = p_not_eligible^10


# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?

# 6. What is the probability that at least 3 of them are eligible to join the TSC?
