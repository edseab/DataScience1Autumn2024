###################################
###################################
########                   ########
########   Data Science 1  ########
<<<<<<< HEAD
########       Lab 4       ########
=======
########       Lab 4       ######## 
>>>>>>> 9561721 (created lab 4)
########  5th Nov. 2023    ########
########                   ########
###################################
###################################

## Welcome to lab #4. Today we will start with an introduction to plotting in base R

########################
####    Factors     ####
########################

# Quick note before we start on plotting. One final type of variable we haven't looked at yet is factors
# Factors are used for categorical data. Instead of just allowing any value, like a character variable, factors only allow one of a fixed number of 'levels', with one level serving as a 'reference category'.
<<<<<<< HEAD
# To change the reference category, you can use
=======
# To change the reference category, you can use 
>>>>>>> 9561721 (created lab 4)
# relevel(x, ref=...)

# For now, just bear in mind that sometimes in certain statistical packages, character variables will need to be recoded as factors using factor(),
# and other times variables that shouldn't be factors get loaded as such and need to be changed back with as.character().

########################
####    Datasets    ####
########################

# R contains a number of inbuilt datasets
# To see a list of them, run
data()

# To load one into your environment, run for example
data(mtcars)

########################
####    Plotting    ####
########################

# Base R has a lot of good functions for plotting, and can be very powerful.

# run the following:
example("plot")
# to get a series of examples of things you can do with the plot() function

# Plot() is the most basic function, and with no arguments it creates a scatterplot.
# it can either take an x variable and a y variable as its 2 first arguments, or it can take a formula
<<<<<<< HEAD
plot(mtcars$wt, mtcars$mpg)
plot(mtcars$mpg ~ mtcars$wt)

# You can change the shape of the points in a scatterplot with the 'pch' argument
plot(mtcars$wt, mtcars$mpg, pch = 20)
# There are 25 preset values for the scatterplot points. To see them all run:
plot(1:25, rep(1, 25), pch = 1:25)

# You can also put in any symbol you like in quote marks:
plot(mtcars$wt, mtcars$mpg, pch = "$")
plot(mtcars$wt, mtcars$mpg, pch = "✌")

# To change x axis and y axis labels, and add a title you can use
plot(mtcars$wt, mtcars$mpg, pch = 20, xlab = "Weight (1000 lbs)", ylab = "Fuel efficiency (mpg)", main = "Association between car weight and fuel efficiency")

# And to change the range of the plot, use
plot(mtcars$wt, mtcars$mpg, pch = 20, ylim = c(0, 40), xlim = c(0, 7))

# Instead of a scatterplot, you can change the type of the plot using 'type'
x <- seq(-4, 4, 0.2)
y <- dnorm(x)

plot(x, y, pch = 20)
plot(x, y, type = "l")
plot(x, y, type = "h")
plot(x, y, type = "b")
plot(x, y, type = "s")
plot(x, y, type = "o")

# And the color using col
plot(x, y, type = "o", col = "red")
=======
plot(mtcars$wt,mtcars$mpg)
plot(mtcars$mpg~mtcars$wt)

# You can change the shape of the points in a scatterplot with the 'pch' argument
plot(mtcars$wt,mtcars$mpg, pch=20)
# There are 25 preset values for the scatterplot points. To see them all run:
plot(1:25,rep(1,25),pch=1:25)

# You can also put in any symbol you like in quote marks:
plot(mtcars$wt,mtcars$mpg, pch="$")
plot(mtcars$wt,mtcars$mpg,pch="✌")

# To change x axis and y axis labels, and add a title you can use
plot(mtcars$wt,mtcars$mpg, pch=20, xlab='Weight (1000 lbs)', ylab='Fuel efficiency (mpg)', main='Association between car weight and fuel efficiency')

# And to change the range of the plot, use
plot(mtcars$wt,mtcars$mpg, pch=20, ylim = c(0,40), xlim = c(0,7))

