
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
N
# 1.2 Next, create a vector of 1s and 0s, so that half of your sample receives the treatement (coded 1), and the other half doesn't (coded 0)
treatement_vect <- c(rep(1,N/2),rep(0,N/2))
treatement_vect
# Next we will run 60 different t-tests using a for loop, and save the p-value for each of these tests
# 1.3 start by initializing an empty vector for your p-values using an empty c() function. 
p_values_vect <- c()
# 1.4 Next, write a for loop for a total of 60 loops
# For each loop, save a new y-variable that you have sampled completely at random
# your y-variable should be of length N, but otherwise you can sample it however you like (rnorm,runif,rbinom... any probability distribution you like with any parameter values you like)

# Next (still within the for loop), run a t-test comparing the y-values corresponding to treatment == 1 with the y-values corresponding to treatment ==0

# extract the p-value for that t-test and save it to the vector of p-values
for (i in 1:60){ 
  y_variable <- rnorm(N,0,1)
 # t_test <- t.test(y_variable ~ treatement_vect) # T-test for the whole sample
  t_test <- t.test(y_variable[treatement_vect==1],y[treatement_vect==0])
  p_values_vect <- c(p_values_vect,t_test$p.value)
  #p_values_vect[i] <- t_test$p.value
}
# 1.5 After your for-loop is run, calculate the sum of the saved p-values that are less than 0.05
sum_p_values <- sum(p_values_vect < 0.05)
sum_p_values
# 1.6 How many significant results are there at the 0.05 level?
# 3 significant results
# 1.7 Run the whole for loop again several times. How many significant results do you find each time?
#6,8,12,16,18,22...
# 1.8 Write a for loop that runs the previous for-loop multiple times, and save the number of significant results you get each time. Run this for loop at least 100 times
#num_repeats <- 100
num_repeats <- 1000
results <- c()
for (j in 1:num_repeats) {
  p_values_vect <- c()
  for (i in 1:60) { 
    y_variable <- rnorm(N, 0, 1)
    t_test <- t.test(y_variable ~ treatement_vect)
    p_values_vect <- c(p_values_vect, t_test$p.value)
  }
    sum_significant <- sum(p_values_vect < 0.05)
  results <- c(results, sum_significant)
}
results
 mean(results)
# 1.9 Plot the histogram of the number of significant results you get for each multiple comparisons experiment. What is the average number?
hist(results)
 #the average number is 3
# 1.10 Run this whole code again, but this time increase the sample size N. Does your histogram look any different? why?
hist(results)
#increasing sample size doesn't solve the multiple comparisons problem. We still get false positives at roughly the same rate (about 5% of tests), we just get more consistent results in terms of how many false positives we find across different simulations.
# 1.11 Run the code again, but this time instead of counting how many results are less than 0.05, divide this threshold by the total number of comparisons (60).

num_repeats <- 1000
results <- c()
for (j in 1:num_repeats) {
  p_values_vect <- c()
  for (i in 1:60) { 
    y_variable <- rnorm(N, 0, 1)
    t_test <- t.test(y_variable ~ treatement_vect)
    p_values_vect <- c(p_values_vect, t_test$p.value)
  }
    sum_significant <- sum(p_values_vect < 0.05) / 60
  results <- c(results, sum_significant)
}
results
 mean(results)
 hist(results)
# 1.12 What does your new histogram look like?
#The histogram shows a distribution centered around  0.05 which is a value that represents the expected rate of false positives
# 1.13 This (dividing the p-value required for significance by the number of comparisons made) is called Bonferroni correction for multiple comparisons.
# Why is it important?
#it helps you avoid making decisions based on false positives, ensuring that the significant results you act upon are more likely to be genuine.
 
# 2. Partitioned regression

# 2.1 Run a multiple regression using the mtcars database with fuel efficiency (mpg)
# as the dependent (outcome) variable and weight (wt) and number of cylinders (cyl)
# as independent (predictor) variables
# Look at the output of this regression and note the value of the parameter estimates for the effects of wt and cyl.
data(mtcars)
model <- lm(mpg~wt+cyl,data = mtcars)
summary(model)
#intercept = 39,686 | wt = -3.191 | cyl = -1.508
# 2.2 save the residuals of the regression with formula (mpg ~ wt) into an object called mpg_wt_residuals
regression_model_wt <- lm(mpg ~ wt, data = mtcars)
mpg_wt_residuals <- regression_model_wt$residuals
mpg_wt_residuals
# 2.3 Interpret this object. What does it represent?
 #The object mpg_wt_residuals represents the residuals from the regression model where mpg (miles per gallon) is predicted based on wt (weight of the car). Residuals are the differences between the observed values of the dependent variable (in this case, mpg) and the predicted values obtained from the regression model.
