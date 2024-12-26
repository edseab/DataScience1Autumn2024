###################################
###################################
########                   ########
########   Data Science 1  ########
########       Lab 7       ######## 
########  10th Dec. 2024   ########
########                   ########
###################################
###################################

## Welcome to lab #4. Today we will start with an introduction to the tidyverse,
# Then you will write your own lm() function, and finally a couple of exercises



#####################
####    Pipes    ####
#####################

# The pipe operator looks like this: |>
# It signifies: take the element on the left and use it as the first argument in the function on the right

# Example

hist(rnorm(200), breaks=seq(-4,4,0.5))
# is equivalent to

rnorm(200) |> hist(breaks=seq(-4,4,0.5))

# The purpose of the pipe is mostly aesthetic, in particular to avoid large numbers of parentheses when something needs to be transformed using multiple functions:



### 1.1 Rewrite the following expression using pipes:
set.seed(123)
round(sqrt(log(runif(10,1,10))),2)

runif(10,1,10) |> log() |> sqrt() |> round(2)
# Pipes were initially created in a package called magrittr, part of the 'tidyverse' group of packages


########################
####    Packages    ####
########################

# Packages are essentially environments full of functions and/or objects which aren't loaded into R by default, but must be first installed (generally from a repository called CRAN), and then loaded

# Here we will install tidyverse, which is not one but a series of packages written by the same group of people, which share a number of syntactical features

install.packages('tidyverse')

# After you have installed tidyverse into your packages, you must also load it into your environment

library(tidyverse)

# You will only have to install a package once. However, every time you start fresh in a new R environment, you will have to load the packages you need again.

#########################
####    TIDYVERSE    ####
#########################

# The tidyverse encompasses a very large number of packages, and is fairly powerful (in that you can do a lot using tidyverse packages)
# However, you DO NOT need to use tidyverse exclusively! I mostly don't use it, for example, preferring to stick to base R except for a few functionalities.

# Downsides of tidyverse include: unique syntax which is very different from other programming languages such as python
# 'Black box' functions that have specific purposes that must be remembered, as opposed to more general-purpose functions in base R
# Often actually more verbose than base R (ie. requires more lines of code to do the same thing)
# Using tidyverse is a matter of preference!

# The pipe operator was originally introduced in the tidyverse package magrittr. 
# The tidyverse pipe operator looks like this: %>%

set.seed(123)
runif(10,1,10) %>% 
  log() %>%
  sqrt() %>%
  round(2)

# In this class we will look at 2 important tidyverse packages.
# Today we will look at dplyr, which is used to manipulate and transform data.
# Next week we will learn ggplot2, which is used for plotting and data visualisation

#####################
####    dplyr    ####
#####################

# The philosophy behind dplyr is that every data transformation can be done using a function, and multiple transformations can be done by piping an object through multiple functions
# For example, in dplyr we no longer use indexing.
# Instead we use the functions 'select', to choose specific columns in a data frame, and 'filter', to choose specific rows.

data(mtcars)

# so instead of:
mtcars[mtcars$cyl == 6, 1:5]
# we would write:
mtcars %>%
  filter(cyl==6) %>%
  select(1:5)

### 2.1
# using select() and filter(), create a new database of cars that are over 4000 lbs in weight, retaining only the wt and mpg columns. Save this database to an object called 'df'.

df <- mtcars %>%
          filter(wt > 4) %>%
          select(c('wt','mpg'))

# After you have selected the rows and columns you are interested in, you can 
# change the order of the rows using arrange

df %>% arrange(wt)

df %>% arrange(desc(wt))


# To change variables, we can use mutate()
df <- df %>% mutate(wt_kg=wt*453.592,
                    km_per_l = mpg*1.60934/3.78541)

# And we can use ifelse() within mutate()
mtcars <- mtcars %>%
            mutate(wt_class = ifelse(wt>=4, 'Oversized','Standard'))

# We can even do a multiple ifelse statment using case_when()
mtcars <- mtcars %>%
            mutate(
              efficiency = case_when(
                mpg<=15 ~ 'low',
                mpg>15 & mpg<=20 ~ 'medium',
                mpg>20 ~ 'high'
                ))

# Next, summarise (or summarize) is a useful function which collapses a dataframe into a single row and can calculate summary statistics, eg:

mtcars %>% 
  summarise(
    mean_wt = mean(wt),
    sd_wt = sd(wt),
    n = length(mpg)
  )

# We can also use summarise to collapse a data frame not into one single row, but into as many rows as we have groups of interest. 
# To do this, first we need to use group_by()

