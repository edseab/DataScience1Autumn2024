###################################
###################################
########                   ########
########   Data Science 1  ########
########       Lab 1       ######## 
########   10 Oct. 2023    ########
########                   ########
###################################
###################################


## Welcome to this first lab. Here we  will learn the basics of R, an open-source programming language and software environment.



# On the right is the console. You can input code directly into the console line by line - you do not need to run an entire file. Try running a simple calculation in the console, like 5+9. Type it in and press enter. 
5+9
# You can also write code in this, the code editor, and run it from here. Try highlighting the following line and clicking 'Run':
12 * 4 - 6

# You can also press 'Ctrl (Cmd) + Enter' to run the code you have highlighted.

# Text beginning with a # sign is read as 'comment' and will not be evaluated by the console.
## Numbers (like 1.1, 2.3, etc) signify that I would like you to write a line a code in the code file and run it in the console

########################
####    Functions   ####
########################

# FUNCTIONS are commands that take in inputs and produce outputs. They mostly take in the inputs in brackets, like this:
sqrt(25)
exp(3)

# Often, functions take multiple inputs with different functions. Note how:
rep(3,4)
# produces a different output from
rep(4,3)
# If you can't remember in which order you have to input the arguments of a function, or if you just want to learn what a function does, you can type in ? followed by the function name in the console:
?rep

# Each argument has a name. By explicitly referring to these names when calling the function, we can avoid  any problems with order. For example:
rep(x=3, times=4)
rep(times=4, x=3)

# produce the same result, because we inputed the arguments by name using the 'argname = x' construction. When we don't use this construction, the function defaults each input to an argument according to a predefined order.

# OPERATORS are special functions that take only 2 arguments, and do not use brackets. Instead, you must input the two arguments on either side of the operator. Examples of operators include +, -,*,/, ^, %%, %/%, :, and there are many more which we will learn about soon.

########################
####     Objects    ####
########################

# Functions are one example of OBJECTS, which are stored within the main (global) ENVIRONMENT of the console. We can create new objects by using the 'assign' operator:

x <- 4

# You can now see in the 'Environment' tab below that the object 'x'  is stored with the value 4.

x*5

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
class (y)

# y is now a 'character' object (R does not use the term 'string')

# If we forget to use quote marks R will search for a stored object with that name and return an error if it doesn't find it:

Salaam -> y

# One final very important class of object is the 'logical' class, a.k.a. Boolean. 

# One final very important class of object is the 'logical' class, a.k.a. Boolean. 
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

# There is also an exclusive or function, xor(), but it isn't used much.



####################################
####     Vectors and indices    ####
####################################

# YOu will have noticed that the console has always returned a [1] in front of it's output so far. This is because R has considered all these objects to be 'vectors' (in Python, this is the same thing as an array). Vectors are objects that can contain multiple elements. For example:

z <- 50:80
z

# The numbers in square brackets tell you the INDEX of the element to their right. The index is simply the position number of that element. You will notice that, unlike in Python, the first element of an object in R has the index number 1 and not 0. This is one of the most important syntactical differences between Python and R (if you think this is not a very important difference, you are correct. The two languages are very similar in syntax.)

# Vectors can be created from singular elements using the function c(), which stands for combine or concatenate.

my.vector <- c('this','is','a','vector')
my.vector
length(my.vector)
class(my.vector)

# You can use square brackets to isolate elements in a vector by putting their index between the brackets:
my.vector[1]
my.vector[4]
my.vector[2:4]
my.vector[c(1,4)]


### 1.1
# You can assign values to specific elements. Try writing a line of code below that changes the 4th element of my.vector to the word 'test'
my.vector[4] <- "test"

### 1.2
# You can even assign values to elements of a vector that don't exist yet, thus creating them. Try assigning the word 'example' to the (as yet non-existent) 5th element of my.vector.
my.vector[5] <- "example"

# Instead of indices, you can select elements of a vector using a logical vector of the same length, e.g.

my.vector[c(TRUE,TRUE,FALSE,FALSE,FALSE)]
 

####################################
####     Logical operators      ####
####################################

# LOGICAL OPERATORS are operators that return logical vectors of the same length as the left argument. Examples include '==', the equality operator (not to be confused with the single = which is an assignment operator), >, <, >=, <=, and != (the 'different from' operator).

# For example:
my.vector == 'is'
1:10 >= 5
1:10 %% 2 == 0    ## %% is the remainder operator, it returns the remainder when you divide the left argument by the right argument.

### 2.1
digits <- 0:10
# Using the least amount of code possible, write a line of code that returns only the odd values of the digits object.
0:10 %% 2 == 1 
digits %% 2 == 1
digits [c(digits %% 2 == 1)]

digits[digits %% 2 == 1]

# Another important logical operator is the %in% operator. It tells you if the elements on the left are found in the elements on the right. E.G.
group1 <- c('Arthur', 'Fatima', 'Suleiman', 'Marco')
group2 <- c('Marco','Maria', 'Victor','Fatima', 'Antonio')
group1 %in% group2

