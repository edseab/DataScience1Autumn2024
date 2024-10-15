###################################
###################################
########                   ########
########   Data Science 1  ########
<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
########       Lab 1       ########
=======
########       Lab 1       ######## 
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R
########   15 Oct. 2024    ########
########                   ########
###################################
###################################


## Welcome to this first lab. Here we  will learn the basics of R, an open-source programming language and software environment.



<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
# On the right is the console. You can input code directly into the console line by line - you do not need to run an entire file. Try running a simple calculation in the console, like 5+9. Type it in and press enter.
5 + 9
=======
# On the right is the console. You can input code directly into the console line by line - you do not need to run an entire file. Try running a simple calculation in the console, like 5+9. Type it in and press enter. 
5+9
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R
# You can also write code in this, the code editor, and run it from here. Try highlighting the following line and pressing 'Ctrl + Enter' ('Cmd + Enter' on MacOS):
12 * 4 - 6


# Text beginning with a # sign is read as 'comment' and will not be evaluated by the console.
## Numbers (like 1.1, 2.3, etc) signify that I would like you to write a line a code in the code file and run it in the console

########################
<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
####    Functions   ####A
=======
####    Functions   ####
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R
########################

# FUNCTIONS are commands that take in inputs and produce outputs. They mostly take in the inputs in brackets, like this:
sqrt(25)
exp(3)

# Often, functions take multiple inputs with different functions. Note how:
<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
rep(3, 4)
# produces a different output from
rep(4, 3)
# If you can't remember in which order you have to input the arguments of a function, or if you just want to learn what a function does, you can type in ? followed by the function name in the console:
?rep
# Testing the rep function
rep(1:4, 2)
rep(1:4, each = 2)
rep(1:4, c(2, 2, 2, 2))
rep(1:4, c(2, 1, 2, 1))
rep(1:4, each = 2, length.out = 4)
rep(1:4, each = 2, length.out = 10)
rep(1:4, each = 2, length.out = 6)
rep(1:4, each = 2, times = 3)
# Each argument has a name. By explicitly referring to these names when calling the function, we can avoid  any problems with order. For example: # nolint
rep(x = 3, times = 4) # nolint: infix_spaces_linter.
rep(times = 4, x = 3) # nolint: infix_spaces_linter.
=======
rep(3,4)
# produces a different output from
rep(4,3)
# If you can't remember in which order you have to input the arguments of a function, or if you just want to learn what a function does, you can type in ? followed by the function name in the console:
?rep

# Each argument has a name. By explicitly referring to these names when calling the function, we can avoid  any problems with order. For example: # nolint
rep(x=3, times=4) # nolint: infix_spaces_linter.
rep(times=4, x=3) # nolint: infix_spaces_linter.
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R

# produce the same result, because we inputed the arguments by name using the 'argname = x' construction. When we don't use this construction, the function defaults each input to an argument according to a predefined order.

# OPERATORS are special functions that take only 2 arguments, and do not use brackets. Instead, you must input the two arguments on either side of the operator. Examples of operators include +, -,*,/, ^, %%, %/%, :, and there are many more which we will learn about soon.

########################
####     Objects    ####
########################

# Functions are one example of OBJECTS, which are stored within the main (global) ENVIRONMENT of the console. We can create new objects by using the 'assign' operator:

x <- 4

# You can now see in the 'Environment' tab below that the object 'x'  is stored with the value 4.

<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
x * 5
=======
x*5
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R

##############################################################
###    ADVANCED NOTE: the = operator can also be used      ###
###    to assign values to objects, like in Python.        ###
###    However, we conventionally use the = operator       ###
###    only for arguments in a function. The main          ###
###    difference is that '<-' always assigns within       ###
###    the global environment, while '=' assigns in        ###
###    the local environment.                              ###
##############################################################

# Objects can have different classes. For example:
class(x)

# We can also store text into an object, by surrounding it with quote marks:

"Hello" -> y
y
<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
class(y)
# testing class

=======
class (y)
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R

# y is now a 'character' object (R does not use the term 'string')

# If we forget to use quote marks R will search for a stored object with that name and return an error if it doesn't find it:

Salaam -> y

<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
# One final very important class of object is the 'logical' class, a.k.a. Boolean.

# One final very important class of object is the 'logical' class, a.k.a. Boolean.
=======
# One final very important class of object is the 'logical' class, a.k.a. Boolean. 

