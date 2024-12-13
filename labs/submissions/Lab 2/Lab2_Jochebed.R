###################################
###################################
########                   ########
########   Data Science 2  ########
########       Lab 2       ######## 
########  22nd Oct. 2024   ########
########                   ########
###################################
###################################


# Welcome to lab number 2. Let's learn some new R concepts.

########################
####  1. Matrices   ####
########################



# Now is a good time to point out that R will automatically read T as TRUE and F as FALSE, which can be a time-saver.

# Let's define 3 vectors. Each one represents the box office numbers from the first three Star Wars movies. 
# The first element of each vector indicates the US box office revenue,
# the second element refers to the Non-US box office.







# we can give matrices rownames and column names

rownames(star_wars_matrix) <- c("A new hope", "The empire strikes back", "Return of the Jedi")
colnames(star_wars_matrix) <- c("US revenue", "International revenue")

### 1.1
# Some important base R functions to know: colSums, rowSums, colMeans, rowMeans
# Use one of the above functions to calculate the total revenue for each movie (the sum of the US and international revenue)
# and save it in an object called total_revenue
total_revenue <- rowSums(star_wars_matrix)

# We can now add this vector as a new column using the function cbind (column bind)
star_wars_matrix <- cbind(star_wars_matrix, total_revenue)

### 1.2
# Rename the 3rd element of the column names of star_wars_matrix to "Total revenue"
colnames(star_wars_matrix) <- c("US revenue", "International revenue", "Total revenue")
colnames(star_wars_matrix)[3] <- "Total revenue"

# Now lets create vectors for the box office returns of the prequel trilogy
phantom_menace <- c(474.5,552.5)
attack_of_clones <- c(310.7,338.7)
revenge_of_sith <- c(380.3, 468.5)


### 1.3
# Turn these 3 vectors into a matrix, add a column for total revenue, 
# and append them to star_wars_matrix using the function rbind (row bind)
prequel_trilogy_matrix <- matrix(c(phantom_menace, attack_of_clones, revenge_of_sith), byrow = T, nrow = 3)
total_revenue <- rowSums(prequel_trilogy_matrix)
prequel_trilogy_matrix <- cbind(prequel_trilogy_matrix, total_revenue)

all <- rbind(star_wars_matrix, prequel_trilogy_matrix)
rownames(all)[4] <- "phantom_menace"
rownames(all)[5] <- "attack_of_clones"
rownames(all)[6] <- "revenge_of_sith"

# Matrices are understood by R to be both one-dimensional, because they are vectors folded onto themselves
# into columns, but also 2 dimensional, because they have rows and columns. 
# So you can index them like this:
star_wars_matrix[4]

# but also like this
star_wars_matrix[3, 1]

# When you put a comma in between square brackets, you are indexing both the rows (to the left of the comma),
# and the columns (to the right of the comma).

### 1.4 
# Write a line of code to extract the international revenue of the Phantom Menace (the 4th movie) using numbers to index the matrix
all[4, 2]

# Compare this to the following:
star_wars_matrix["The Phantom Menace", "Total revenue"]

# This works because our matrix has row and column names.

# If you try to include a comma in the index of a one-dimensional object (like a vector),
# you get an error message:
new_hope[1,2]

# If you leave a blank space either to the left or the right of the comma, you select for ALL the rows
# or ALL the columns, respectively
star_wars_matrix[,2]
star_wars_matrix[4,]

# Just like multiplying 2 vectors of the same length together will multiply each of the corresponding elements
# the same will work with 2 matrices of the same dimensions

star_wars_matrix[1:3,] * star_wars_matrix[4:6,] 

# But for matrix multiplication (the kind used in linear algebra), you must use %*%

#####################
####  2. Lists   ####
#####################

# Lists are extremely useful objects in R. 
# With a list, you can save lots of different objects into one object.

my_list <- list(c("red,green"), 1:5, FALSE, matrix(1:9,3,3))
my_list