## 2.2 
# intersect is a function which returns the elements that all of its arguments have in common. For example:
intersect(group1,group2)
<<<<<<<< HEAD:labs/submissions/Lab 1/Oluwafemi_Lab 1.R
# Write a line of code that replicates this output using only group1, group2, square brackets, and logical operators.
group1[group1 %in% group2]
# OR
group2[group2 %in% group1]
========
>>>>>>>> origin/main:labs/submissions/Lab 1/Jochebed_Lab 1.R

# Write a line of code that replicates this output using only group1, group2, square brackets, and logical operators.
group1 [c(group1 %in% group2)]
group1 [group1 %in% group2]

####################################
####     Writing functions      ####
####################################

# Functions can be written and stored as objects. e.g:
f1 <- function(x) x*2 + 1
f1
# This function has only 1 argument, x. Try out this new function:
f1(3)
f1(7)
ex.vector <- c(2,7,4,24,13,8,12)
f1(ex.vector)

# You can write several lines of code in a function by enclosing all of the in curly brackets {}. The function 'return' can then specify what the output can be. For example:

f2 <- function(x,y){
  z = x %% y
  return(z == 0)
}

f2(8,9)
f2(14,7)
f3 <- function(x,y) x %% y
f3 (7,6)

### 3.1 What is the purpose of function f2? Write in comments below.
f2 helps us know if x is divisible by y

## f2 returns TRUE if x is a multiple of y (x is divisible by y, the remainder of x/y is 0), FALSE otherwise

### 3.2
# Based on the definition of the mean from today's lecture, write a function that calculates the mean of all of the elements of a vector. assign it to the object my.mean.
#You will find the functions 'sum' and 'length' useful here.

<<<<<<<< HEAD:labs/submissions/Lab 1/Oluwafemi_Lab 1.R
my.mean <- function(x) sum(x)/length(x)

========
my.mean <- function(x) sum(x) / length(x) 
my.mean 
 
>>>>>>>> origin/main:labs/submissions/Lab 1/Jochebed_Lab 1.R
# compare your function to the native function in R. Does it produce the same results?

my.mean(ex.vector)
mean(ex.vector)

####################################
####      Randomness in R       ####
####################################

# There are several ways to generate randomness in R. The simplest function is 
?sample

#which randomly draws WITHOUT replacement from a specified vector. For example, to choose a number at random between 1 and 10:
sample(1:10, 1)
# You can run this several times and notice that you get a different answer each time. You can also sample several times at once
sample(1:10, 3)
# However, by default, sample won't let the same number repeat when you do this. This is called sampling without replacement, 
# because it is as if, each time you pick out a number, it is now gone from the pool of possible numbers and has not been replaced.
# If you want to sample randomly between 1 and 10 20 times, each time choosing between all 10 numbers, you have to write:
sample(1:10, 20, replace = TRUE)

### 4.1
# Write a function that simulates the roll of 2 6-sided dice, where the argument x is the number of times you roll the 2 dice, 
# and the output is a vector of length x, where each element corresponds to the sum of the two sides of the dice.
# HINT: one way to do this is to start by writing a function for a single 6-sided die, then create a new function that repeats the first function twice and adds up the result.

cast.die <- function(x){
  sample(1:6,x,replace=TRUE)
}

cast.2.dice <- function(x){
return(cast.die(x)+cast.die(x))
}

cast.2.dice(20)

roll_die <- function() {
  sample(1:6, 1, replace = TRUE)
}
roll_two_dice <- function(x) {
  # Roll the two dice x times and sum the results
  dice_rolls <- replicate(x, roll_die() + roll_die())
  return(dice_rolls)
}


### 4.2
# Using the function hist, create histograms of the results of double dice rolls when you roll them 10 times, 
#then 50, then 100, then 1000, then 10000. Use breaks=1:12 as an argument within the hist function. 
# What do you notice? Write it in comments below your code.

<<<<<<<< HEAD:labs/submissions/Lab 1/Oluwafemi_Lab 1.R
set.seed(105)
hist(cast.2.dice(10),breaks=1:12)
hist(cast.2.dice(50),breaks=1:12)
hist(cast.2.dice(100),breaks=1:12)
hist(cast.2.dice(1000),breaks=1:12)
hist(cast.2.dice(10000),breaks=1:12)

## The more dice we roll, the more the histogram looks like the probability mass function derived in class
========
par(mfrow = c(3, 2))
hist(roll_two_dice(10), breaks = 1:12, main = "10 Rolls", xlab = "Sum of Two Dice", col = "lightblue")

hist(roll_two_dice(50), breaks = 1:12, main = "50 Rolls", xlab = "Sum of Two Dice", col = "lightblue")

hist(roll_two_dice(100), breaks = 1:12, main = "100 Rolls", xlab = "Sum of Two Dice", col = "lightblue")