# Plot the residuals to check for patterns
plot(mpg_wt_residuals, main="Residuals of mpg ~ wt", ylab="Residuals", xlab="Index")
# 2.4 Save the residuals of the regression with formula (cyl ~ wt) into an object called cyl_wt_residuals
regression_model_cyl_wt <- lm(cyl ~ wt, data = mtcars)
cyl_wt_residuals <- regression_model_cyl_wt$residuals
cyl_wt_residuals
# 2.5 Interpret this object. What does it represent?
#this object epresents the residuals from the regression model where cyl (number of cylinders) is predicted by wt (weight of the car)
# 2.6 Run a regression with the formula (mpg_wt_residuals ~ cyl_wt_residuals)
lm(mpg_wt_residuals ~ cyl_wt_residuals)
# 2.7 Based on your answers to 2.3 and 2.5, how do you interpret the slope estimate of the previous regression?
#The slope of this regression indicates how changes in the residuals from the cyl ~ wt regression (i.e., cyl_wt_residuals) are associated with changes in the residuals from the mpg ~ wt regression (i.e., mpg_wt_residuals).
# 2.8 Compare this estimate to the estimate of wt in the original full model. 
# What do you conclude?

# 2.9 Use the same method to get the estimate of cyl from the original model using only simple linear regressions.

full_model <- lm(mpg ~ wt + cyl, data = mtcars)
summary(full_model)

regression_mpg_wt <- lm(mpg ~ wt, data = mtcars)
mpg_wt_residuals <- regression_mpg_wt$residuals

regression_cyl_wt <- lm(cyl ~ wt, data = mtcars)
cyl_wt_residuals <- regression_cyl_wt$residuals

simple_regression_cyl_residuals <- lm(mpg_wt_residuals ~ cyl_wt_residuals)
summary(simple_regression_cyl_residuals)

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
 toycars
# This dataset contains information about experiments launching toy cars at different angles and measuring the distances they travel before falling to the ground.
# Learn more about this dataset by looking up ?toycars

# There are 3 different types of toy cars, numbered 1, 2, and 3

# We want to model the relationship between the type of car and the distance they travel. 
# 3.2 Which variable should be the outcome (independent) variable? Why?
# The independant variable is the type of car and the dependant variable is the the distance
# 3.3 Run a regression model with the formula distance ~ car. How would you interpret the regression coefficient? What is the problem with this model? How would you rectify this problem?
model <- lm(distance ~ car,data = toycars)
summary(model)
#Intercept: predicted distance when car = 0 (In other words: The predicted distance for car type 1, since car type 1 is treated as the baseline/reference level)
#car coefficient: predicted added distance for each unit increase in car number relative to car type 1
#Since car is a categorical variable with no inherent order, a linear regression model assumes a numerical relationship between car and distance. This is problematic because car does not have an inherent ordering or spacing. The regression will treat car2 and car3 as continuous variables, which may not be meaningful.
# 3.4 Recode the 'car' variable so that car 1 is coded as 'green', car 2 is 'yellow', and car 3 is 'red'
library(tidyverse)
toycars <- toycars %>%
  mutate(car_color = case_when(
    car == 1 ~ "green",
    car == 2 ~ "yellow",
    car == 3 ~ "red"
  ))
 toycars
# 3.5 Rerun the regression model using this recoded variable and interpret the coefficients. What does this model say about whether how choosing different cars affects the distances they travel?
model_color <- lm(distance ~ car_color, data = toycars)
summary(model_color)
#The regression coefficients for each car type (green, yellow, red) will represent how the distance varies relative to the baseline category (in this case, green). The coefficients will give you the estimated difference in distance for yellow and red cars compared to green cars.
#The coefficient for red is negative -> red car travels a farther distance than the green car.
#The coefficient for green is positive -> green car travels a shorter distance than the green car.

# 3.6 Rerun the model again, this time including 'angle' as an independent variable. Interpret all 4 coefficients.
model_color_angle <- lm(distance ~ car_color + angle, data = toycars)
summary(model_color_angle)
#Intercept (for car_color = "green" and angle = 0): This represents the predicted distance when the car is green (the baseline category) and the angle is 0. It is the starting point from which other values are calculated.
#car_colorred : This coefficient represents the predicted difference in distance between the yellow car and the green car when the angle is held constant. If positive, it means the yellow car travels farther than the green car; if negative, it means the yellow car travels a shorter distance than the green car.
#car_coloryellow : This coefficient represents the predicted difference in distance between the red car and the green car when the angle is held constant. Similarly, a positive value indicates the red car travels farther, and a negative value indicates it travels a shorter distance.
#angle : This coefficient represents the predicted change in distance for each unit increase in the angle. A positive coefficient means that as the angle increases, the distance traveled by the car increases, while a negative coefficient means that as the angle increases, the distance traveled decreases.
 
# 3.7 What is the predicted distance traveled by a red car launched at 3 degrees?
0.092524 + (-0.082222) + 3*0.188541

# 3.8 What is the predicted distance traveled by a green car launched at 2.5 degrees?
0.092524 + 2.5*0.188541

# 3.9 Plot the results of this model using ggplot with 90% confidence intervals and appropriate colors

toycars <- cbind(toycars,predict(model_color_angle, interval='confidence'))
library(ggplot2)
png(filename='toycars_model.png',width=800, height= 641)
ggplot(toycars,aes(x=angle,y=distance,colour=car_color))+
	geom_point()+
	geom_line(aes(y=fit))+
	geom_ribbon(aes(ymax=upr,ymin=lwr, fill=car_color),alpha=0.2)+
  theme_minimal()+
	scale_color_manual(values= c("green", 'yellow','red'))+
    scale_fill_manual(values= c("green", 'yellow','red'))+
	labs(title='Results of experiment launching toy cars at various angles', x='Angle of launch (degrees)', y='Distance traveled (metres)', fill='Car type')



