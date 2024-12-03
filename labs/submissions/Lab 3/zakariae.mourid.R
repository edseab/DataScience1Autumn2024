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




pnorm(194,170,15) # he's in the 95% percentile ,which means he's taller than 95% 






# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?
min_height <- qnorm(0.025,170,15) # 140.6
max_height <- qnorm(0.975,170,15) # 199.4
# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?
# since the standard deviation is 15 it represents 1 on the Z distribution so 0.1 of the sd is 1.5cm
min_height_apc <- 170 - 1.5 # 168.5
max_height_apc <- 170 + 1.5 # 171.5
# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 
# first we have 0.05p that it's eligible to join the TSC club 
Tsc_p <- 0.025 + 0.025 # 0.05
# to calculate the p for the people that are between 168.5 and 171.5 ,we can use z score of 171.5 which will give us the whole are before it and substruct from it the z score of 168.5
Apc_p <- pnorm(0.1) - pnorm(-0.1) # 0.08
# so the probabilty that 1 random examplian from the population won't be able to join both clubs is 1 - Tsc_p - Apc_p
p_not_eligible <- 1 - Tsc_p - Apc_p # 0.87 
# and for 10 random to not be eligible it will p_not_eligible power 10
p_10_not_eligible <- p_not_eligible ** 10 # 0.25
# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?
p_2_eligible_for_Apc <- Apc_p**2 * (1- Apc_p)**8 * choose(10,2)
p_2_eligible_for_Apc
# 6. What is the probability that at least 3 of them are eligible to join the TSC?
p_3_eligible_for_Tsc <- Tsc_p**3 * (1 - Tsc_p)**7  * choose(10,3)
p_3_eligible_for_Tsc
