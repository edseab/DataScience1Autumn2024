<<<<<<< HEAD
=======
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
round(pnorm(194,170,15),2)

#Rounding up to the nearest integer, Amir is in the 95th percentile of the population.

#    (Remember: 1st percentile = shortest 1 percent of the population, 99th percentile: tallest 1 percent of the population)










# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?

# For shortest 2.5 of the population, 
qnorm(0.025,170,15)

# for tallest 2.5 of the population
qnorm(((100-2.5)/100),170,15)

# therefore one has to be 140.6 cm or shorter , or one has to be 199.4 cm or taller to be in the TSC club

# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.

# 1 standard deviation is 15 , therefore 0.1 standard deviation is a distance of 1.5cm from the mean
 upper_range = 170 + 1.5
 upper_range
 lower_range= 170-1.5
 lower_range
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?


# One has to be from 168.5 to 171.5 cm in height to belong to the Average People's Club 
pnorm(171.5,170,15)- pnorm(168.5,170,15)

# Just about 8 percent of the population is eligible to join the average people club (APC)


# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 
1-(2.5+2.5+8)/100
 #the probability that none of them are eligible to join either
#    the TSC or the APC is 87% 

# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?

#Given that p the probability for joining  APC is 0.08
# n is 10 trials
# k (no of successes) is 2
Pk= (0.08^2)*((1-.08)^8)*choose(10,2)
Pk
dbinom(2,10,0.08)
# The probability tha exactly 2 are eligible to join the APC is about 14.8%
#   0.147807

# 6. What is the probability that at least 3 of them are eligible to join the TSC?

# This will be removing the sum of the probability of 2 , 1 and none from 1 or 100%
1-(dbinom(0,10,0.08)+dbinom(1,10,0.08)+dbinom(2,10,0.08))

# The probability that at least 3 of them are eligible to join the TSC is about 4 percent 
# or 0.04


# Data Viz
# Equal bins
set.seed(123)
heights<- rnorm(100,165,15)
bins<- seq(130,200,by=5)
hist(heights, breaks=bins)
#Unequal bins
set.seed(123)
heights<- rnorm(100,165,15)
bins<- c(130,170,180,190,200)
hist(heights, breaks=bins)

>>>>>>> 06e94e7 (just commit)