# Instead of a scatterplot, you can change the type of the plot using 'type'
x <- seq(-4,4,0.2)
y <- dnorm(x)

plot(x,y,pch=20)
plot(x,y,type='l')
plot(x,y,type='h')
plot(x,y,type='b')
plot(x,y,type='s')
plot(x,y,type='o')

# And the color using col
plot(x,y,type='o', col='red')
>>>>>>> 9561721 (created lab 4)

# For colors you can use preloaded R colors, which you can look up here:
# https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf

# You can also use hex codes, such as:
<<<<<<< HEAD
plot(dnorm(seq(-4, 4, 0.2)), type = "o", col = "#6D1ACF")
=======
plot(dnorm(seq(-4,4,0.2)),type='o', col='#6D1ACF')
>>>>>>> 9561721 (created lab 4)

# Pick your own color and find its hex code here:
# https://htmlcolorcodes.com/color-picker/
# or use the built-in color picker in Positron/VSCode

# For turning frequencies into histograms or density plots,
<<<<<<< HEAD
# use hist() and density()
=======
# use hist() and density() 
>>>>>>> 9561721 (created lab 4)

# For barplots and boxplots, we use barplot() and boxplot()
# In barplot, we can use the argument beside = T or beside = F to make a clustered or a stacked bar chart


# Axes can be removed from the original plot using xaxt='n' and yaxt = 'n'
# New axes can be added using the axis() function
<<<<<<< HEAD
# text(), segments(), arrows(), polygon(), legend(), add these respective elements to your plot.
=======
# text(), segments(), arrows(), polygon(), legend(), add these respective elements to your plot. 
>>>>>>> 9561721 (created lab 4)
# Experiment with them or run ?text, ?segments, etc. to find out more.

# Fonts can be changed using the arguments cex (for size), family (for font type), and font (for bold or italics)

# Straight lines can be added to plots using abline()
<<<<<<< HEAD
plot(x, y, type = "l", xlim = c(-4, 4))
abline(v = 0)

plot(mtcars$wt, mtcars$mpg, pch = 20, ylim = c(0, 40), xlim = c(0, 7))
abline(v = 0, h = 0, lm(mpg ~ wt, data = mtcars))

# Layers of different points or lines can be added to a plot using points() and lines()
smallcars <- mtcars[mtcars$cyl <= 4, ]
bigcars <- mtcars[mtcars$cyl > 4, ]

plot(smallcars$mpg ~ smallcars$wt,
     pch = 20, col = "slateblue",
     xlim = c(1, 7), ylim = c(5, 40),
     xlab = ("Weight (1000s of lbs)"), ylab = "Miles per gallon"
)
abline(lm(mpg ~ wt, data = smallcars), col = "slateblue")
points(bigcars$mpg ~ bigcars$wt, pch = 20, col = "firebrick")
abline(lm(mpg ~ wt, data = bigcars), col = "firebrick")

# Legends can be added with legend(),
# where the first 2 arguments determine the position of the legend
legend(4, 40,
     fill = c("slateblue", "firebrick"),
     legend = c("Small cars (4 cylinders)", "Big cars (5+ cylinders)"),
     bty = "n", cex = 0.8
)
=======
plot(x,y,type="l", xlim=c(-4,4))
abline(v=0)

plot(mtcars$wt,mtcars$mpg, pch=20, ylim = c(0,40), xlim = c(0,7))
     abline(v=0,h=0,lm(mpg~wt,data=mtcars))

# Layers of different points or lines can be added to a plot using points() and lines()
smallcars <- mtcars[mtcars$cyl<=4,]
bigcars <- mtcars[mtcars$cyl>4,]

plot(smallcars$mpg~smallcars$wt, pch=20, col = "slateblue", 
          xlim=c(1,7), ylim = c(5,40),
          xlab=("Weight (1000s of lbs)"),ylab="Miles per gallon")
abline(lm(mpg~wt,data=smallcars), col="slateblue")
points(bigcars$mpg~bigcars$wt, pch=20, col = "firebrick")
abline(lm(mpg~wt,data=bigcars), col="firebrick")

