###################################
###################################
########                   ########
########   Data Science 1  ########
########       Lab 1       ######## 
########   15 Oct. 2024    ########
########                   ########
###################################
###################################


## Welcome to this first lab. Here we  will learn the basics of R, an open-source programming language and software environment.
#TAHA


# On the right is the console. You can input code directly into the console line by line - you do not need to run an entire file. Try running a simple calculation in the console, like 5+9. Type it in and press enter. 
5+9
# You can also write code in this, the code editor, and run it from here. Try highlighting the following line and pressing 'Ctrl + Enter' ('Cmd + Enter' on MacOS):
12 * 4 - 6


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
rep.int(x = 3, times = 4)
# produces a different output from
rep(4,3)
rep.int(x = 4, times = 3)
rep.int(times = 3, x=4)

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

a <- 4
a
print(c(a, "is", "food"))



# You can now see in the 'Environment' tab below that the object 'x'  is stored with the value 4.

y <- a*5
print(y)


ds1 <- matrix(1:25, ncol = 5, nrow = 2)
ds1
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
'a' -> y
y
class (y)

# y is now a 'character' object (R does not use the term 'string')

# If we forget to use quote marks R will search for a stored object with that name and return an error if it doesn't find it:

"Salaam" -> y
class(y)

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
z[2]

# The numbers in square brackets tell you the INDEX of the element to their right. The index is simply the position number of that element. You will notice that, unlike in Python, the first element of an object in R has the index number 1 and not 0. This is one of the most important syntactical differences between Python and R (if you think this is not a very important difference, you are correct. The two languages are very similar in syntax.)

# Vectors can be created from singular elements using the function c(), which stands for combine or concatenate.

my.vector <- c('this','is','a','vector')
my.vector
length(my.vector)
class(my.vector)
#Character Class


###oops.vector <- c('a', 'b', 'c')
###class(oops.vector)
### This is a Character Class as well


# You can use square brackets to isolate elements in a vector by putting their index between the brackets:
my.vector[1]
my.vector[4]
my.vector[2:4]
my.vector[c(1,4)]
my.vector[4] <- 'test'
my.vector[4]
my.vector[length(my.vector) + 1] <- 'example'
my.vector

thy.vector <- c(1,3,2,4)
class(thy.vector)
#Numeric Class (int)

psy.vector <- c(TRUE, FALSE)
class(psy.vector)
#Logical Class (Boolean)


a <- 1

class(a)
class(a) <- 1
nameOfClass(a)
### 1.1
# You can assign values to specific elements. Try writing a line of code below that changes the 4th element of my.vector to the word 'test'
##Done

### 1.2
# You can even assign values to elements of a vector that don't exist yet, thus creating them. Try assigning the word 'example' to the (as yet non-existent) 5th element of my.vector.
##Done

# Instead of indices, you can select elements of a vector using a logical vector of the same length, e.g.

my.vector[c(TRUE,TRUE,FALSE,FALSE,FALSE)]
my.vector[1]

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
digitsOdd <- digits[digits %% 2 == 1]
# Another important logical operator is the %in% operator. It tells you if the elements on the left are found in the elements on the right. E.G.
group1 <- c('Arthur', 'Fatima', 'Suleiman', 'Marco')
group2 <- c('Marco','Maria', 'Victor','Fatima', 'Antonio')
group1 %in% group2

## 2.2 
# intersect is a function which returns the elements that all of its arguments have in common. For example:
intersect(group1,group2)
# Write a line of code that replicates this output using only group1, group2, square brackets, and logical operators.
group1[group1 %in% group2]

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
## Ret. FALSE
f2(14,7)
## Ret. TRUE

### 3.1 What is the purpose of function f2? Write in comments below.
if(FALSE){
  #ANSWER: f2 returns the Logical aswer for the condition: x %% y == 0. If the remainder of x by y is 0, it return True; if not, it returns false.
}
  
### 3.2
# Based on the definition of the mean from today's lecture, write a function that calculates the mean of all of the elements of a vector. assign it to the object my.mean. You will find the functions 'sum' and 'length' useful here.
my.mean <- function(a){
  return(sum(a)/length(a))
}

##Another concise way of writing that function in one line would be:
## my.mean <- function(x) sum(x)/length(x)

my.mean(1:5)
#Ret. 3
# compare your function to the native function in R. Does it produce the same results?

