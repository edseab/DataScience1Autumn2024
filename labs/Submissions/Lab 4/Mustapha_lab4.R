###################################
###################################
########                   ########
########   Data Science 1  ########
########       Lab 4       ######## 
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
# To change the reference category, you can use 
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

# For colors you can use preloaded R colors, which you can look up here:
# https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf

# You can also use hex codes, such as:
plot(dnorm(seq(-4,4,0.2)),type='o', col='#6D1ACF')

# Pick your own color and find its hex code here:
# https://htmlcolorcodes.com/color-picker/
# or use the built-in color picker in Positron/VSCode

# For turning frequencies into histograms or density plots,
# use hist() and density() 

# For barplots and boxplots, we use barplot() and boxplot()
# In barplot, we can use the argument beside = T or beside = F to make a clustered or a stacked bar chart


# Axes can be removed from the original plot using xaxt='n' and yaxt = 'n'
# New axes can be added using the axis() function
# text(), segments(), arrows(), polygon(), legend(), add these respective elements to your plot. 
# Experiment with them or run ?text, ?segments, etc. to find out more.

# Fonts can be changed using the arguments cex (for size), family (for font type), and font (for bold or italics)

# Straight lines can be added to plots using abline()
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
legend(4,30, fill=c("slateblue","firebrick"), 
            legend= c("Small cars (4 cylinders)", "Big cars (5+ cylinders)"),
          bty = "n", cex = 0.8)

#######################
####    Devices    ####
#######################

# When you create a plot, it gets stored to a graph device. This gets opened automatically when you plot, and in Rstudio is displayed on one of the panes.
# You can also open a graphics device manually using quartz() on Mac and Linux and windows() on Windows

# The par() function sets the graphical parameters for the device.
# You can use it to set the margins of the graph (in inches) using mar
par(mar=c(5,5,5,5))
plot(mtcars$wt,mtcars$mpg)

# These parameters will remain attached to the graphical device until you turn them off, with:
dev.off()

# par() can be used to generate multiple plots in the same device with the argument mfrow
# mfrow takes a vector of 2 numbers, first the number of rows then the number of columns of the plot grid

par(mfrow=c(2,2),mar=c(2,2,1,1))
plot(mtcars$wt,mtcars$mpg, pch='%', col='dodgerblue')
plot(mtcars$wt,mtcars$mpg, pch='e', col='#13fee0')
plot(mtcars$wt,mtcars$mpg, pch='^', col='firebrick')
plot(mtcars$wt,mtcars$mpg, pch='4', col=adjustcolor('black',alpha.f=0.4))
dev.off()

#############################
####    Saving graphs    ####
#############################
 
# You can save graphs directly from your device (in RStudio, you would click on the 'export' button)
# However, this can be annoying if you have to go through the process every time you make a small adjustment to your graph
# Also, there is no guarantee of conistency if you save your graphs manually
# Generally, it is better to save your plots using code
# To do this, you must open a graphical device directly in a file
# There are multiple functions for this, see a list here: https://stat.ethz.ch/R-manual/R-devel/library/grDevices/html/Devices.html

# Example: to save a graph as a .png
# First open your png device, provide the dimensions, and name the file:
png(file="my.example.graph.png",
    width=600, height=450)

# then put all of the code for your graph
plot(mtcars$wt,mtcars$mpg)

# When you are done, close the device with
dev.off()




#########################
####    EXERCISES    ####
#########################

# 1.1 Transform the 'wt' variable in the mtcars dataset, which represents the weight of cars in 1000s of lbs,
# to a variable representing that weight in kg. 1 lb = 0.453592kg
wt_kg <- mtcars$wt * 0.453592

# 1.2 Plot a histogram and a density plot of the weights of cars in kg in the mtcars dataset.

# Histogram
hist(wt_kg, main = "Histogram of Weights of Cars in kilograms", xlab = "weights in kg", breaks = 5)

# Density Plot
plot(density(wt_kg), main = "Density Plot of Car Weights in kg",
          xlab = "weights in kg", col = "red", lwd = 2)

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
barplot(barplot_d, beside=T, ylim=c(0,1))

# 1.3. Fix this barplot so that the colours are nicer and there is a legend, title, and appropriate axes labels.
barplot(barplot_d, beside=T, ylim=c(0,1), col = c('red','yellow'),
          xlab = 'gender class', ylab = 'proportion of survivors',
        main = 'Survival Rate of Male and Female of the Titanic')
legend('topright', legend = c("Male","Female"), bty = "n",
        fill = c('red','yellow'))

# 1.4. Looking at this barplot, what can you say about who was more likely to survive the Titanic?
#      Which group was the least likely to survive?
# Answer:
# 1. Females were consistently more likely to survive than males across 
# all   classes and crew: Hence, 1st class females had the highest survival 
# rate of  nearly 100%.
# 2. The group that was least likely to survive was 2nd class males, with 
# less than 10% survival rate.

# 1.5 Load the Iris dataset 
data(iris)

# Please attempt to replicate the graph from the slides. It is a scatterplot of petal length against sepal length,
# with species differentiated by color.
# Add ablines plotting the linear relationship between petal length and sepal length for each group.

petal_length <- iris$Petal.Length
sepal_length <- iris$Sepal.Length

# Set up colors for the three species
colors <- c("green", "yellow", "orange")
species_colors <- colors[as.numeric(iris$Species)]

plot(petal_length,sepal_length, xlab = 'Petal length (cm)',
        ylab = 'Sepal length (cm)', main = 'Relationship between petal and sepal length in irises', pch = 18, col = species_colors)

legend("topleft", legend = c('Versicolor', 'Setosa', 'Virginica'),
         title = "Species", fill = c("yellow", "green", "orange"),
         cex = 0.7, inset = 0.05, x.intersp = 0.5, y.intersp = 0.6,
         text.width = 1.2)

# Add simple linear regression lines for each species
setosa_data <- iris[iris$Species=='setosa',]
abline(lm(Sepal.Length ~ Petal.Length, data = setosa_data), col = 'green')

versicolor_data <- iris[iris$Species=='versicolor',]
abline(lm(Sepal.Length ~ Petal.Length, data = versicolor_data), col = 'yellow')

virginica_data <- iris[iris$Species=='virginica',]
abline(lm(Sepal.Length ~ Petal.Length, data = virginica_data), col = 'orange')

# Alternative approach
abline(lm(Sepal.Length ~ Petal.Length, data = iris, subset = Species == "setosa"), col = "green", lwd = 2)
abline(lm(Sepal.Length ~ Petal.Length, data = iris, subset = Species == "versicolor"), col = "yellow", lwd = 2)
abline(lm(Sepal.Length ~ Petal.Length, data = iris, subset = Species == "virginica"), col = "orange", lwd = 2)