# Legends can be added with legend(), 
# where the first 2 arguments determine the position of the legend
legend(4,40, fill=c("slateblue","firebrick"), 
            legend= c("Small cars (4 cylinders)", "Big cars (5+ cylinders)"),
          bty = "n", cex = 0.8)
>>>>>>> 9561721 (created lab 4)

#######################
####    Devices    ####
#######################

# When you create a plot, it gets stored to a graph device. This gets opened automatically when you plot, and in Rstudio is displayed on one of the panes.
# You can also open a graphics device manually using quartz() on Mac and Linux and windows() on Windows

# The par() function sets the graphical parameters for the device.
# You can use it to set the margins of the graph (in inches) using mar
<<<<<<< HEAD
par(mar = c(5, 5, 5, 5))
plot(mtcars$wt, mtcars$mpg)
=======
par(mar=c(5,5,5,5))
plot(mtcars$wt,mtcars$mpg)
>>>>>>> 9561721 (created lab 4)

# These parameters will remain attached to the graphical device until you turn them off, with:
dev.off()

# par() can be used to generate multiple plots in the same device with the argument mfrow
# mfrow takes a vector of 2 numbers, first the number of rows then the number of columns of the plot grid

<<<<<<< HEAD
par(mfrow = c(2, 2), mar = c(2, 2, 1, 1))
plot(mtcars$wt, mtcars$mpg, pch = "%", col = "dodgerblue")
plot(mtcars$wt, mtcars$mpg, pch = "e", col = "#13fee0")
plot(mtcars$wt, mtcars$mpg, pch = "^", col = "firebrick")
plot(mtcars$wt, mtcars$mpg, pch = "4", col = adjustcolor("black", alpha.f = 0.4))
=======
par(mfrow=c(2,2),mar=c(2,2,1,1))
plot(mtcars$wt,mtcars$mpg, pch='%', col='dodgerblue')
plot(mtcars$wt,mtcars$mpg, pch='e', col='#13fee0')
plot(mtcars$wt,mtcars$mpg, pch='^', col='firebrick')
plot(mtcars$wt,mtcars$mpg, pch='4', col=adjustcolor('black',alpha.f=0.4))
>>>>>>> 9561721 (created lab 4)
dev.off()

#############################
####    Saving graphs    ####
#############################
<<<<<<< HEAD

=======
 
>>>>>>> 9561721 (created lab 4)
# You can save graphs directly from your device (in RStudio, you would click on the 'export' button)
# However, this can be annoying if you have to go through the process every time you make a small adjustment to your graph
# Also, there is no guarantee of conistency if you save your graphs manually
# Generally, it is better to save your plots using code
# To do this, you must open a graphical device directly in a file
# There are multiple functions for this, see a list here: https://stat.ethz.ch/R-manual/R-devel/library/grDevices/html/Devices.html

# Example: to save a graph as a .png
# First open your png device, provide the dimensions, and name the file:
<<<<<<< HEAD
png(
     file = "my.example.graph.png",
     width = 600, height = 450
)

# then put all of the code for your graph
plot(mtcars$wt, mtcars$mpg)
=======
png(file="my.example.graph.png",
    width=600, height=450)

# then put all of the code for your graph
plot(mtcars$wt,mtcars$mpg)
>>>>>>> 9561721 (created lab 4)

# When you are done, close the device with
dev.off()




#########################
####    EXERCISES    ####
#########################

# 1.1 Transform the 'wt' variable in the mtcars dataset, which represents the weight of cars in 1000s of lbs,
# to a variable representing that weight in kg. 1 lb = 0.453592kg
<<<<<<< HEAD
<<<<<<< HEAD
mtcars$wt
mtcars$wtkg <- mtcars$wt * 1000 * 0.453592
mtcars$wtkg
# 1.2 Plot a histogram and a density plot of the weights of cars in kg in the mtcars dataset.
hist(mtcars$wtkg, breaks = 10, main = "Car Weights", xlab = "Weight (kg)", col = "lightblue")
plot(density(mtcars$wtkg), col = "darkred", main = "Density of Car Weights")

