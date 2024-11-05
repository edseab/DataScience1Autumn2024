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

percentile <- pnorm(194,170,15) * 100
round(percentile)

#Answer: Amir is in the 95th percentile of the population
<<<<<<< HEAD
=======







>>>>>>> 13949b7 (added lab 3)
=======
>>>>>>> ee3b33e (lab 3)

# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?


short_threshold <- qnorm(0.025, 170, 15)
tall_threshold <- qnorm(0.975, 170,15)
#Amir wouldn't be accepted

<<<<<<< HEAD
=======
>>>>>>> 13949b7 (added lab 3)
=======
>>>>>>> ee3b33e (lab 3)
# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?

lower_bound <- 170 - 0.1 * 15
upper_bound <- 170 + 0.1 * 15
percentage <- pnorm(upper_bound, 170, 15) - pnorm(lower_bound, 170, 15)*100




# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 
proba.not.eligible <- 1 - 0.05 - 0.08
proba.none.10 <- proba.not.eligible ^ 10

<<<<<<< HEAD
=======

# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 
>>>>>>> 13949b7 (added lab 3)
=======
>>>>>>> ee3b33e (lab 3)


# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 


# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?

# 6. What is the probability that at least 3 of them are eligible to join the TSC?
