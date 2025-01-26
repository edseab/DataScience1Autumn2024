###################################
###################################
########                   ########
########   Data Science 1  ########
########       Lab 8       ########
########  11th Dec. 2023   ########
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

p <- c()

# 1.4 Next, write a for loop for a total of 60 loops
# For each loop, save a new y-variable that you have sampled completely at random
# your y-variable should be of length N, but otherwise you can sample it however you like (rnorm,runif,rbinom... any probability distribution you like with any parameter values you like)

for (i in 1:60) {
    y <- runif(N, 60, 150)

    test <- t.test(y[treatment == 1], y[treatment == 0])

    test$p.value -> p[i]
}

sum(p < 0.05)

# Next (still within the for loop), run a t-test comparing the y-values corresponding to treatment == 1 with the y-values corresponding to treatment ==0

# extract the p-value for that t-test and save it to the vector of p-values


# 1.5 After your for-loop is run, calculate the sum of the saved p-values that are less than 0.05

# 1.6 How many significant results are there at the 0.05 level?

# 2

# 1.7 Run the whole for loop again several times. How many significant results do you find each time?

# 1.8 Write a for loop that runs the previous for-loop multiple times, and save the number of significant results you get each time. Run this for loop at least 100 times

n_significant <- c()

for (j in 1:150) {
    for (i in 1:60) {
        y <- runif(N, 60, 150)

        test <- t.test(y[treatment == 1], y[treatment == 0])

        test$p.value -> p[i]
    }

    n_significant[j] <- sum(p < 0.05)
}


# 1.9 Plot the histogram of the number of significant results you get for each multiple comparisons experiment. What is the average number?

hist(n_significant)

# 1.10 Run this whole code again, but this time increase the sample size N. Does your histogram look any different? why?

N <- 500

n_significant <- c()

for (j in 1:150) {
    for (i in 1:60) {
        y <- runif(N, 60, 150)

        test <- t.test(y[treatment == 1], y[treatment == 0])

        test$p.value -> p[i]
    }

    n_significant[j] <- sum(p < 0.05)
}




# 1.11 Run the code again, but this time instead of counting how many results are less than 0.05, divide this threshold by the total number of comparisons (60).

N <- 100

n_significant <- c()

for (j in 1:150) {
    for (i in 1:60) {
        y <- runif(N, 60, 150)

        test <- t.test(y[treatment == 1], y[treatment == 0])

        test$p.value -> p[i]
    }

    n_significant[j] <- sum(p < 0.05 / 60)
}

# 1.12 What does your new histogram look like?

# 1.13 This (dividing the p-value required for significance by the number of comparisons made) is called Bonferroni correction for multiple comparisons.
# Why is it important?

# It's important because otherwise we can almost guarantee significant results by doing lots of tests




# 2. Partitioned regression

# 2.1 Run a multiple regression using the mtcars database with fuel efficiency (mpg)
# as the dependent (outcome) variable and weight (wt) and number of cylinders (cyl)
# as independent (predictor) variables
# Look at the output of this regression and note the value of the parameter estimates for the effects of wt and cyl.

mult_mod <- lm(mpg ~ wt + cyl, data = mtcars)

summary(mult_mod)

# 2.2 save the residuals of the regression with formula (mpg ~ wt) into an object called mpg_wt_residuals

mpg_wt_residuals <- residuals(lm(mpg ~ wt, data = mtcars))
plot(mtcars$wt, mpg_wt_residuals)

# 2.3 Interpret this object. What does it represent?

# it is the difference between the prediction of mpg from the wt, and the actual observed fuel efficiency

# It is what remains of the fuel efficiency, after the effect of wt has been accounted for

# 2.4 Save the residuals of the regression with formula (cyl ~ wt) into an object called cyl_wt_residuals

cyl_wt_residuals <- residuals(lm(cyl ~ wt, data = mtcars))

# 2.5 Interpret this object. What does it represent?

# the difference between the predicted number of cylinders as a function of weight and the actual number of cylinders

# It is what remains of the number of cylinders after the effect of weight has been accounted for.


# 2.6 Run a regression with the formula (mpg_wt_residuals ~ cyl_wt_residuals)

mod_rescyl_resmpg <- lm(mpg_wt_residuals ~ cyl_wt_residuals)


# 2.7 Based on your answers to 2.3 and 2.5, how do you interpret the slope estimate of the previous regression?

# It is the predicted change in fuel efficiency associated with having one additional cylinder, AFTER the effects of weight have been accounted for.

