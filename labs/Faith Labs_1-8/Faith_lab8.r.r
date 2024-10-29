
###################################
###################################
########                   ########
########   Data Science 1  ########
########       Lab 8       ######## 
########  17th Dec. 2024   ########
########                   ########
###################################
###################################

## Welcome to lab #8. 

# Lets start by learning about p-hacking


# 1. THE ICE BATH STUDY
# In 2022 a paper was published in a medical journal that claimed to show 
# that taking ice-cold baths could have health benefits. They asssigned 50%
# of their subjects to the treatment group and received the ice baths
# and 50% to a control group that received no ice cold baths 
# (they could have received warm baths instead, but this study didn't do this)
# The paper abstract boasted that the ice baths had statistically significant (at the 5% level)
# effects on 3 health outcomes (perceived energy levels, mental alertness, probability of catching a cold within 1 week of treatment)
# Looking into the methods section of the paper, we can see that they actually 
# tested 60 different possible health outcomes (physical strength, skin health, blood pressure...)

# Could they have gotten these results purely by chance?

# Let's simulate the cold-water therapy experiment
# 1.1 Start by saving a sample size of 100 to an object N
N <- 100
# 1.2 Next, create a vector of 1s and 0s, so that half of your sample receives the treatement (coded 1), and the other half doesn't (coded 0)
treatment <- c(rep(1, N / 2), rep(0, N / 2))

# Next we will run 60 different t-tests using a for loop, and save the p-value for each of these tests
# 1.3 start by initializing an empty vector for your p-values using an empty c() function. 
p_values <- c()
# 1.4 Next, write a for loop for a total of 60 loops
for (i in 1:60) {
  # For each loop, save a new y-variable that you have sampled completely at random
  # Here, we use rnorm to generate random y-values
  y <- rnorm(N)
  
  # Run a t-test comparing the y-values corresponding to treatment == 1 with the y-values corresponding to treatment == 0
  t_test <- t.test(y[treatment == 1], y[treatment == 0])
  
  # Extract the p-value for that t-test and save it to the vector of p-values
  p_values[i] <- t_test$p.value
}
# 1.5 After your for-loop is run, calculate the sum of the saved p-values that are less than 0.05
significant_results <- sum(p_values < 0.05)
# 1.6 How many significant results are there at the 0.05 level?
print(significant_results)
#ANS; 1

# 1.7 Run the whole for loop again several times. How many significant results do you find each time?
results <- replicate(10, {
  p_values <- c()
  for (i in 1:60) {
    y <- rnorm(N)
    t_test <- t.test(y[treatment == 1], y[treatment == 0])
    p_values[i] <- t_test$p.value
  }
  sum(p_values < 0.05)
})
print(results)
#ANS;10
# 1.8 Write a for loop that runs the previous for-loop multiple times, and save the number of significant results you get each time. Run this for loop at least 100 times
final_results <- c()
for (j in 1:100) {
  results <- replicate(10, {
    p_values <- c()
    for (i in 1:60) {
      y <- rnorm(N)
      t_test <- t.test(y[treatment == 1], y[treatment == 0])
      p_values[i] <- t_test$p.value
    }
    sum(p_values < 0.05)
  })
  final_results[j] <- mean(results)
}
# 1.9 Plot the histogram of the number of significant results you get for each multiple comparisons experiment. What is the average number?
hist(final_results, main = "Histogram of Significant Results", xlab = "Number of Significant Results")

# 1.10 Run this whole code again, but this time increase the sample size N. Does your histogram look any different? why?
N <- 200
treatment <- c(rep(1, N / 2), rep(0, N / 2))

final_results <- c()
for (j in 1:100) {
  results <- replicate(10, {
    p_values <- c()
    for (i in 1:60) {
      y <- rnorm(N)
      t_test <- t.test(y[treatment == 1], y[treatment == 0])
      p_values[i] <- t_test$p.value
    }
    sum(p_values < 0.05)
  })
  final_results[j] <- mean(results)
}
hist(final_results, main = "Histogram of Significant Results (Increased Sample Size)", xlab = "Number of Significant Results")

