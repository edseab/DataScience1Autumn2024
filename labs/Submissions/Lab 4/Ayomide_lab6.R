###################################
###################################
########                   ########
########   Data Science 1  ########
########       Lab 6       ########
########  3rd Dec. 2024    ########
########                   ########
###################################
###################################


# Welcome to lab number 6. Today we'll be learning a few more
# R/general programming concepts before moving onto lecture examples

########################################
####    Boolean logic, continued    ####
########################################

# the main logic operators in R are as follows:
# the NOT operator, !, turns TRUE into FALSE and vice versa
!TRUE
!FALSE
# the AND operator, &, returns TRUE only if elements on both sides of the operator are TRUE
1 == 1 & 2 == 1
# the inclusive OR operator, |, returns TRUE if EITHER of the elements are TRUE
1 == 1 | 2 == 1

# there is no operator for exclusive OR, but there is a function, xor()
xor(1 == 1, 2 == 2)

# 1.1
# mtcars is a database of cars with several variables such as horsepower, weight, number of cylinders etc.
data(mtcars)
head(mtcars)
# Using indexing (square brackets) and the & operator, write a line of code
# that selects only the rows of mtcars with at least 6 cylinders (mtcars$cyl >= 6) and horsepower of at least 110 (mtcars$hp >= 110). Remember to include all the columns.

mtcars[mtcars$cyl >= 6 & mtcars$hp >= 110, ]
### 1.2
# Now select only those rows with either high efficiency (miles per gallon (mpg) of at least 25) or low weight (wt <= 2.5)
mtcars[mtcars$mpg >= 25 | mtcars$wt <= 2.5, ]
#############################
####    If statements    ####
#############################

# The if() function will execute everything after it, either on the same line or in {} brackets,
# only if there is a TRUE boolean statement within the parentheses
x <- 5
if (x > 3) print("This statement is true")
if (x - 4 == 1) {
     new_object <- c("this", "statement", "is", "also", "true")
     print(new_object)
}

### 2.1
# Write a function called probe, that takes two arguments, n and w.
# The function should return a character vector of length n, consisting of 'Water' and 'Land', sampled with probability w. (so probability of sampling 'Water' is w)
# If the p argument is not numeric, or if it is not between 0 and 1, the function should return the following message:
# "Please input a probability between 0 and 1"
?sample
probe <- function(n, w) {
     if (is.numeric(w) & w >= 0 & w <= 1) {
          a <- sample(c("water", "land"), n, replace = T, prob = c(w, 1 - w))
          b <- c(a)
          return(b)
     }
     return("Please input a probability between 0 and 1")
}

probe(10, 0.2)
# After the if statement we can put an else statement:
if (x - 4 > 1) {
     new_object <- c("this", "statement", "is", "also", "true")
     print(new_object)
} else {
     print("This is untrue")
}

# A simplified version of if()else is the following:
ifelse(x / 2 == 7, print("Definitely true"), print("categorically false"))

##################################
####    Paste and strsplit    ####
##################################

# paste() and strsplit() can be used to join and separate
# character objects (strings), respectively. For example:

paste("Hello", "world!", sep = "_")
strsplit("Hello to you too. /My name is Ed.", split = "/")

# You'll notice that strsplit returns a list. This allows us to vectorise the function:
strsplit(rownames(mtcars), split = " ")


#####################
####    Loops    ####
#####################

# Loops are algorithms that repeat a procedure over and over until they are instructed to stop.
# There are two main kinds:
# FOR loops iterate over a predetermined set (vector, list, etc)
fruits <- c("apple", "banana", "pineapple", "mango", "orange")
for (i in fruits) {
     print(paste("My favourite fruit is", i, sep = ": "))
}

useless_function <- function(n) {
     for (i in 1:n) {
          print(paste0(i, ". This number is: ", c("even", "odd")[i %% 2 + 1]))
     }
}
useless_function(7)

### 4.1
data(iris)

# Write a for loop that iterates over the column names of the iris dataset and print each together with the number of characters in the column name in parenthesis. Example output: Sepal.Length (12). To get the number of characters use the function nchar().
?nchar
for (i in colnames(iris)) {
     print(paste(i, nchar(i), sep = ": "))
}
# Next, WHILE loops continue to loop until the boolean statment in the defining parentheses, e.g.
x <- 0
while (x < 100) {
     print(x)
     x <- x + sample(1:20, 1)
}

### 4.2 How many numbers do you need in the sequence 1*2*3*4*5*... before the product exceeds 10 million?
# Use a while loop to get the answer
i <- 1
n <- 1
while (i < 10000000) {
     print(n)
     i <- i * n
     n <- n + 1
}

###################################
####    Linear models intro    ####
###################################

# We can run an OLS linear model using lm()
# Inside the lm and other model functions we use formulas
# Formulas have the dependent variable on the left and the independent (predictor) variables on the right with a ~ in between
# Lets run a bivariate regression of car weight (in 1000 pounds/500 kg) on miles per gallon (1mpg = 1km/L)
model <- lm(mtcars$mpg ~ mtcars$wt)
summary(model)
### 5.1
# What does the Estimate for the (Intercept) number represent?
### 5.2
# What does the Estimate for the mtcars$wt number represent?

### 5.3
# Is the relationship between these two variables positive or negative? Why do you think that might be?

### 5.4 What is the predicted average efficiency in miles per gallon of a 4000 pound (2000kg) car?

# Let's transform the independent variable:
mtcars$wt_centred <- mtcars$wt - mean(mtcars$wt)

### 5.5
# compare the mean and variance of the new variable with the untransformed variable. What do you notice?


### 5.6
# Run the following code:
y <- mtcars$mpg
x <- cbind(1, mtcars$wt)

# A couple of functions for you to know:
# t() returns the transpose of any matrix
# solve() returns the inverse of any (invertible) matrix
# %*% is matrix multiplication
# with that in mind try to code the following expression in R:
# (x'x)^(-1) * (x'y)
# where ' means the transpose
# Run the code you have written. What do you find?