# 2.8 Compare this estimate to the estimate of cyl in the original full model.
# What do you conclude?

# The estimates are identical. This means that in the multiple regression the estimate of cyl is adjusted to account for the
# effect of wt, and vice versa

# 2.9 Use the same method to get the estimate of wt from the original model using only simple linear regressions.

mpg_cyl_residuals <- residuals(lm(mpg ~ cyl, data = mtcars))
wt_cyl_residuals <- residuals(lm(wt ~ cyl, data = mtcars))
mod_reswt_resmpg <- lm(mpg_cyl_residuals ~ wt_cyl_residuals)


#############################
##                         ##
##        HOMEWORK         ##
##                         ##
#############################

library(dplyr)

# 3.1 Load the dataset 'toycars' from the package 'DAAG'
install.packages("DAAG")
library(DAAG)
data(toycars)
# This dataset contains information about experiments launching toy cars at different angles and measuring the distances they travel before falling to the ground.
# Learn more about this dataset by looking up ?toycars

# There are 3 different types of toy cars, numbered 1, 2, and 3

# We want to model the relationship between the type of car and the distance they travel.
# 3.2 Which variable should be the outcome (dependent) variable? Why?

# Car type can affect distance traveled, but not the reverse. Therefore, distance traveled should be the outcome variable

# 3.3 Run a regression model with the formula distance ~ car. How would you interpret the regression coefficient? What is the problem with this model? How would you rectify this problem?

m1 <- lm(distance ~ car, data = toycars)

# The 'car' coefficient represents the predicted change in distance for a 1 'unit' change in car.
# The problem is that the numbers for the 'car' variable don't represent a numeric value and don't have a unit
# Instead they represent a categorical variable, the type of car
# So the estimate is the predicted difference between car 1 and car 2, and between car 2 and car 3, and half the difference between
# car 1 and car 3 - even though these might not be well estimated using the same number
# Instead they should be modeled using a categorical variable.

# 3.4 Recode the 'car' variable so that car 1 is coded as 'green', car 2 is 'yellow', and car 3 is 'red'

library(dplyr)

toycars |> mutate(car_colour = case_when(
    car == 1 ~ "green",
    car == 2 ~ "yellow",
    car == 3 ~ "red"
)) -> toycars



# 3.5 Rerun the regression model using this recoded variable and interpret the coefficients.
# What does this model say about whether how choosing different cars affects the distances they travel?

m2 <- lm(distance ~ car_colour, data = toycars)
summary(m2)

# The estimates for red cars and yellow cars - relative to green cars - are not significantly larger than 0.
# This indicates that - according to this model - there is no association between car type and distances traveled.

# 3.6 Rerun the model again, this time including 'angle' as an independent variable. Interpret all 4 coefficients.

m3 <- lm(distance ~ car_colour + angle, data = toycars)
summary(m3)

# The intercept is the predicted distance traveled for the reference category car (green) launched at 0 degrees
# The car_colourRed and car_colourYellow estimatesare the predicted differences between the distance
# traveled by the reference category car (green) and the red and yellow respectivelholding the angle launched constant

# The angle estimate is the predicted change in distance launched for each additional degree of slope that the car was launched at,
# holding the type of car constant


# 3.7 What is the predicted distance traveled by a red car launched at 3 degrees?

0.092524 + (-0.082222) + 3 * 0.188541
# The predicted distance is 0.575925 metres

# 3.8 What is the predicted distance traveled by a green car launched at 2.5 degrees?
0.092524 + 2.5 * 0.188541
# The predicted distance is 0.575925 metres


# 3.9 Plot the results of this model using ggplot with 90% confidence intervals and appropriate colors
toycars <- cbind(toycars, predict(m3, interval = "confidence"))
library(ggplot2)
png(filename = "toycars_model.png", width = 800, height = 641)
ggplot(toycars, aes(x = angle, y = distance, colour = car_colour)) +
    geom_point() +
    geom_line(aes(y = fit)) +
    geom_ribbon(aes(ymax = upr, ymin = lwr, fill = car_colour), alpha = 0.2) +
    theme_minimal() +
    scale_color_manual(values = c("green", "yellow", "red")) +
    scale_fill_manual(values = c("green", "yellow", "red")) +
    labs(title = "Results of experiment launching toy cars at various angles", x = "Angle of launch (degrees)", y = "Distance traveled (metres)", fill = "Car type")
dev.off()