# 1.11 Run the code again, but this time instead of counting how many results are less than 0.05,
# divide this threshold by the total number of comparisons (60).
N <- 200
treatment <- c(rep(1, N / 2), rep(0, N / 2))

final_results <- c()
for (j in 1:100) {
  results <- replicate(10, {
    p_values <- c()
    for (i in 1:60) {
      y <- rnorm(N)
      t_test <- t.test(y[treatment == 1], y[treatment == 0])
      p_values[i] <- t_test$p.value
    }
    sum(p_values < 0.05)
  })
  final_results[j] <- mean(results)
}
hist(final_results, main = "Histogram of Significant Results (Increased Sample Size)", xlab = "Number of Significant Results")
# 1.11 Run the code again, but this time instead of counting how many results are less than 0.05, divide this threshold by the total number of comparisons (60).
final_results <- c()
for (j in 1:100) {
  results <- replicate(10, {
    p_values <- c()
    for (i in 1:60) {
      y <- rnorm(N)
      t_test <- t.test(y[treatment == 1], y[treatment == 0])
      p_values[i] <- t_test$p.value
    }
    sum(p_values < (0.05 / 60)) # Adjusted p-value threshold
  })
  final_results[j] <- mean(results)
}
hist(final_results, main = "Histogram of Significant Results (Adjusted Threshold)", xlab = "Number of Significant Results")


# 1.12 What does your new histogram look like?
#When you apply the Bonferroni correction for multiple comparisons, the new histogram typically shows fewer significant results compared to the histogram before the correction. This is because the Bonferroni correction adjusts the threshold for significance, making it more stringent to account for the multiple comparisons made.
# 1.13 This (dividing the p-value required for significance by the number of comparisons made) is called Bonferroni correction for multiple comparisons.
# Why is it important?

# # 1.12 What does your new histogram look like?
When you apply the Bonferroni correction for multiple comparisons, the new histogram typically shows fewer significant results compared to the histogram before the correction. This is because the Bonferroni correction adjusts the threshold for significance, making it more stringent to account for the multiple comparisons made.

# 1.13 Why is Bonferroni correction important?
# The Bonferroni correction is crucial because it helps to control the family-wise error rate (FWER) when multiple hypotheses are tested simultaneously. Without correction, the likelihood of obtaining at least one statistically significant result due to random chance increases with the number of comparisons. This can lead to false positives or Type I errors. By dividing the significance level (e.g., 0.05) by the number of comparisons (e.g., 60), the Bonferroni correction ensures that the overall probability of making at least one Type I error is controlled and remains at the desired significance level. This makes the results more reliable and reduces the risk of incorrectly concluding that there is an effect when there isn't one.

# 2. Partitioned regression
data(mtcars)
# 2.1 Run a multiple regression using the mtcars database with fuel efficiency (mpg)
model <- lm(mpg ~ wt + cyl, data = mtcars)
summary(model)
# as the dependent (outcome) variable and weight (wt) and number of cylinders (cyl)
# as independent (predictor) variables
# Look at the output of this regression and note the value of the parameter estimates for the effects of wt and cyl.

# 2.2 save the residuals of the regression with formula (mpg ~ wt) into an object called mpg_wt_residuals
model_wt <- lm(mpg ~ wt, data = mtcars)
mpg_wt_residuals <- residuals(model_wt)
# 2.3 Interpret this object. What does it represent?
# The mpg_wt_residuals represent the difference between the actual mpg values and the predicted mpg values based on the weight of the cars. 
# These residuals show the variation in fuel efficiency that cannot be explained by the weight alone.
# 2.4 Save the residuals of the regression with formula (cyl ~ wt) into an object called cyl_wt_residuals
model_cyl <- lm(cyl ~ wt, data = mtcars)
cyl_wt_residuals <- residuals(model_cyl)
# 2.5 Interpret this object. What does it represent?
# The cyl_wt_residuals represent the difference between the actual number of cylinders and the predicted number of cylinders based on the weight of the cars. 
# These residuals show the variation in the number of cylinders that cannot be explained by the weight alone.
# 2.6 Run a regression with the formula (mpg_wt_residuals ~ cyl_wt_residuals)
model_residuals <- lm(mpg_wt_residuals ~ cyl_wt_residuals)
summary(model_residuals)
# 2.7 Based on your answers to 2.3 and 2.5, how do you interpret the slope estimate of the previous regression?
# The slope estimate in this regression shows the relationship between the unexplained variation in fuel efficiency (after accounting for weight) and the unexplained variation in the number of cylinders (after accounting for weight).
# It tells us how much of the residual variation in mpg can be explained by the residual variation in the number of cylinders.