mtcars %>% group_by(efficiency)

# You'll notice that this automatically changes the data frame into a new kind of object, called a tibble.
# Tibbles are basically tidyverse dataframes, that display information slightly differently, and are a bit more particular about certain things like not wanting empty cells.
# Tibbles can also be grouped, which allows for further operations down the line
# For example:

mtcars %>% 
  group_by(efficiency) %>%
  summarise(
    wt_kg=mean(wt),
    n=length(hp)
  ) %>%
  arrange(
    desc(c('high','medium','low'))
  )

# You can group by multiple variables

mtcars %>% 
  group_by(efficiency,cyl) %>%
  summarise(
    wt_kg=mean(wt),
    n=length(hp)
  )

# After grouping a tibble, remember to ungroup it later using ungroup(), or you may have issues down the line.

# 3.1
data(iris)
# using the dplyr functions do the following:
# create a new column called Petal.Area which is the product of the petal width and petal length columns.
# For each of the different species of iris, present the mean and standard deviation for the sepal length, sepal width, and petal area, as well as the number of samples (n)
# Order this database in decreasing order of average petal length.

Summary_data <- iris %>%
  mutate(Petal.Area = Petal.Width * Petal.Length) %>%
  group_by(Species) %>%
  summarise(
    mean_sepal_Len = mean(Sepal.Length),
    SD_sepal_Len = sd(Sepal.Length),
    mean_sepal_width = mean(Sepal.Width),
    SD_sepal_width = sd(Sepal.Width),
    mean_petal_area = mean(Petal.Area),
    SD_petal_area = sd(Petal.Area),
    N_samples = n()
  ) %>%
  arrange(desc(mean_petal_area))

print(Summary_data)

#######################################################
####    Code your own lm and predict functions!    ####
#######################################################

### 4.1 lm()

# Here I will walk you through the steps needed to write these functions. Follow along with the slides from this week's and last week's lectures - they contain all of the maths and some of the code that you need!

# At each step of the way, you should save each new element you calculate into a new object.

# Your lm function should take as input a y variable, and one or more x variables which should be inputted as a matrix or dataframe with one variable per column. 

my.lm <- function(y,x){

# Start by saving the sample size (n). You will need it later for calculating degrees of freedom for the test statistics and sampling distributions.
  n <- length(y)  # Number of observations in the dataset
# Next create the X matrix using as.matrix. Don't forget to add the column of 1s!
  x <- as.matrix(cbind(1,x))    # Add a column of 1s for the intercept term
# use the y input and your newly constructed x matrix to calculate the parameter estimates (or coefficients). 
# Hint: see lab 6, and remember that t() gives the transpose of a matrix and solve() gives its inverse
  # Formula: beta = (X'X)^(-1) X'y
  b <- solve(t(x) %*% x) %*% t(x) %*% y   # Coefficients
# Next, using these calculated coefficients, calculate all of the predicted values, y_hat, for each of the values of x (each of the rows of the X matrix). 
# Hint: look at the formula for the linear model - and remember we are multiplying matrices!
  # Formula: y_hat = X * beta
  y_hat <- x %*% b   # Predicted values
# Next, calculate the residuals (actual values of y minus the predicted values y_hat)
  # Formula: residuals = y - y_hat
  e <- y - y_hat   # Difference between actual and predicted values
# Next calculate the estimate of the residual standard error, s. Careful about the denominator here: check how many degrees of freedom you have!
  # Formula: s = sqrt((1/(n-p)) * sum(residuals^2))
  # Where p is the number of coefficients (including intercept)
  p <- ncol(x)       
  s <- sqrt(sum(e^2) / (n - p))   # Residual standard error
# Using s, calculate the variance covariance matrix of the coefficients.
  # Formula: Var(beta) = s^2 * (X'X)^(-1)
  vcov_coef <- (s^2) * solve(t(x) %*% x)  
# from this covariance matrix, extract the standard errors of the coefficients
  se_coef <- sqrt(diag(vcov_coef))     # Square root of diagonal elements
# use these standard errors to calculate the t-values for each of the coefficients
  # Formula: t = estimate / standard error
  t_vals <- b / se_coef    # t-statistics
# And use these t-values to calculate p-values.
  p_vals <- (1 - pt(abs(t_vals), df = n - p)) * 2       # Two-tailed test
# Next, calculate the R2 value
  # Formula: R^2 = 1 - (RSS / TSS)
  RSS <- sum(e^2)  # Residual sum of squares
  TSS <- sum((y - mean(y))^2)  # Total sum of squares
  r2 <- 1 - (RSS / TSS)
# Bonus points if you want to look up how to calculate adjusted R2
  # Formula: adj_R^2 = 1 - ((1 - R^2) * (n - 1) / (n - p))
  adj_r2 <- 1 - ((1 - r2) * (n - 1) / (n - p))
# Next, calculate the F-statistic and the p-value for the model.
  # Formula: F = (R^2 / (p - 1)) / ((1 - R^2) / (n - p))
  f_stat <- ((TSS - RSS) / (p - 1)) / (RSS / (n - p))
  model_p <- 1 - pf(f_stat, df1 = p - 1, df2 = n - p)  # F-distribution
  
# Finally, put all of these elements into a list, and have your function return that list. 
  return(list(n=n,
              coefficients = b,
              residuals = e,
              s = s,
              vcov = vcov_coef,
              se = se_coef,
              t_values = t_vals,
              p_values = p_vals,
              r2 = r2,
              adj_r2 = adj_r2,
              F_statistic = f_stat,
              model_p_value = model_p,
              df = n - p))
}

