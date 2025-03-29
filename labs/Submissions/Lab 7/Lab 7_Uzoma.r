###################################
###################################
########                   ########
########   Data Science 1  ########
########       Lab 7       ######## 
########  10th Dec. 2024   ########
########                   ########
###################################
###################################

## Welcome to lab #7. Today we will start with an introduction to the tidyverse,
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
# using select() and filter(), create a new database of cars that are over 4000 lbs in weight, retaining only the wt and mpg columns.
# Save this database to an object called 'df'.

mtcars %>%
  filter(wt>=4) %>%
  select(c('wt',mpg)) -> df

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

iris %>% 
  mutate(Petal.Area = Petal.Length * Petal.Width) %>% 
  group_by(Species) %>% 
  summarise(
    mean_Sepal.Length = mean(Sepal.Length),
    sd_Sepal.Length = sd(Sepal.Length),
    mean_Sepal.Width = mean(Sepal.Width),
    sd_Sepal.Width = sd(Sepal.Width),
    mean_Petal.Length = mean(Petal.Length),
    sd_Petal.Length = sd(Petal.Length),
    mean_Petal.Width = mean(Petal.Width),
    sd_Petal.Width = sd(Petal.Width),
    mean_Petal.Area = mean(Petal.Area),
    sd_Petal.Area = sd(Petal.Area),
    n=length(Sepal.Length)
  ) %>% 
  arrange(desc(mean_Petal.Length)) -> iris


#######################################################
####    Code your own lm and predict functions!    ####
#######################################################

### 4.1 lm()

# Here I will walk you through the steps needed to write these functions. Follow along with the slides from this week's and last week's lectures - they contain all of the maths and some of the code that you need!

# At each step of the way, you should save each new element you calculate into a new object.

# Your lm function should take as input a y variable, and one or more x variables which should be inputted as a matrix or dataframe with one variable per column. 

my.lm <- function(y,x){

# Start by saving the sample size (n). You will need it later for calculating degrees of freedom for the test statistics and sampling distributions.
  n <- length(y)
# Next create the X matrix using as.matrix. Don't forget to add the column of 1s!
  x <- as.matrix(cbind(1, x))
# use the y input and your newly constructed x matrix to calculate the parameter estimates (or coefficients). 
# Hint: see lab 6, and remember that t() gives the transpose of a matrix and solve() gives its inverse
  b <- solve(t(x)%*%x)%*%t(x)%*%y
# Next, using these calculated coefficients, calculate all of the predicted values, y_hat, for each of the values of x (each of the rows of the X matrix). 
# Hint: look at the formula for the linear model - and remember we are multiplying matrices!
  y_hat <- x %*% b
# Next, calculate the residuals (actual values of y minus the predicted values y_hat)
  e <- y-y_hat
# Next calculate the estimate of the residual standard error, s. Careful about the denominator here: check how many degrees of freedom you have!
  s <- sqrt(sum(e^2)/(n-ncol(x)))
# Using s, calculate the variance covariance matrix of the coefficients.
  vcov_coef <- s^2 * solve(t(x) %*% x)
# from this covariance matrix, extract the standard errors of the coefficients
  se_coef <- sqrt(diag(vcov_coef))
# use these standard errors to calculate the t-values for each of the coefficients
  t_vals <- b/se_coef
# And use these t-values to calculate p-values.
  p <- 1 - pt(abs(t_vals),df=n-ncol(x))
# Next, calculate the R2 value

  RSS <- sum(e^2)
  TSS <- sum((y - mean(y))^2)
  r2 <- 1 - RSS / TSS
# Bonus points if you want to look up how to calculate adjusted R2
  adj_r2 <- 1 - (RSS / (n - ncol(x) - 1)) / (TSS / (n - 1))
# Next, calculate the F-statistic and the p-value for the model.
  f_stat <- (TSS - RSS) / (ncol(x) - 1) / (RSS / (n - ncol(x)))
  model_p <- pf(f_stat, ncol(x) - 1, n - ncol(x), lower.tail = F)
  
# Finally, put all of these elements into a list, and have your function return that list. 
  return(list(n=n,
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
              model_p_value = model_p))
}

# compare your function against the built-in R function in R.

my.lm(y=mtcars$mpg,x=mtcars[,c('wt','cyl')])

### 4.2 predict()

# This will be much shorter. Create a new function that takes as input the output from your first function, along with a new_data object that has as many columns as there are predictor variables in the model output, and a confidence interval size

my.predict <- function(model_output, new_data, ci_level = 0.97) {
  
  # Extract coefficients from your my.lm output
  coef = model_output$coefficients

  # Add a column of 1s to the new_data
  new_data = cbind(1,new_data)

  # generate the predicted values of y from the new_data object based on the coefficients from the model
  # Again, remember the formula for the linear model!
  y_hat = new_data%*%coef

#for each of these predicted values, calculate a confidence interval
  # first calculate the critical levels of the t-distribution using the ci_level and the degrees of freedom
  area_in_tails = (1-ci_level)/2
  t_lower = qt(area_in_tails,df=model_output$n-ncol(new_data))
  t_upper = -t_lower

  # next, for each row of the new_data object, calculate the standard error of the predicted value
  # Check the slides, and remember that 𝒗𝒄𝒐𝒗(𝒃) was saved as "vcov" in the model output
 sy = sqrt(apply(new_data,1,function(.)t(.)%*%model_output$vcov%*%.))
  
  # next, calculate the upper and lower confidence boundaries for each prediction using the critical t-levels and the previously calculated standard error
 ci_lower = y_hat + t_lower.*sy
 ci_upper = y_hat + t_upper.*sy

  # finally, put these confidence intervals into a dataframe
 ci = data.frame(ci_lower,ci_upper)
 colnames(ci) = paste0(ci_level,'%_',c('lower','upper'))
 df = cbind(y_hat = y_hat,ci)
 return(df)
}


### 4.3
# Use your functions to run the following model

# mtcars$mpg ~ mtcars$wt + mtcars$cyl
model<- my.lm(y=mtcars$mpg,x=mtcars[,c('wt','cyl')])

# Then plot predicted marginal effect of weight for a car with 4 cylynders. Add 96% confidence intervals to the graph.
# Hint: For this, in your "newdata" object, add a column of 4s for the number of cylinders
x <- seq(0,6,0.1)

ci <- my.predict(model,new_data=cbind(wt=x,cyl=4),ci_level=0.96)

plot(mtcars$wt,mtcars$mpg, pch=20)
lines(x,model$coefficients['1',]+x*model$coefficients['wt',]+4*model$coefficients['cyl',])

polygon(x=c(x,rev(x)),y=c(ci$'0.96%_lower',rev(ci$'0.96%_upper')),col=adjustcolor('slateblue',alpha.f=0.4))

# Compare this graph to the graph from the lecture.
#The slope is less steep. 

# What do you conclude?
# This indicates that number of cylinders partially confounds the relationship between car weight and car efficiency. Once cylinders are controlled for, the effect of weight on efficiency is less pronounced, although still important and significant.