# 2.8 Compare this estimate to the estimate of wt in the original full model. What do you conclude?
# Comparing the slope estimate in the residual regression to the estimate of wt in the original model helps us understand the direct and indirect effects of the number of cylinders on fuel efficiency.
# If the estimate is similar, it suggests that the effect of weight on fuel efficiency is largely independent of the number of cylinders.

# 2.9 Use the same method to get the estimate of cyl from the original model using only simple linear regressions.
model_cyl_only <- lm(mpg ~ cyl, data = mtcars)
summary(model_cyl_only)

#############################
##                         ##
##        HOMEWORK         ##
##                         ##
#############################

library(dplyr)

# 3.1 Load the dataset 'toycars' from the package 'DAAG'
install.packages('DAAG')
library(DAAG)
data(toycars)
# This dataset contains information about experiments launching toy cars at different angles and measuring the distances they travel before falling to the ground.
# Learn more about this dataset by looking up ?toycars

# There are 3 different types of toy cars, numbered 1, 2, and 3

# We want to model the relationship between the type of car and the distance they travel. 
# 3.2 The outcome (dependent) variable should be the distance since we are interested in modeling how the type of car affects the distance they travel.

# 3.3 Run a regression model with the formula distance ~ car
model <- lm(distance ~ car, data = toycars)
summary(model)

# Interpretation of regression coefficients:
# The regression coefficients tell us how the distance traveled by cars 2 and 3 compares to car 1 (the reference category).
# However, this model assumes a linear relationship and may not account for all variables affecting the distance traveled.

# 3.4 Recode the 'car' variable
toycars <- toycars %>%
  mutate(car = factor(car, levels = c(1, 2, 3), labels = c("green", "yellow", "red")))

# 3.5 Rerun the regression model using the recoded variable
model_recoded <- lm(distance ~ car, data = toycars)
summary(model_recoded)

# Interpretation of coefficients:
# The coefficients now tell us the difference in distance traveled by 'yellow' and 'red' cars compared to 'green' cars.
# The intercept represents the average distance traveled by 'green' cars.

# 3.6 Rerun the model including 'angle' as an independent variable
model_with_angle <- lm(distance ~ car + angle, data = toycars)
summary(model_with_angle)

# Interpretation of coefficients:
# - Intercept: The expected distance traveled by a 'green' car launched at 0 degrees.
# - carYellow: The difference in distance traveled by 'yellow' cars compared to 'green' cars.
# - carRed: The difference in distance traveled by 'red' cars compared to 'green' cars.
# - angle: The change in distance traveled for each additional degree of launch angle.

# 3.7 Predicted distance traveled by a red car launched at 3 degrees
predicted_distance_red_3 <- predict(model_with_angle, data.frame(car = "red", angle = 3))

# 3.8 Predicted distance traveled by a white car launched at 2.5 degrees
# Since 'white' car is not in the dataset, we cannot predict for it directly.
# We will predict for the closest available category.
predicted_distance_white_2.5 <- predict(model_with_angle, data.frame(car = "red", angle = 2.5))

# 3.9 Plot the results using ggplot with 90% confidence intervals and appropriate colors
library(ggplot2)
ggplot(data = toycars, aes(x = angle, y = distance, color = car)) +
  geom_point() +
  geom_smooth(method = "lm", level = 0.90) +
  labs(title = "Distance Traveled by Toy Cars at Different Angles",
       x = "Angle (degrees)",
       y = "Distance (cm)") +
  scale_color_manual(values = c("green" = "green", "yellow" = "yellow", "red" = "red"))
{install.packages("devtools")
library(devtools)
devtools::install_github("rmcelreath/rethinking@slim")}