# One final very important class of object is the 'logical' class, a.k.a. Boolean. 
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R
# Boolean objects can take one of two values

TRUE

# and

FALSE

# Booleans can be combined according to the laws of logic using the and operator &, and the or operator |

TRUE & TRUE
TRUE & FALSE
FALSE & FALSE

TRUE | TRUE
TRUE | FALSE
FALSE | FALSE
<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
FALSE | TRUE
=======
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R

# There is also an exclusive or function, xor(), but it isn't used much.



####################################
####     Vectors and indices    ####
####################################

# YOu will have noticed that the console has always returned a [1] in front of it's output so far. This is because R has considered all these objects to be 'vectors' (in Python, this is the same thing as an array). Vectors are objects that can contain multiple elements. For example:

z <- 50:80
z

# The numbers in square brackets tell you the INDEX of the element to their right. The index is simply the position number of that element. You will notice that, unlike in Python, the first element of an object in R has the index number 1 and not 0. This is one of the most important syntactical differences between Python and R (if you think this is not a very important difference, you are correct. The two languages are very similar in syntax.)

# Vectors can be created from singular elements using the function c(), which stands for combine or concatenate.

<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
my.vector <- c("this", "is", "a", "vector")
my.vector
length(my.vector)
class(my.vector)
?class
=======
my.vector <- c('this','is','a','vector')
my.vector
length(my.vector)
class(my.vector)
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R

# You can use square brackets to isolate elements in a vector by putting their index between the brackets:
my.vector[1]
my.vector[4]
my.vector[2:4]
<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
my.vector[c(1, 4)]

### 1.1
# You can assign values to specific elements. Try writing a line of code below that changes the 4th element of my.vector to the word 'test'
my.vector[c(4)] <- "test"
my.vector

### 1.2
# You can even assign values to elements of a vector that don't exist yet, thus creating them. Try assigning the word 'example' to the (as yet non-existent) 5th element of my.vector.
my.vector[5] <- "example"
my.vector

# Instead of indices, you can select elements of a vector using a logical vector of the same length, e.g.

my.vector[c(TRUE, TRUE, FALSE, FALSE, FALSE)]
=======
my.vector[c(1,4)]

### 1.1
# You can assign values to specific elements. Try writing a line of code below that changes the 4th element of my.vector to the word 'test'


### 1.2
# You can even assign values to elements of a vector that don't exist yet, thus creating them. Try assigning the word 'example' to the (as yet non-existent) 5th element of my.vector.


# Instead of indices, you can select elements of a vector using a logical vector of the same length, e.g.

my.vector[c(TRUE,TRUE,FALSE,FALSE,FALSE)]
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R


####################################
####     Logical operators      ####
####################################

<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
# LOGICAL OPERATORS are operators that return logical vectors of the same length as the left argument. Examples include '==', the equality operator (not to be confused with the single = which is an assignment operator), >, <, >=, <=, and != (the 'different from' operator). # nolint: line_length_linter.

# For example:
my.vector == "is"
1:10 >= 5
1:10 %% 2 == 0 ## %% is the remainder operator, it returns the remainder when you divide the left argument by the right argument. # nolint

### 2.1
digits <- 0:10
digits
# Using the least amount of code possible, write a line of code that returns only the odd values of the digits object.
odd_numbers <- digits[digits %% 2 == 1]
odd_numbers


# Another important logical operator is the %in% operator. It tells you if the elements on the left are found in the elements on the right. E.G.
group1 <- c("Arthur", "Fatima", "Suleiman", "Marco")
group2 <- c("Marco", "Maria", "Victor", "Fatima", "Antonio")
group1 %in% group2

## 2.2
# intersect is a function which returns the elements that all of its arguments have in common. For example:
intersect(group1, group2)
# Write a line of code that replicates this output using only group1, group2, square brackets, and logical operators.

group2[group2 %in% group1]
=======
# LOGICAL OPERATORS are operators that return logical vectors of the same length as the left argument. Examples include '==', the equality operator (not to be confused with the single = which is an assignment operator), >, <, >=, <=, and != (the 'different from' operator).

# For example:
my.vector == 'is'
1:10 >= 5
1:10 %% 2 == 0    ## %% is the remainder operator, it returns the remainder when you divide the left argument by the right argument.

