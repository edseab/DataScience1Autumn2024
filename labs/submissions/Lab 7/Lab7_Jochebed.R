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

10  |> runif(1,10)  |> log()  |> sqrt() |> round(2)


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
View(mtcars)

view(mtcars %>% filter(cyl==6) %>% select(1:5))


# we would write:
mtcars %>%
  filter(cyl==6) %>%
  select(1:5)

### 2.1
# using select() and filter(), create a new database of cars that are over 4000 lbs in weight, retaining only the wt and mpg columns. Save this database to an object called 'df'.

df <- mtcars %>% filter(wt >4) %>% select(wt, mpg)
view(df)


# After you have selected the rows and columns you are interested in, you can 
# change the order of the rows using arrange

df %>% arrange(wt)

df %>% arrange(desc(wt))


# To change variables, we can use mutate()
df <- df %>% mutate(wt_kg = wt*453.592,
                    km_per_l = mpg*1.60934/3.78541)
view (df)
# And we can use ifelse() within mutate()
df <- df %>% mutate(wt_class = ifelse(wt < 5, 'Light', 'Heavy'))
view (df)


# We can even do a sultiple ifelse statment using case_when()
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

mean(mtcars$wt)
sd(mtcars$wt)
length(mtcars$mpg)

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
    c('high','medium','low')
  )
 
# You can group by multiple variables
View(mtcars)
mtcars %>% 
  group_by(efficiency,cyl) %>%
  summarise(
    wt_kg=mean(wt),
    n=length(hp)
  )

# After grouping a tibble, remember to ungroup it later using ungroup(), or you may have issues down the line.

# 3.1
data(iris)
view(iris)
# using the dplyr functions do the following:
# create a new column called Petal.Area which is the product of the petal width and petal length columns.
iris_a <- iris %>% mutate(
 Petal.Area = Petal.Width * Petal.Length,
)
# For each of the different species of iris, present the mean and standard deviation for the sepal length, sepal width, and petal area, as well as the number of samples (n)
print(unique(iris$Species))
group_by(iris_a, Species) %>% 
 summarise(
  mean_sepal_l = mean(Sepal.Length),
  # mean_sepal_w = mean(Sepal.Width),
  # mean_petal_area = mean(Petal.Area),
  # sd_sepal_l = sd(Sepal.Length),
  sd_sepal_w = sd(Sepal.Width),
  sd_petal_area = sd(Petal.Area),
   n = length(Petal.Width)
 )

#  name   | gender                            name   | gender              name   | gender
#  ---------------                            ---------------              ---------------
#  yaw    | male                              yaw    | male          +     ama    | female
#  ama    | female                            akwesi | male                yaa    | female
#  akwesi | male        group_by(gender)      kwame  | male
#  kwame  | male
#  yaa    | female


# Order this database in decreasing order of average petal length.



#######################################################
####    Code your own lm and predict functions!    ####
#######################################################

### 4.1 lm()

# Here I will walk you through the steps needed to write these functions. Follow along with the slides from this week's and last week's lectures - they contain all of the maths and some of the code that you need!

# At each step of the way, you should save each new element you calculate into a new object.

# Your lm function should take as input a y variable, and one or more x variables which should be inputted as a matrix or dataframe with one variable per column. 

y <- rnorm(n = 50,  mean = 5.4, sd = 3.2)
x <- runif(50)

model <- lm(y ~ x) 
summary(model) 
 y = mx + c
 y =  2.9029*x + 3.8802


       3.8802     0.8813

       (3.8802 -  0.8813)       --     (3.8802  +   0.8813)


more predictors: a lot of variables

y = mx + nt + vh + c  where m, n, and v are slopes/estimates adn x, t, and h are variables...

Additional predictor variables automatically cause an effect in error reduction (even though they may be useless in reality)

F-Statistic = 3.212 explained
              ---------------
               1  unexplained


BEFORE predictor


AFTER predictor

Remark:
signifance level/ threshold - 0.05

P-value 0.07934 ( prob that x has no effect on y) then what is the probability that x has an effect  on y?
P-value = 0.01 0.99
# x: predictor, independent variable, regressor, explanatory variable
# y: dependent variable, response, outcome

