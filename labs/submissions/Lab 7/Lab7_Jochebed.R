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

# The pipe operator |> lets you pass the result of one function into another function in a simpler way.

# Example

hist(rnorm(200), breaks = seq(-4, 4, 0.5))
# is the same as:

rnorm(200) |> hist(breaks = seq(-4, 4, 0.5))

# Pipes help make code cleaner when chaining many functions together:

### 1.1 Rewrite this using pipes:
set.seed(123)
round(sqrt(log(runif(10, 1, 10))), 2)

# With pipes:
runif(10, 1, 10) |>
    log() |>
    sqrt() |>
    round(2)

# Pipes were first introduced in a package called magrittr, which is part of tidyverse.


########################
####    Packages    ####
########################

# Packages are like toolkits with extra functions or data. They need to be installed and then loaded.

# Installing tidyverse (a collection of related packages):
install.packages("tidyverse")

# Loading it into your R session:
library(tidyverse)

# Install only once, but load it every time you start a new R session.

#########################
####    TIDYVERSE    ####
#########################

# Tidyverse has many useful packages but isn’t mandatory. It’s more about preference.

# Example using magrittr pipes:
set.seed(123)
runif(10, 1, 10) %>%
    log() %>%
    sqrt() %>%
    round(2)

# We’ll focus on two tidyverse packages: dplyr (data manipulation) and ggplot2 (visualization).

#####################
####    dplyr    ####
#####################

# dplyr makes data transformations easier. It replaces indexing with functions like select and filter.

data(mtcars)

# Instead of:
mtcars[mtcars$cyl == 6, 1:5]

# Use dplyr:
mtcars %>%
    filter(cyl == 6) %>%
    select(1:5)

### 2.1
# Make a new data frame of cars over 4000 lbs, keeping only wt and mpg. Call it df.

mtcars %>%
    filter(wt >= 4) %>%
    select(wt, mpg) -> df

# Sorting rows with arrange:
df %>% arrange(wt)
df %>% arrange(desc(wt))

# Add new columns with mutate:
df <- df %>% mutate(
    wt_kg = wt * 453.592,
    km_per_l = mpg * 1.60934 / 3.78541
)

# Using ifelse inside mutate:
mtcars <- mtcars %>%
    mutate(wt_class = ifelse(wt >= 4, "Oversized", "Standard"))

# For multiple conditions, use case_when:
mtcars <- mtcars %>%
    mutate(
        efficiency = case_when(
            mpg <= 15 ~ "low",
            mpg > 15 & mpg <= 20 ~ "medium",
            mpg > 20 ~ "high"
        )
    )

# Summarize data:
mtcars %>%
    summarise(
        mean_wt = mean(wt),
        sd_wt = sd(wt),
        n = length(mpg)
    )

# Summarize by groups with group_by:
mtcars %>%
    group_by(efficiency) %>%
    summarise(
        wt_kg = mean(wt),
        n = length(hp)
    ) %>%
    arrange(c("high", "medium", "low"))

# Group by multiple variables:
mtcars %>%
    group_by(efficiency, cyl) %>%
    summarise(
        wt_kg = mean(wt),
        n = length(hp)
    )

# Always ungroup after grouping:
mtcars %>% ungroup()

### 3.1
# Using dplyr with the iris dataset:

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
        n = length(Sepal.Length)
    ) %>%
    arrange(desc(mean_Petal.Length)) -> iris

#######################################################
####    Code your own lm and predict functions!    ####
#######################################################

### 4.1 lm()

# Let’s build an lm function step by step:

my.lm <- function(y, x) {
    # Sample size
    n <- length(y)

    # Create X matrix (add column of 1s):
    x <- as.matrix(cbind(1, x))

    # Coefficients:
    b <- solve(t(x) %% x) %% t(x) %*% y

    # Predictions:
    y_hat <- x %*% b

    # Residuals:
    e <- y - y_hat

    # Residual standard error:
    s <- sqrt(sum(e^2) / (n - ncol(x)))

    # Variance-covariance matrix of coefficients:
    vcov_coef <- s^2 * solve(t(x) %*% x)

    # Standard errors of coefficients:
    se_coef <- sqrt(diag(vcov_coef))

    # t-values:
    t_vals <- b / se_coef

    # p-values:
    p <- 2 * (1 - pt(abs(t_vals), df = n - ncol(x)))

    # R-squared and adjusted R-squared:
    RSS <- sum(e^2)
    TSS <- sum((y - mean(y))^2)
    r2 <- 1 - RSS / TSS
    adj_r2 <- 1 - (RSS / (n - ncol(x))) / (TSS / (n - 1))

    # F-statistic and model p-value:
    f_stat <- (TSS - RSS) / (ncol(x) - 1) / (RSS / (n - ncol(x)))
    model_p <- pf(f_stat, ncol(x) - 1, n - ncol(x), lower.tail = F)

    # Return as a list:
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

# Example:
my.lm(y = mtcars$mpg, x = mtcars[, c("wt", "cyl")])

### 4.2 predict()

my.predict <- function(model_output, new_data, ci_level = 0.97) {
    # Coefficients from model output:
    coef <- model_output$coefficients

    # Add column of 1s to new_data:
    new_data <- cbind(1, new_data)

    # Predicted values:
    y_hat <- new_data %*% coef

    # Critical t-value:
    area_in_tails <- (1 - ci_level) / 2
    t_critical <- qt(1 - area_in_tails, df = model_output$n - nrow(coef))

    # Prediction standard error:
    pred_se <- sqrt(rowSums((new_data %*% model_output$vcov) * new_data))

    # Confidence intervals:
    lower_bound <- y_hat - t_critical * pred_se
    upper_bound <- y_hat + t_critical * pred_se

    # Return predictions and CIs:
    return(data.frame(
        Prediction = y_hat,
        Lower_CI = lower_bound,
        Upper_CI = upper_bound
    ))
}

# Example usage:
model_output <- my.lm(y = mtcars$mpg, x = mtcars[, c("wt", "cyl")])
new_data <- data.frame(wt = c(3, 4), cyl = c(6, 8))
my.predict(model_output, new_data, ci_level = 0.95)