### 2.1
digits <- 0:10
# Using the least amount of code possible, write a line of code that returns only the odd values of the digits object.

# Another important logical operator is the %in% operator. It tells you if the elements on the left are found in the elements on the right. E.G.
group1 <- c('Arthur', 'Fatima', 'Suleiman', 'Marco')
group2 <- c('Marco','Maria', 'Victor','Fatima', 'Antonio')
group1 %in% group2

## 2.2 
# intersect is a function which returns the elements that all of its arguments have in common. For example:
intersect(group1,group2)
# Write a line of code that replicates this output using only group1, group2, square brackets, and logical operators.

>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R

####################################
####     Writing functions      ####
####################################

# Functions can be written and stored as objects. e.g:
<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
f1 <- function(x) x * 2 + 1
=======
f1 <- function(x) x*2 + 1
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R
f1
# This function has only 1 argument, x. Try out this new function:
f1(3)
f1(7)
<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
ex.vector <- c(2, 7, 4, 24, 13, 8, 12)
=======
ex.vector <- c(2,7,4,24,13,8,12)
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R
f1(ex.vector)

# You can write several lines of code in a function by enclosing all of the in curly brackets {}. The function 'return' can then specify what the output can be. For example:

<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
f2 <- function(x, y) {
  z <- x %% y
  return(z == 0)
}

f2(8, 9)
f2(14, 7)
=======
f2 <- function(x,y){
  z = x %% y
  return(z == 0)
}

f2(8,9)
f2(14,7)
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R

### 3.1 What is the purpose of function f2? Write in comments below.

### 3.2
# Based on the definition of the mean from today's lecture, write a function that calculates the mean of all of the elements of a vector. assign it to the object my.mean. You will find the functions 'sum' and 'length' useful here.
<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
my.mean <- function(x){
  total <- sum(x)
  z <- length(x)
  y <- total/z
  return(y)
}
ex.vector <- c(2,5,6,8,9)
my.mean(ex.vector)

=======
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R

# compare your function to the native function in R. Does it produce the same results?

my.mean(ex.vector)
mean(ex.vector)

####################################
####      Randomness in R       ####
####################################

<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
# There are several ways to generate randomness in R. The simplest function is
?sample

# which randomly draws WITHOUT replacement from a specified vector. For example, to choose a number at random between 1 and 10:
sample(1:10, 1)
# You can run this several times and notice that you get a different answer each time. You can also sample several times at once
sample(1:10, 3)
# However, by default, sample won't let the same number repeat when you do this. This is called sampling without replacement,
=======
# There are several ways to generate randomness in R. The simplest function is 
?sample

#which randomly draws WITHOUT replacement from a specified vector. For example, to choose a number at random between 1 and 10:
sample(1:10, 1)
# You can run this several times and notice that you get a different answer each time. You can also sample several times at once
sample(1:10, 3)
# However, by default, sample won't let the same number repeat when you do this. This is called sampling without replacement, 
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R
# because it is as if, each time you pick out a number, it is now gone from the pool of possible numbers and has not been replaced.
# If you want to sample randomly between 1 and 10 20 times, each time choosing between all 10 numbers, you have to write:
sample(1:10, 20, replace = TRUE)

### 4.1
<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
# Write a function that simulates the roll of 2 6-sided dice, where the argument x is the number of times you roll the 2 dice,
# and the output is a vector of length x, where each element corresponds to the sum of the two sides of the dice.
# HINT: one way to do this is to start by writing a function for a single 6-sided die, then create a new function
# that repeats the first function twice and adds up the result.

dice <- function(x){
  outcome_of_dice_one <- sample(1:6, x, replace = TRUE)
  outcome_of_dice_two <- sample(1:6, x, replace = TRUE)

  outcome <- outcome_of_dice_one + outcome_of_dice_two
  print(outcome_of_dice_one)
  print(outcome_of_dice_two)
  return(outcome)
  }
 dice(2)
### 4.2
# Using the function hist, create histograms of the results of double dice rolls when you roll them 10 times,
# then 50, then 100, then 1000, then 10000. Use breaks=1:12 as an argument within the hist function.
# What do you notice? Write it in comments below your code.
?hist
hist(dice(10), 1:12)
hist(dice(50), 1:12)
hist(dice(100), 1:12)
hist(dice(1000), 1:12)
hist(dice(10000), 1:12)