hist(roll_two_dice(1000), breaks = 1:12, main = "1000 Rolls", xlab = "Sum of Two Dice", col = "lightblue")


hist(roll_two_dice(10000), breaks = 1:12, main = "10000 Rolls", xlab = "Sum of Two Dice", col = "lightblue")

par(mfrow = c(1, 1))

>>>>>>>> origin/main:labs/submissions/Lab 1/Jochebed_Lab 1.R

# Another way to generate randomness is to sample from a pdf, which is a continuous distribution. 
# The simplest pdf is the uniform function. The uniform function is a flat line bounded between 2 numbers. 
# Because it is flat, the probability of drawing a sample from any interval of given width between the two bounds 
# is the same as from any other interval of given width.

# The function runif(n, min,max) samples n times from a uniform function bounded between the values of min and max.
# For example, try
runif(5,0,1)

### 4.3
# Using runif, write a function that returns TRUE 22% of the time and FALSE 78% of the time

<<<<<<<< HEAD:labs/submissions/Lab 1/Oluwafemi_Lab 1.R
generate.bool.22 <- function(x){
  s <- runif(x,0,1)
  return(s<0.22)
}

o1 <- generate.bool.22(10)
hist(as.numeric(o1))
o2 <- generate.bool.22(1000000)
hist(as.numeric(o2))
========
random_bool <- function() {
  return(runif(1, 0, 1) <= 0.22)
}
true.22.per()
results <- replicate (1000, true.22.per())
mean (results)

>>>>>>>> origin/main:labs/submissions/Lab 1/Jochebed_Lab 1.R
### 4.4
# Based on today's lecture about pdfs, what is the probability density for a uniform pdf bounded between 
# 0 and 1 associated with all values of x between 0 and 1? Explain why.

<<<<<<<< HEAD:labs/submissions/Lab 1/Oluwafemi_Lab 1.R
# Answer: 1, because the total area under the curve must equal one, and the non-zero values of x must be in the interval [0,1], which is of length 1, so the y-axis value must also be 1 for these values of x in order for the rectangle to have area 1.
========
#The probability density for a uniform pdf bouneded between 0 and 1 associated with all values of x is '1'
#The reason the PDF of a uniform distribution on  [0,1] is 1 is that: Every value in the interval is equally likely, requiring a constant PDF. The total area under the PDF curve (the total probability) must sum to 1, which only happens when the constant PDF value is 1 over the interval  [0,1].

>>>>>>>> origin/main:labs/submissions/Lab 1/Jochebed_Lab 1.R

### 4.5
# Similarly, what is the probability density for a uniform pdf bounded between 5 and 6 associated with all values of x between 5 and 6?
pdf <- 1/(6-5)
pdf

# Answer: 1. Same reason as before since the length of the interval is 1.

### 4.6
# What is the probability density for a uniform pdf bounded between 0 and 0.5 associated with all values of x between 0 and 0.5?

<<<<<<<< HEAD:labs/submissions/Lab 1/Oluwafemi_Lab 1.R
# Answer: 2. Since the width of the interval is now 0.5, the height of the rectangle must be 2 for the area (height*width) to be equal to 1. 
========
#The probability density for the uniform pdf in this case is 1/(0.5-0) = 2
>>>>>>>> origin/main:labs/submissions/Lab 1/Jochebed_Lab 1.R

### 4.7
# What is the probability density for a uniform pdf bounded between 0 and 2 associated with all values of x between 0 and 2?

<<<<<<<< HEAD:labs/submissions/Lab 1/Oluwafemi_Lab 1.R
# Answer: 0.5. Since the width of the interval is now 2, the height of the rectangle must be 0.5 for the area to be equal to 1.
========
# The Uniform PDF bounded by 0 and 2 is "0.5"
# i.e. 1/(2-0) = 0.5
>>>>>>>> origin/main:labs/submissions/Lab 1/Jochebed_Lab 1.R

### 4.8
# run the following code:
dunif(0.5,0,1)
dunif(2,0,1)
dunif(0.2,0,0.5)
dunif(1.3,0,2)

# Based on the results of this code and your answers above, what can you conclude about the purpose of the dunif function?

<<<<<<<< HEAD:labs/submissions/Lab 1/Oluwafemi_Lab 1.R
# dunif returns the probability density of the uniform distribution, where the first argument is the value of x to evaluate the pdf, and the second and third arguments are the lower and upper bounds of the uniform distribution.

x.values <- seq(-5,+5,0.01)
y.values <- dunif(x.values,0,1)

plot(x.values, y.values,type='l', ylim=c(0,5))
========
# the function dunif(x,y,z) is a function that takes 3 parameters x,y,z
# where y and z represents the boundary of the unifrm distribution 
# and x represents the number whose probability density we are to check
# we can observe that when the value of x is outside the range, we get the probability density of 0
# which corresponds to the probability density of a uniform distribution

>>>>>>>> origin/main:labs/submissions/Lab 1/Jochebed_Lab 1.R

