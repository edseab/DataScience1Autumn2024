Lab 1 answers 

my.vector <- c('this','is','a','vector')

1.1
my.vector[4] <- 'test'

1.2
my.vector[5] <- "example"

digits < - 0:10 

2.1
digits[digits %% 2 == 1]


group1 <- c('Arthur', 'Fatima', 'Suleiman', 'Marco')
group2 <- c('Marco', 'Maria', 'Victor', 'Fatima', 'Antonio') 


2.2
group1[group1 %in% group2]

3.1
#Function f2 returns whether there is a nonzero remainder when x is divided by y (so, whether x is divisible by y).

3.2
my.mean <- function(vector) sum(vector) / length(vector)

4.1
twodice <- function(rolls){
  replicate(rolls, sample(6, 1, replace = TRUE) + sample(6, 1, replace = 
  TRUE))
  }

4.2
data = twodice(10)
hist(data,breaks=1:12)
data100 = twodice(100)
hist(data100,breaks=1:12)
data1000 = twodice(1000)
hist(data1000,breaks=1:12)
data10000 = twodice(10000)
hist(data10000,breaks=1:12)
#When sample size approaches infinity, the distribution of outcomes 
#becomes more and more normal around 7.

4.3
funct <- function(times,x){
    output <- runif(times,0,1)
    return(output <= x)
    }
funct(5,.22)

4.4
#One way of reasoning about this is that by definition, in a probability density function, the surface of the area under the curve needs to equal 1 (the definite integral of the function over that interval is 1).  Since area = y*x and we know that x = xf-xi = 1-0 = 1, y needs to equal 1 since the only value of y that satisfies y*1 = 1 is 1. So from that we know that the interval y needs to equal 1.
#By definition of a uniform distribution, the probability of each occurrence is equal, which means y needs to be constant throughout. Now, the only way for 1) y to be constant and 2) the y-interval to equal 1 is for y to equal 1 for each value of x in the interval. 

4.5
#1, by the same reasoning.

4.6
#0.5-0 = 0.5 --> y*0.5=1 --> y = 2.

4.7
#2-0 =2 --> y*2=1 --> y = 0.5. 

4.8
#it seems to return the probability density of the first argument input value assuming a uniform distribution over the interval defined by the second and third argument input values.

  
  