my.mean(ex.vector)
mean(ex.vector)

mean(1.74, 1.8, 1.78, 1.89, 1.75, 1.)

#ANSWER: same results

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
# Write a function that simulates the roll of 2 6-sided dice, where the argument x is the number of times you roll the 2 die,
# and the output is a vector of length x, where each element corresponds to the sum of the two sides of the dice.
# HINT: one way to do this is to start by writing a function for a single 6-sided die, then create a new function 
# that repeats the first function twice and adds up the result.

rollDice <- function() {
  return(sample(1:6, 1))
}

roll2DiceX <- function(x) {
  rolls <- numeric(x) 
  for (i in 1:x) {
    rolls[i] <- rollDice() + rollDice()
  }
  return(rolls)
}

roll2DiceX(10)


### 4.2
# Using the function hist, create histograms of the results of double dice rolls when you roll them 10 times, 
#then 50, then 100, then 1000, then 10000. Use breaks=1:12 as an argument within the hist function. 
# What do you notice? Write it in comments below your code.
# Plot histograms for different sample sizes
par(mfrow=c(2,3))  # Set up the plotting area to show multiple histograms
hist(roll2DiceX(10), breaks=1:12, main="10 Rolls", xlab="Sum of Two Dice", col="lightblue")
hist(roll2DiceX(50), breaks=1:12, main="50 Rolls", xlab="Sum of Two Dice", col="lightblue")
hist(roll2DiceX(100), breaks=1:12, main="100 Rolls", xlab="Sum of Two Dice", col="lightblue")
hist(roll2DiceX(1000), breaks=1:12, main="1000 Rolls", xlab="Sum of Two Dice", col="lightblue")
hist(roll2DiceX(10000), breaks=1:12, main="10000 Rolls", xlab="Sum of Two Dice", col="lightblue")

# Reset plotting area
par(mfrow=c(1,1))



# Another way to generate randomness is to sample from a pdf, which is a continuous distribution. 
# The simplest pdf is the uniform function. The uniform function is a flat line bounded between 2 numbers. 
# Because it is flat, the probability of drawing a sample from any interval of given width between the two bounds 
# is the same as from any other interval of given width.

# The function runif(n, min,max) samples n times from a uniform function bounded between the values of min and max.
# For example, try
runif(5,0,1)

### 4.3
# Using runif, write a function that returns TRUE 22% of the time and FALSE 78% of the time
true_false_22_78 <- function() {
  return(runif(1) <= 0.22)
}

true_false_22_78()
results <- replicate(1000, true_false_22_78())
mean(results)

### 4.4
# Based on today's lecture about pdfs, what is the probability density for a uniform pdf bounded between 
# 0 and 1 associated with all values of x between 0 and 1? Explain why.
##ANSWER: pdf of the uniform distribution is 1/(b-a). with b being 1 and a being 0.
## => pdf(unif) = 1/(1-0) = 1
### 4.5
# Similarly, what is the probability density for a uniform pdf bounded between 5 and 6 associated with all values of x between 5 and 6?
##ANSWER: pdf = 1/(b-a) = 1/(6 - 5) = 1
### 4.6
# What is the probability density for a uniform pdf bounded between 0 and 0.5 associated with all values of x between 0 and 0.5?
##ANSWER: To first compute the pdf, we have to compute 1/(b-a) = 1/(.5 - 0) = 2.
### 4.7
# What is the probability density for a uniform pdf bounded between 0 and 2 associated with all values of x between 0 and 2?

##ANSWER:
## 1/(b-a) = 1/(2-0) = .5
## pdf:
  ## p({0, 2}) = 0.5; p(x > 2 | x < 0) = 0.5 
##
### 4.8
# run the following code:
dunif(0.5,0,1)
dunif(2,0,1)
dunif(0.51,0,0.5)
dunif(1.3,0,2)

# Based on the results of this code and your answers above, what can you conclude about the purpose of the dunif function?

if(FALSE){

##Here's The console output for the four calls above:
#[1] 1
#[1] 0
#[1] 2
#[1] 0.5

#From the following outputs, here is what I can deduce about the behaviour of the dunif function:
 # => The first arg. is the x in p(x).
  #=> We're checking if the x falls between the 2nd and 3rd Arg.
  #=> If it does fall within the range; then the probability of it occuring is the output.
  #=> Else, 0.
#

}
