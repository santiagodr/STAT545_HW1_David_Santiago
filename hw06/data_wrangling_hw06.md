Data Wrangling wrap up
================
Santiago David
2017-11-07

#### Load data and packages

``` r
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(gapminder))
suppressPackageStartupMessages(library(purrr))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(broom))
data("gapminder")
```

Writing functions
=================

#### **Objective**:

Write one (or more) functions that do something useful to pieces of the Gapminder or Singer data. Make it something that’s not trivial to do with the simple dplyr verbs.

**Process**: The homework provide a good starting point with the gapminder data following Jenny's [tutorial](http://stat545.com/block012_function-regress-lifeexp-on-year.html) to create a linear regression of life expectancy on year. However, First things first, let's plot the data!

``` r
ggplot(gapminder, aes(year, lifeExp, colour = continent)) +
  geom_point() +
  facet_wrap(~ continent) +
  labs(title = "Life expectancy for each continent 1952-2007", x = "Years", y = "Life Expectancy (years)") +
  guides(colour = FALSE) +
  theme_classic() 
```

![](data_wrangling_hw06_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

From these graphs, we can see that there is an increasing trend of life expectancy over years, However, a priori, we dont really know if the relationship is different for each country/continent, if the relationship between Life expectancy and year is linear, cuadratic, or whether a robust regression is more apropiate given the possibility that some values are outliers or influential observations. For example, what about that steep line of points in Europe?, or that odd red dot in Africa in the 90's?. For this reason, it is worth to create functions for different models that we can fit either to each continent, or country (or other similar data).

The ideal function, will be one that takes a variable `life expectancty` and `year` as input, fit a model, and return the coefficients `intercept`, and `slope` and potentially the `R-squared` as a way to understand how well the model fit the data...

**Create some code**

We should start by fitting the models, and check how they behave by extracting the coefficients:

``` r
# three models
linear1 <- lm(lifeExp ~ I(year - 1952), gapminder)
quadra1 <- lm(lifeExp ~ I(year - 1952) + I((year - 1952)^2), gapminder)
robust1 <- robustbase::lmrob(lifeExp ~ I(year - 1952), gapminder)
```

We have to use `I(year - 1952)` instead of just `year` to fix the intercept to life expectancy on year 1952 (following Jenny Bryan's [post](http://stat545.com/block012_function-regress-lifeexp-on-year.html))

Now, let's see the parameters

``` r
#coefficients
coef(linear1)
```

    ##    (Intercept) I(year - 1952) 
    ##     50.5120841      0.3259038

``` r
coef(quadra1)
```

    ##        (Intercept)     I(year - 1952) I((year - 1952)^2) 
    ##       48.916137600        0.517417408       -0.003482065

``` r
coef(robust1)
```

    ##    (Intercept) I(year - 1952) 
    ##     50.1219139      0.3500189

And the adjusted R-squared to get a sense of how close the data are to the fitted regression line

``` r
#adjusted r squared
summary(linear1)$adj.r.squared
```

    ## [1] 0.1892811

``` r
summary(quadra1)$adj.r.squared
```

    ## [1] 0.1938648

``` r
summary(robust1)$adj.r.squared
```

    ## [1] 0.1946681

Now, we see that the robust and quadratic models perform a bit better than the simple linear model. But remember this is for the `whole` data. Now, we want to create a function with that code that we can apply to subsets of the data.

**Turn code into a function**

I can fit a function for each model separately... starting with the simple linear regression

``` r
linear_mod <- function(dat, offset = 1952) {
  model <- lm(lifeExp ~ I(year - offset), dat)
  intercept <- coef(model)[1]
  slope <- coef(model)[2]
  adjusted_Rsquared <- summary(model)$adj.r.squared
  data.frame(intercept, slope, adjusted_Rsquared) %>% 
  setNames(c("Intercept", "Slope", "R-squared"))
}
```

Note, that here, we created an `offset` to specify an argument in the function, and defined specific objects for each parameter we are interested in, by extracting the first `[1]` and second `[2]` elements of the `coef` object and the `adj.r.squared` element of the summary object. We then create a data.frame with those value...

Lets apply this function to the whole gapminder dataset.

``` r
linear_mod(gapminder)
```

    ##             Intercept     Slope R-squared
    ## (Intercept)  50.51208 0.3259038 0.1892811

We can see that these values correspond to the values above (model = linear1), obtained by fitting a simple regression to Life expectancy and year to gapminder. So that's good, the function is doing what we think it is doing...

**Now** We can fix a separate function for the quadractic and robust regression models, or **even better**... Try to create a function that fit all three models at once, extract the three parameters of interest `intercept`, `slope`, and `R-squared` from each model and output a single table with those values...

``` r
fit_all_models <- function(dat, offset = 1952) {
  # three models
  linear <- lm(lifeExp ~ I(year - offset), dat)
  quadra <- lm(lifeExp ~ I(year - offset) + I((year - offset)^2), dat)
  robust <- robustbase::lmrob(lifeExp ~ I(year - offset), dat)
  # parameters
  model <- c("Linear", "Quadratic", "Robust")
  intercept <- c(coef(linear)[1], coef(quadra)[1], coef(robust)[1])
  slope <- c(coef(linear)[2], coef(quadra)[2], coef(robust)[2])
  Adjusted_Rsquared <- c(summary(linear)$adj.r.squared, summary(quadra)$adj.r.squared, 
                         summary(robust)$adj.r.squared)
  # what we want for the output
  data.frame(model, intercept, slope, Adjusted_Rsquared) %>% 
  setNames(c("Model", "Intercept", "Slope", "R-squared"))
}
```

Okay, let's see if it works for the whole gapminder... we should obtain exactly the same values we obtained in the first place, by fitting the three models to gapminder and extracting the values independently.

``` r
fit_all_models(gapminder)
```

    ##       Model Intercept     Slope R-squared
    ## 1    Linear  50.51208 0.3259038 0.1892811
    ## 2 Quadratic  48.91614 0.5174174 0.1938648
    ## 3    Robust  50.12191 0.3500189 0.1946681

**Observations**: This function allows us to test three models at once to a set of data with a `Life expectancy` and `year` variables, extract the parameters of interest from each model and compared them easily in a single output table; So, now we can use this function to fit the models for each continent or country...

{r} gapminder %&gt;% group\_by(continent) %&gt;% do(fit\_all\_models(.))

Another option using Broom... Explore later

{r} tidy(linear\_mod) tidy(quadra\_mod) glance(quadra\_mod) tidy(robust\_mod)

Another option for robust regression {r} library(robust) robust &lt;- robust::lmRob(lifeExp ~ I(year - 1952), gapminder)
