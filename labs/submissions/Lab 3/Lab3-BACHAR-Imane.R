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

pnorm(194, 170, 15)
# Amir is in the 95th percentile 


# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?

# Bottom 2.5% 
qnorm(0.025, 170, 15)
# Tallest 2.5%
qnorm(0.975, 170, 15)
# To be accepted you should be shorter than 141cm or Taller than 199cm.
# Amir would not be accepted in TSC Club.

# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?

# 0.1 standard deviations from the mean is 15 * 0.1 = 1.5cm
# 170 - 1.5 = 168.5
# 170 + 1.5 = 171.5
# The range of heights acceptable to join the APC is from 168.5 to 171.5
pnorm(171.5, 170, 15) - pnorm(168.5, 170, 15)
# The porcentage of total population eligible to join is 7.97% wich is 8% 


# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 

# The porcentage of being eligible in TSC is 5% and APC is 8%, the total is 13%

# The probability that none of 10 Examplians are eligible to join either TSC or APC is 
Prob.no.club <- function(p, n, k) (p^k)*(1-p)^(n-k)*choose(n,k)
Prob.no.club(0.13,10,0)
Prob.no.club(0.87,10,10)

# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?

# We can use the binomial distribution P(X=k)= (N choose K)* p^k * (1-p)^N-K
Prob.2.apc = function(p, n, k) (p^k)*(1-p)^(n-k)*choose(n,k)
Prob.2.apc(0.08, 10, 2)
dbinom(2, 10, 0.08)

# 6. What is the probability that at least 3 of them are eligible to join the TSC?
# P(X>=3)= 1−P(X<3)=1−[P(X=0)+P(X=1)+P(X=2)]
1- (dbinom(0, 10, 0.05)+dbinom(1, 10, 0.05)+dbinom(2, 10, 0.05))