my_list[3]

# You can even have lists inside of lists, recursively
my_list_2 <- list(my_list,c("Hello","World"))
my_list_2

# You cane name the elements of a list with names()
names(my_list) <- c("colours","digits","boolean","matrix")

my_list

# and you can access each element of a list with the $ operator
my_list$boolean

### 2.1
# Using the $ operator, replace the "matrix" element of my_list with the star_wars_matrix
my_list$matrix <- star_wars_matrix

# Finally, you can turn any list into a vector with unlist().
unlist(my_list)

# If the classes of each of the elements are different, it will automatically convert them all 
# to the 'character' class so they are all compatible

###########################
#### 3.  Data frames   ####
###########################

# Data frames are also 2-dimensional objects, with rows and columns.
# However, data frames are not, like matrices, single vectors folded onto themselves.
# Instead, they are special kinds of list, where each element of the list is a vector 
# of the same length, but possibly of different classes, each of which is a column of the
# data frame.

# Most data you will work with in R will be in a data frame. 
# Lets load one that comes automatically with your R installation:

data("iris")
class(iris)

# just like with functions, we can learn about these in-built data frames with the ? sign
?iris

# but even when this information isn't at hand, we can run:
str(iris)
head(iris)
summary(iris)

# which each give you different information about the data frame.

# Just like lists, you can call each column using the $ operator
iris$Sepal.Length

# Let's do some basic data visualization in R:
# First, a histogram
hist(iris$Sepal.Length)

# Next, a scatterplot
plot(iris$Petal.Length,iris$Petal.Width)


###############################
#### 4.  More Randomness   ####
###############################

## SETTING THE SEED
# Remember this?
sample(1:100,1)
sample(1:100,1)
sample(1:100,1)

# Those of you with background in computer science or data science probably know
# that true randomness doesn't really exist in comupters. Instead, the appearance of randomness
# is created by generating a different 'seed' number at every different point in time
# often generated by the actual internal clock of the computer
# and basing all 'random' sampling from this seed.
# As a result, we can set our own seed and generate our own randomness:

set.seed(123)
sample(1:100, 1)

# You got 31, right? Run it again and see:

set.seed(123)
sample(1:100,1)

# Any time we want to make sure we get the same results as one another despite having some
# element of random sampling in out code, we will set the seed to be the same.

## RANDOM DISTRIBUTIONS 

# Remember the formula for the Binomial distribution:
### P(W=k) = p^k*(1-p)^(N-k)*(n|k)

# Where (n|k) = n!/(k!(n-k)!)

### 4.1
# Write a function to calculate the probability of exactly k successes
# out of n attempts each with probabiliy p of success,
# where n, k and p are arguments of the function
# To do this you will need to use either the factorial() function
# or the choose() function
binom <- function(n, k, p){
  nk = factorial(n) / (factorial(k) * factorial(n-k))
  bin = p^k * (1-p) ^(n-k) * nk 
  return (bin)
}
# probability is 0.2334744405

# use your function to calculate the probability that when the aliens send 10 probes to Earth
# (probability of water = 0.7), exactly 8 of those probes will send a signal of water
binom(n = 10, k = 8, p = 0.7)

# compare this to dbinom(8,10,0.7)
# Parameters

### PROBABILITY FUNCTIONS IN R 
# dbinom, dnorm, dunif, dbeta, .... all of these functions calculate f(x) for any given x
# for each of their relative distributions
# in other words, they calculate probability MASS or probability DENSITY for each of
# these distributions

# rbinom, rnorm, runif, rbeta, .... all SAMPLE from these respective distributions,
# i.e. they generate random draws of x in proportion to their respective f(x) in these distributions.

