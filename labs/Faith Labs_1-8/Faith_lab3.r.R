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
# Calculate the percentile for Amir's height

mean_height <- 170
sd_height <- 15
amir_height <- 194

# Calculate the z-score for Amir's height
z_score <- (amir_height - mean_height) / sd_height

# Calculate the percentile
percentile <- pnorm(z_score) * 100
percentile_rounded <- round(percentile)

percentile_rounded
# 2. A group of Examplians start a club called the Tall and Short Club (TSC), where you have to be in the tallest 2.5% of the population 
#    OR the bottom 2.5% of the population in height to be let in. 
#    How tall or how short do you have to be to be accepted into the TSC? Would Amir be accepted?
# Calculate the z-scores for the top 2.5% and bottom 2.5%
z_top_2_5 <- qnorm(0.975)
z_bottom_2_5 <- qnorm(0.025)

# Convert z-scores to heights
height_top_2_5 <- mean_height + z_top_2_5 * sd_height
height_bottom_2_5 <- mean_height + z_bottom_2_5 * sd_height

height_top_2_5
height_bottom_2_5

# Check if Amir would be accepted
amir_accepted <- amir_height >= height_top_2_5 || amir_height <= height_bottom_2_5

amir_accepted


# 3. In response to the Tall and Short club, another group of Examplians start the Average People's Club (APC), where you have to be
#    within 0.1 standard deviations from the mean in height in order to get in.
#    What is the range of heights acceptable to join the APC? What percentage of the total population is eligible to join?
# Calculate the range of heights acceptable to join the APC
height_apc_lower <- mean_height - 0.1 * sd_height
height_apc_upper <- mean_height + 0.1 * sd_height

# Calculate the percentage of the total population eligible to join the APC
percent_apc <- (pnorm(height_apc_upper, mean = mean_height, sd = sd_height) - 
                pnorm(height_apc_lower, mean = mean_height, sd = sd_height)) * 100

height_apc_lower
height_apc_upper
percent_apc

# 4. If we selected 10 Examplians at random from the population, what is the probability that none of them are eligible to join either
#    the TSC or the APC? 
# Calculate the probability that a single Examplian is not eligible to join either the TSC or the APC
prob_not_tsc <- 1 - (pnorm(height_top_2_5, mean = mean_height, sd = sd_height) - 
                     pnorm(height_bottom_2_5, mean = mean_height, sd = sd_height))
prob_not_apc <- 1 - (pnorm(height_apc_upper, mean = mean_height, sd = sd_height) - 
                     pnorm(height_apc_lower, mean = mean_height, sd = sd_height))

# Calculate the probability that a single Examplian is not eligible to join either club
prob_not_either <- prob_not_tsc * prob_not_apc

# Calculate the probability that none of the 10 Examplians are eligible to join either club
prob_none_eligible <- prob_not_either^10

prob_none_eligible

# 5. What is the probability that exactly 2 are eligible to join the APC and the rest are not?
# Calculate the probability that exactly 2 out of 10 are eligible to join the APC
prob_apc <- (pnorm(height_apc_upper, mean = mean_height, sd = sd_height) - 
             pnorm(height_apc_lower, mean = mean_height, sd = sd_height))

# Use the binomial distribution to calculate the probability
prob_exactly_2_apc <- dbinom(2, size = 10, prob = prob_apc)

prob_exactly_2_apc

# 6. What is the probability that at least 3 of them are eligible to join the TSC?
# Calculate the probability that at least 3 out of 10 are eligible to join the TSC
prob_tsc <- (pnorm(height_top_2_5, mean = mean_height, sd = sd_height) - 
             pnorm(height_bottom_2_5, mean = mean_height, sd = sd_height))

# Use the binomial distribution to calculate the probability
prob_at_least_3_tsc <- 1 - pbinom(2, size = 10, prob = prob_tsc)

prob_at_least_3_tsc