#The larger the sample used, the more symmetric the graph becomes

# Another way to generate randomness is to sample from a pdf, which is a continuous distribution.
# The simplest pdf is the uniform function. The uniform function is a flat line bounded between 2 numbers.
# Because it is flat, the probability of drawing a sample from any interval of given width between the two bounds
=======
# Write a function that simulates the roll of 2 6-sided dice, where the argument x is the number of times you roll the 2 dice, 
# and the output is a vector of length x, where each element corresponds to the sum of the two sides of the dice.
# HINT: one way to do this is to start by writing a function for a single 6-sided die, then create a new function 
# that repeats the first function twice and adds up the result.

### 4.2
# Using the function hist, create histograms of the results of double dice rolls when you roll them 10 times, 
#then 50, then 100, then 1000, then 10000. Use breaks=1:12 as an argument within the hist function. 
# What do you notice? Write it in comments below your code.


# Another way to generate randomness is to sample from a pdf, which is a continuous distribution. 
# The simplest pdf is the uniform function. The uniform function is a flat line bounded between 2 numbers. 
# Because it is flat, the probability of drawing a sample from any interval of given width between the two bounds 
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R
# is the same as from any other interval of given width.

# The function runif(n, min,max) samples n times from a uniform function bounded between the values of min and max.
# For example, try
<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
runif(5, 0, 1)
=======
runif(5,0,1)
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R

### 4.3
# Using runif, write a function that returns TRUE 22% of the time and FALSE 78% of the time

<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
prob <- function(x)
{
  outcome <- runif(x, 0,1 ) <= 0.22
  return(outcome)
}
prob(50)
### 4.4
# Based on today's lecture about pdfs, what is the probability density for a uniform pdf bounded between
# 0 and 1 associated with all values of x between 0 and 1? Explain why.
#The probability density for a uniform pdf bouneded between 0 and 1 associated with all values of x is '1'
#The reason the PDF of a uniform distribution on  [0,1] is 1 is that: Every value in the interval is equally likely, requiring a constant PDF. The total area under the PDF curve (the total probability) must sum to 1, which only happens when the constant PDF value is 1 over the interval  [0,1].
=======
### 4.4
# Based on today's lecture about pdfs, what is the probability density for a uniform pdf bounded between 
# 0 and 1 associated with all values of x between 0 and 1? Explain why.
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R

### 4.5
# Similarly, what is the probability density for a uniform pdf bounded between 5 and 6 associated with all values of x between 5 and 6?

<<<<<<< HEAD:labs/submissions/Lab 1/Lab1_Joy.R
#the probability density for a uniform pdf bouneded between 0 and 1 associated with all values of x between 5 and 6 is also 1 as shown below

pdf <- 1/(6-5)
pdf

### 4.6
# What is the probability density for a uniform pdf bounded between 0 and 0.5 associated with all values of x between 0 and 0.5?

#The probability density for a uniform pdf bounded between 0 and 0.5 associtaed with all values of x between 0 and 0.5 is 2 as shown below

pdf <- 1/(0.5-0)
pdf

### 4.7
# What is the probability density for a uniform pdf bounded between 0 and 2 associated with all values of x between 0 and 2?


#The probability density for a uniform pdf bounded between 0 and 2 associtaed with all values of x between 0 and 2 is 0.5 as shown below

pdf <- 1/(2-0)
pdf


### 4.8
# run the following code:
dunif(0.5, 0, 1)
dunif(2, 0, 1)
dunif(0.2, 0, 0.5)
dunif(1.3, 0, 2)

# Based on the results of this code and your answers above, what can you conclude about the purpose of the dunif function?

#the dunif is used in calculating the probability density of a uniform distribution across a range of values at a given point of x
=======
### 4.6
# What is the probability density for a uniform pdf bounded between 0 and 0.5 associated with all values of x between 0 and 0.5?

### 4.7
# What is the probability density for a uniform pdf bounded between 0 and 2 associated with all values of x between 0 and 2?

### 4.8
# run the following code:
dunif(0.5,0,1)
dunif(2,0,1)
dunif(0.2,0,0.5)
dunif(1.3,0,2)

# Based on the results of this code and your answers above, what can you conclude about the purpose of the dunif function?
>>>>>>> 5c44116 (Created a file inside a branch):labs/Submissions/Lab1/Lab1_Joy.R