### 4.2
# The aliens send 20 probes to an unknown planet.
# 11 of them signal Water, the rest signal Land
# They want to know if this planet could possibly be Earth
# Their main astronomer thinks it is unlikely, as Earth has 70% water
# and less than 60% of the probes signalled water
# She asks the statistician: if this planet IS Earth,
# what is the probability that the probes would have returned
# this few Water signals (or fewer).
# Using rbinom(), simulate 100,000 universes where the aliens sent out 20 probes to Earth
# and calculate in what percentage of these universes the number of probes signalling Water is 11 or fewer
# What do you conclude to the astronomer?
universes <- rbinom(1:100000, 20)

n = 20, k = 11, p = 0.7

num_probes <- 20
num_universes <- 100000
prob_water <- 0.7 

results <- rbinom(num_universes, num_probes, prob_water)

percentage <- sum(results <= 11) / num_universes * 100
# percentage of universes 11.32

# pbinom, pnorm, punif, pbeta, .... all calculate the area under the curve of a given distribution,
# in the LOWER tail (if lower.tail=TRUE, by default), or the UPPER tail (if you set it to false)

# So for example, if a person of 195 cm was drawn from a gaussian distribution of heights,
# with mean 175cm and standard deviation 10cm, What percentile would they be in?
pnorm(195, mean =  175, sd = 10, lower.tail=FALSE)
# They would be in the upper 2.3 percentile

# qbinom, qnorm, qunif, qbeta, .... all calculate value of x for which
# the area under the curve of a given distribution in the lower tail 
# is equal to the given number

# For example, in a Gaussian distribution of people's heights with mean 175cm and standard deviation 10cm,
# How tall is someone in the bottom 10th percentile? 
qnorm(0.1, 175, 10)
# In the upper 10th percentile?
qnorm(0.9, 175, 10)
# Compare this to:
qnorm(0.1,175, 10, lower.tail=FALSE)

### 4.3
# Let's run a Welch's t-test comparing the heights of men and women in class
men_heights <- c(175, 180, 165, 170, 185)  # Example heights in cm
women_heights <- c(160, 155, 170, 165, 162)  # Example heights in cm


# Write a Welch's t-test function for any two samples x1 and x2
my_t <- function(x1,x2){
  # first, extract the means, variances and Ns of the two samples and save thel to
  n1 <- length(men_heights)
  m1 <- mean(men_heights)
  s1 <- sd(men_heights)
  n2 <- length(women_heights)
  m2 <- mean(women_heights)
  s2 <- sd(women_heights)
 
  # next, calculate the average standard deviation using the formula shown in the class on slide 44:
 
  s <- sqrt((s1^2/n1)+(s2^2/n2))

  # next, calculate the t-statistic, again as shown on slide 44
 
  t <- (m1 - m2) / s
 
 
  # next, calculate the degrees of freedom (again see slide 44)
  # make sure you use parentheses correctly here
 
  df <- ((s1^2 / n1 + s2^2 / n2)^2) / 
      (((s1^2 / n1)^2 / (n1 - 1)) + ((s2^2 / n2)^2 / (n2 - 1)))
 
  # next, calculate the probability that the t-statistic would be greater than the absolute value of the t-statistic that you calculated if the TRUE difference between the groups was 0
  # to do this, you can use function pt
  p_value <- pt(abs(t), df=df, lower.tail = F)*2

  return(list(t = t, df = df, p_value=p_value))
  }

# compare this function to the in-built t-test
t.test(men_heights,women_heights)
my_t(men_heights,women_heights)

# One last question to ponder before next class: Why did we multiply the p-value by 2 in the above function?

probability<-pnorm(145,175,20)
percentage <- probability * 100
percentage


pnorm(-1.96)*2

set.seed(123)
heights <- rnorm(30, 175, 15)
mean(heights)
sd(heights)
sem <- sd(heights)/sqrt(length(heights))
sem
upperCI97 <- mean(heights) + sem*qnorm(0.985)
lowerCI97 <- mean(heights) - sem*qnorm(0.985)
CIs97 <- c(lowerCI97, upperCI97)
CIs97