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

round(pnorm(194,170,15),2)
#Amir is in the 95 percentile

# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?
qnorm(0.025,170,15) # 140.60
qnorm(1-0.025,170,15) # 199.39
#Amir will not be accepted

# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?
upper_limit <- 170 + 0.1 * 15
upper_limit # 171.5
lower_limit <- 170 - 0.1 * 15
lower_limit # 168.5
(pnorm(171.5,170,15)-pnorm(168.5,170,15))*100 #percentage of the total population is eligible to join  7.96%
# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 
p_eligible_tsc <- 0.05
p_eligible_apc <- 0.08
p_not_eligible <- 1 -(p_eligible_apc+p_eligible_tsc)

p <-round(p_not_eligible ^ 10,2)
p
# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?
dbinom(2,10,p_eligible_apc)

# 6. What is the probability that at least 3 of them are eligible to join the TSC?
pbinom(3,10,p_eligible_tsc)