my.lm <- function(y, x) {
  # Start by saving the sample size (n). 
  n <- length(y)
  
  # Create the X matrix using as.matrix. Add a column of 1s for the intercept.
  X <- as.matrix(cbind(1, x))
  
  # Calculate the parameter estimates (coefficients) using the formula: (X'X)^-1 X'y
  b <- solve(t(X) %*% X) %*% t(X) %*% y
  
  # Calculate predicted values (y_hat)
  y_hat <- X %*% b
  
  # Calculate residuals (actual y - predicted y)
  e <- y - y_hat
  
  # Calculate the residual standard error, s
  s <- sqrt(sum(e^2) / (n - ncol(X))) # ncol(X) gives the number of estimated parameters (including intercept)
  
  # Calculate the variance-covariance matrix of the coefficients
  vcov_coef <- s^2 * solve(t(X) %*% X)
  
  # Extract the standard errors of the coefficients
  se_coef <- sqrt(diag(vcov_coef))
  
  # Calculate the t-values for each coefficient
  t_vals <- b / se_coef
  
  # Calculate the p-values for each t-value
  p <- 2 * pt(-abs(t_vals), df = n - ncol(X)) # Two-tailed test
  
  # Calculate R-squared (R^2) value
  RSS  <- sum(e^2)  # where RSS is ()
  TSS  <- sum((y - mean(y))^2) #  where TSS is (SSE_n)
  r2 <- 1 - (RSS / TSS) 
  
  # Calculate adjusted R-squared
  adj_r2 <- 1 - ((1 - r2) * (n - 1) / (n - ncol(X)))
  
  # Calculate the F-statistic and its p-value
  f_stat <- ((TSS - RSS) / (ncol(X) - 1)) / (RSS / (n - ncol(X)))
  model_p <- pf(f_stat, df1 = ncol(X) - 1, df2 = n - ncol(X), lower.tail = FALSE)
  
  # Return all elements in a list
  return(list(
    n = n,
    coefficients = b,
    residuals = e,
    s = s,
    vcov = vcov_coef,
    se = se_coef,
    t_values = t_vals,
    p_values = p,
    r2 = r2,
    adj_r2 = adj_r2,
    F_statistic = f_stat,
    model_p_value = model_p
  ))
}


# compare your function against the built-in R function in R.

my.lm(y=mtcars$mpg,x=mtcars[,c('wt','cyl')])

### 4.2 predict()
model <- lm(y~x)
# This will be much shorter. Create a new function that takes as input the output from your first function, along with a new_data object that has as many columns as there are predictor variables in the model output, and a confidence interval size

my.predict <- function(model_output, new_data, ci_level = 0.97) {
  
  # Extract coefficients from your my.lm output
  coef = 

  # Add a column of 1s to the new_data
  new_data = 

  # generate the predicted values of y from the new_data object based on the coefficients from the model
  # Again, remember the formula for the linear model!
  y_hat = 

#for each of these predicted values, calculate a confidence interval
  # first calculate the critical levels of the t-distribution using the ci_level and the degrees of freedom
  area_in_tails = 
  t_lower = 
  t_upper = 

  # next, for each row of the new_data object, calculate the standard error of the predicted value
  # Check the slides, and remember that 𝒗𝒄𝒐𝒗(𝒃) was saved as "vcov" in the model output
 sy = sqrt(apply(new_data,1,function(.)t(.)%*%model_output$vcov%*%.))
  
  # next, calculate the upper and lower confidence boundaries for each prediction using the critical t-levels and the previously calculated standard error
 ci_lower = 
 ci_upper = 

  # finally, put these confidence intervals into a dataframe
 ci = data.frame(ci_lower,ci_upper)
 colnames(ci) = paste0(ci_level,'%_',c('lower','upper'))
 df = cbind(y_hat = y_hat,ci)
 return(df)
}


### 4.3
# Use your functions to run the following model

# mtcars$mpg ~ mtcars$wt + mtcars$cyl


# Then plot predicted marginal effect of weight for a car with 4 cylynders. Add 96% confidence intervals to the graph.
# Hint: For this, in your "newdata" object, add a column of 4s for the number of cylinders

# Compare this graph to the graph from the lecture.


# What do you conclude?



