library(broom)
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

N <- rnorm(100, mean = 2.1, sd = 3.1)

# 1.2 Next, create a vector of 1s and 0s, so that half of your sample receives the treatement (coded 1), and the other
# half doesn't (coded 0) 
 ones <- sample(x = c(1), 
                 size = 50,
                 replace = TRUE,
                 prob = c(0.5))
 zeros <- sample(x = c(0), 
                 size = 50,
                 replace = TRUE,
                 prob = c(0.5))

treatment_codes <- c(ones, zeros)
sum(treatment_codes)
?sample
# Next we will run 60 different t-tests using a for loop, and save the p-value for each of these tests
# 1.3 start by initializing an empty vector for your p-values using an empty c() function. 

p_values <- c()

# 1.4 Next, write a for loop for a total of 60 loops
# For each loop, save a new y-variable that you have sampled completely at random
# your y-variable should be of length N, but otherwise you can sample it however you like (rnorm,runif,rbinom... any probability distribution you like with any parameter values you like)


for (n in 1:60){
    y-variable <- rnorm (length(N)) 
}

# Next (still within the for loop), run a t-test comparing the y-values corresponding to treatment == 1 with the y-values corresponding to treatment ==0
for (n in 1:60){
    y_variable <- rnorm(length(N)) 

    y_ones <- y_variable[treatment_codes == 1]
    y_zeros <- y_variable[treatment_codes == 0]
 
    # run  t test
    t_test <- t.test(y_ones, y_zeros)
    p_values[n] <- t_test$p.value 
                   
}

# extract the p-value for that t-test and save it to the vector of p-values
for (n in 1:60){
    y_variable <- rnorm(length(N)) 

    y_ones <- y_variable[treatment_codes == 1]
    y_zeros <- y_variable[treatment_codes == 0]
 
    # run  t test
    t_test <- t.test(y_ones, y_zeros)
    p_values[n] <- t_test$p.value
                #    t_test["p.value"]
}

# 1.5 After your for-loop is run, calculate the sum of the saved p-values that are less than 0.05


sum(p_values < 0.05)


# 1.6 How many significant results are there at the 0.05 level?
# There were 6 significant results

# 1.7 Run the whole for loop again several times. How many significant results do you find each time?
#1 and 3

# 1.8 Write a for loop that runs the previous for-loop multiple times, and save the number of significant results you get each time. Run this for loop at least 100 times

Number_of_significant_results <- c()

for (x in 1:1000){
    p_values <- c()
    for (n in 1:60){
        y_variable <- rnorm(length(N)) 
        y_ones <- y_variable[treatment_codes == 1]
        y_zeros <- y_variable[treatment_codes == 0]
        t_test <- t.test(y_ones, y_zeros)
        p_values[n] <- t_test$p.value
    }
    Number_of_significant_results[x] <- sum(p_values < 0.05)   
}
sum(Number_of_significant_results)

# 1.9 Plot the histogram of the number of significant results you get for each multiple comparisons experiment. What is the average number?
hist(Number_of_significant_results)
mean(Number_of_significant_results)
# The average mean is 2.88. 

# 1.10 Run this whole code again, but this time increase the sample size N. Does your histogram look any different? why?
# when sample size was changed from 100 to 1000, the histogram increased in skewness to the right, and the average number of significant results changed from 2.88 to 2.976. 
 
# 1.11 Run the code again, but this time instead of counting how many results are less than 0.05, divide this threshold by the total number of comparisons (60).
Number_of_significant_results <- c()

for (x in 1:1000){
    p_values <- c()
    for (n in 1:60){
        y_variable <- rnorm(length(N)) 
        y_ones <- y_variable[treatment_codes == 1]
        y_zeros <- y_variable[treatment_codes == 0]
        t_test <- t.test(y_ones, y_zeros)
        p_values[n] <- t_test$p.value
    }
    Number_of_significant_results[x] <- sum(p_values < 0.05/60)   
}
sum(Number_of_significant_results)


# 1.12 What does your new histogram look like?
hist(Number_of_significant_results)
#It it skewed to the right with most of the bars missing.

mean(Number_of_significant_results)
# 1.13 This (dividing the p-value required for significance
# by the number of comparisons made) is called 
# Bonferroni correction for multiple comparisons.
# Why is it important?
# ensures that increasing trials reduces our chance of getting significant values. 

# 2. Partitioned regression
# 2.1 Run a multiple regression using the mtcars database with fuel efficiency (mpg)
# as the dependent (outcome) variable and weight (wt) and number of cylinders (cyl)
# as independent (predictor) variables
# Look at the output of this regression and note the value of the parameter estimates for the effects of wt and cyl.
data(mtcars)
# mpg = wt + cyl 
model <- lm (mpg ~ wt + cyl, data = mtcars)
summary(model)
tidy(model) %>% select(term, estimate, p.value)
#   term        estimate  p.value
#   <chr>          <dbl>    <dbl>
# 1 (Intercept)    39.7  3.04e-20
# 2 wt             -3.19 2.22e- 4
# 3 cyl            -1.51 1.06e- 3


# 2.2 save the residuals of the regression with formula (mpg ~ wt) into an object called mpg_wt_residuals
m1 <- lm (mpg ~ wt, data = mtcars )
mpg_wt_residuals <- residuals(m1)

# 2.3 Interpret this object. What does it represent?
# Residuals represent the vertical distance between the observed mpg and their corresponding fitted values (usig m1). So, when data points are close to the the regression
# line it means residuals will be small and when data points are far from the regression 
# line it means that residuals will be big. But, it is in our interest to get a regression
# line that fits that data points well. Hence, the residuals quantify the error of 
# predicted/ftted values.
# 
# summary(mpg_wt_residuals)
# > summary(mpg_wt_residuals)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -4.5432 -2.3647 -0.1252  0.0000  1.4096  6.8727