# Let's extract data about survival rates among the Titanic
data(Titanic)
Titanic
survived <- as.data.frame(Titanic[, , 2, 2])
died <- as.data.frame(Titanic[, , 2, 1])

# Now we create a new data frame from survived and died that contains the proportion of survivors for each combination of sex and class

d <- data.frame(
     Male = (survived$Freq / (survived$Freq + died$Freq))[1:4],
     Female = (survived$Freq / (survived$Freq + died$Freq))[5:8],
     class = c("1st", "2nd", "3rd", "Crew")
)

# Finally we format it for the barplot function.
# Each row must be a sex and each column a class, with row names and column names specified
barplot_d <- as.matrix(t(d[1:2]))
colnames(barplot_d) <- d$class
?barplot

# From this dataset, create a clustered barchart
barplot(barplot_d, beside = T, ylim = c(0, 1))
sum(2, 2)
# 1.3. Fix this barplot so that the colours are nicer and there is a legend, title, and appropriate axes labels.
barplot(barplot_d,
     beside = TRUE, ylim = c(0, 1), col = c("skyblue", "pink"),
     main = "Survival Rates by Class and Gender",
     xlab = "Class", ylab = "Proportion Survived"
)
legend("topright", legend = c("Male", "Female"), fill = c("skyblue", "pink"))
=======

=======
mtcars$wtkg=mtcars$wt * 0.453592
mtcars$wtkg
>>>>>>> 9d67e98 (lab 4 start)
# 1.2 Plot a histogram and a density plot of the weights of cars in kg in the mtcars dataset.
hist(mtcars$wtkg)
plot(density(mtcars$wtkg))
# Let's extract data about survival rates among the Titanic
data(Titanic)
survived <- as.data.frame(Titanic[,,2,2])
died <-  as.data.frame(Titanic[,,2,1])

# Now we create a new data frame from survived and died that contains the proportion of survivors for each combination of sex and class

d <- data.frame(Male = (survived$Freq/(survived$Freq+died$Freq))[1:4],
                Female = (survived$Freq/(survived$Freq+died$Freq))[5:8],
                class = c("1st","2nd","3rd","Crew"))

# Finally we format it for the barplot function.
# Each row must be a sex and each column a class, with row names and column names specified
 barplot_d <- as.matrix(t(d[1:2]))
colnames(barplot_d)<- d$class

# From this dataset, create a clustered barchart
barplot (barplot_d, beside=T, ylim=c(0,1))

# 1.3. Fix this barplot so that the colours are nicer and there is a legend, title, and appropriate axes labels.
>>>>>>> 9561721 (created lab 4)

# 1.4. Looking at this barplot, what can you say about who was more likely to survive the Titanic?
#      Which group was the least likely to survive?

<<<<<<< HEAD

# 1.5 Load the Iris dataset
=======
# 1.5 Load the Iris dataset 
>>>>>>> 9561721 (created lab 4)
data(Iris)

# Please attempt to replicate the graph from the slides. It is a scatterplot of petal length against sepal length,
# with species differentiated by color.
# Add ablines plotting the linear relationship between petal length and sepal length for each group.

<<<<<<< HEAD
data(iris)
plot(iris$Petal.Length ~ iris$Sepal.Length,
     col = iris$Species, pch = 19,
     main = "Petal vs Sepal Length by Species",
     xlab = "Sepal Length", ylab = "Petal Length"
)
abline(lm(Petal.Length ~ Sepal.Length, data = iris, subset = Species == "setosa"), col = "red")
abline(lm(Petal.Length ~ Sepal.Length, data = iris, subset = Species == "versicolor"), col = "blue")
abline(lm(Petal.Length ~ Sepal.Length, data = iris, subset = Species == "virginica"), col = "green")
=======



>>>>>>> 9561721 (created lab 4)