# compare your function against the built-in R function in R.

model_output <- my.lm(y=mtcars$mpg,x=mtcars[,c('wt','cyl')])

summary(lm(mpg ~ wt + cyl, data = mtcars))

### 4.2 predict()

# This will be much shorter. Create a new function that takes as input the output from your first function, along with a new_data object that has as many columns as there are predictor variables in the model output, and a confidence interval size

my.predict <- function(model_output, new_data, ci_level = 0.97) {
  
  # Extract coefficients from your my.lm output
  coef = model_output$coefficients

  # Add a column of 1s to the new_data
  new_data = cbind(1, as.matrix(new_data))

  # generate the predicted values of y from the new_data object based on the coefficients from the model
  # Again, remember the formula for the linear model!
  y_hat = new_data %*% coef

#for each of these predicted values, calculate a confidence interval
  # first calculate the critical levels of the t-distribution using the ci_level and the degrees of freedom
  df = model_output$df
  area_in_tails = (1 - ci_level) / 2 
  t_lower = qt(area_in_tails, df = df) 
  t_upper = 1 - qt(area_in_tails, df = df) 

  # next, for each row of the new_data object, calculate the standard error of the predicted value
  # Check the slides, and remember that 𝒗𝒄𝒐𝒗(𝒃) was saved as "vcov" in the model output
 sy = sqrt(apply(new_data,1,function(.) t(.)%*%model_output$vcov%*%.))  # SE for each prediction
  
  # next, calculate the upper and lower confidence boundaries for each prediction using the critical t-levels and the previously calculated standard error
 ci_lower = y_hat - (t_lower * sy)   # Lower bound of the CI
 ci_upper = y_hat + (t_upper * sy)   # Upper bound of the CI

  # finally, put these confidence intervals into a dataframe
 ci = data.frame(ci_lower,ci_upper)   # Combine lower and upper bounds
 colnames(ci) = paste0(ci_level * 100,'%_',c('lower','upper'))   # Label columns with CI percentage
 data_f = cbind(y_hat = y_hat,ci)
 return(data_f)
}


### 4.3
# Use your functions to run the following model

# mtcars$mpg ~ mtcars$wt + mtcars$cyl
# Creating newdata for predictions
wt_range <- seq(min(mtcars$wt), max(mtcars$wt), length.out = 32)  # Weight range
newdata <- data.frame(wt = wt_range, cyl = 4)  # Set cyl to 4

# Predict with confidence intervals
predictions <- my.predict(model_output, new_data = newdata, ci_level = 0.97)

# Then plot predicted marginal effect of weight for a car with 4 cylynders. Add 96% confidence intervals to the graph.
# Hint: For this, in your "newdata" object, add a column of 4s for the number of cylinders
# Plot predictions with confidence intervals
plot(
  wt_range, predictions$y_hat, type = "l", lwd = 2, col = "blue",
  ylim = range(predictions), xlab = "Weight (wt)", ylab = "Miles Per Gallon (mpg)",
  main = "Predicted MPG vs Weight for Cars with 4 Cylinders"
)

# Add confidence intervals
lines(wt_range, predictions$`97%_lower`, lty = 2, col = "red")  # Lower CI
lines(wt_range, predictions$`97%_upper`, lty = 2, col = "red")  # Upper CI

# Add legend
legend(
  "topright", legend = c("Predicted MPG", "97% CI"), 
  col = c("blue", "red"), lty = c(1, 2), lwd = 2
)

# Compare this graph to the graph from the lecture.


# What do you conclude?



