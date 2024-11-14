###################################
###################################
########                   ########
########   Data Science 2  ########
########       Lab 3       ######## 
########  24th Oct. 2023   ########
########                   ########
###################################
###################################


# Some exercises to practice what we learned this week.

# 1. In the country of Examplia, it is known that people's heights are precisely normally distributed,
#    with a mean of 170cm and a standard deviation of 15cm.
#    Amir is 194cm tall. In what height percentile of the population is he? Round to the nearest integer number.
#    (Remember: 1st percentile = shortest 1 percent of the population, 99th percentile: tallest 1 percent of the population)

pnorm(194,170,15) 

# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?
qnorm(0.025,170,15) # 140.6
qnorm(0.975,170,15) # 199.4

# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?

# 168.5 - 171.5
pnorm(0.1) - pnorm (-0.1) #0.08

# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 

# probability of being eligible for either TSC or APC:
5+8 # 13 %

# probability of 0 out of 10 people being eligible:
0.13^0 * (1-0.13)^10 * choose(10,0) # 25 %
dbinom(0,10,0.13)
# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?
dbinom(2,10,0.08) # 14.8%

# 6. What is the probability that at least 3 of them are eligible to join the TSC?

sum(dbinom(3:10,10,0.05)) #1.15%