# plot(mtcars$wt, mtcars$mpg, pch = 50, col = "blue", main = "wt vs mpg")


# 2.4 Save the residuals of the regression with formula (cyl ~ wt) into an object called cyl_wt_residuals
View(mtcars)
m2 <- lm (cyl ~ wt, data = mtcars )
cyl_wt_residuals <- residuals(m2)
summary(cyl_wt_residuals)
plot(mtcars$wt, mtcars$cyl, pch = 50, col = "blue", main = "wt vs cyl")

# 2.5 Interpret this object. What does it represent?
# The residuals represent the size of deviations of the observed cyl from their corresponding fitted values (using m2). This represents errors of prediction using m2.


# 2.6 Run a regression with the formula (mpg_wt_residuals ~ cyl_wt_residuals)
m3 <- lm (mpg_wt_residuals ~ cyl_wt_residuals)
summary(m3)
# Coefficients:
#                   Estimate Std. Error t value Pr(>|t|)  
# (Intercept)      1.208e-16  4.841e-01   0.000   1.0000
# cyl_wt_residuals 2.153e+00  8.073e-01   2.668   0.0122


# 2.7 Based on your answers to 2.3 and 2.5, how do you interpret the slope estimate of the previous regression?
# the residuals observed in 2.3 are bigger than residuals observed in 2.5.
# 2.6 confirms this difference in residuals. For a unit change in 2.5's residual, there is a 2.153 change in 2.3's residual. This could inform that weights predicts number of cylinders better than it predicts efficiency.

# 2.8 Compare this estimate to the estimate of wt in the original full model. 
# What do you conclude?
# The estimate of wt in the original full model is -3.19 and 2.6`s estimate is 2.153. `

# 2.9 Use the same method to get the estimate of cyl from the original model using only simple linear regressions.
mpg_cyl_residuals <- residuals(lm(mpg ~ cyl, data = mtcars))
mpg_wt_residuals <- residuals(lm(wt ~ cyl, data = mtcars))
m3_1 <- lm(mpg_cyl_residuals ~ mpg_wt_residuals)
summary(m3_1)

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
?toycars
View (toycars)
# There are 3 different types of toy cars, numbered 1, 2, and 3

# We want to model the relationship between the type of car and the distance they travel. 
# 3.2 Which variable should be the outcome (independent) variable? Why?
# The independent variable is the type of car, becase the distance traveled is dependent on the type of car.

# 3.3 Run a regression model with the formula distance ~ car. How would you interpret the regression coefficient? What is the problem with this model? How would you rectify this problem?
model <- lm(distance ~ car, data = toycars)
summary(model)
View(toycars)
# The problem is the independent variable car is categorical but lm function considers it numeric.
# Rectify by recoding car variable into categorical.
# 3.4 Recode the 'car' variable so that car 1 is coded as 'green', car 2 is 'yellow', and car 3 is 'red'
toycars$car <- recode(toycars$car, "1" = "green", "2" = "yellow", "3" = "red")

# 3.5 Rerun the regression model using this recoded variable and interpret the coefficients. What does this model say about whether how choosing different cars affects the distances they travel?
model <- lm(distance ~ car, data = toycars)
summary(model)
# A green car is predicted to travel a distance of 0.59 units. 
# Going from a green car to a red car, distance travelled reduces by 0.082
# But, going from green car to yellow car, distance travelled increases by 0.11 units.

# Choosing a different car color changes it`s distance traveled. Sometimes more, sometimes less.`

# 3.6 Rerun the model again, this time including 'angle' as an independent variable. Interpret all 4 coefficients.
m1 <- lm(distance ~ car + angle, data = toycars)
summary(m1)
# considering that angle has no effect on distance traveled,
# A green car is predicted to travel a distance of 0.09 units. 
# Going from a green car to a red car, distance travelled reduces by 0.0822
# But, going from green car to yellow car, distance travelled increases by 0.11 units.
# On the other hand, considering that color choice has no effect on distance travelled, there is a 0.188 units change in distance traveled per unit change in angle.

# 3.7 What is the predicted distance traveled by a red car launched at 3 degrees?
predict(m1, newdata = data.frame(car = "red", angle = 3))
#0.5759258

# 3.8 What is the predicted distance traveled by a white car launched at 2.5 degrees?

predict(m1, newdata = data.frame(car = "white", angle = 2.5))
# Our model does not handle white car. You can advance our work by retraining your own model with white cars please.

# 3.9 Plot the results of this model using ggplot with 90% confidence intervals and appropriate colors


toycars <- cbind(toycars,predict(m1, interval='confidence'))
View(toycars)
# Plot with ggplot
library(ggplot2)
png(filename = "toycars_model.png", width = 800, height = 641)

ggplot(toycars, aes(x = angle, y = distance, colour = car)) +
  geom_point() +  # Plot original data points
  geom_line(aes(y=fit)) +  # Add predicted values
  geom_ribbon(aes(ymax = upr, ymin = lwr, fill = car), alpha = 0.2) +  # Confidence intervals
  theme_minimal() +
  scale_color_manual(values = c("green", "yellow", "red")) +  # Custom colors
  scale_fill_manual(values = c("green", "yellow", "red")) +  # Custom fill colors
  labs(
    title = "Results of experiment launching toy cars at various angles",
    x = "Angle of launch (degrees)",
    y = "Distance traveled (metres)",
    fill = "Car type"
  )

dev.off()