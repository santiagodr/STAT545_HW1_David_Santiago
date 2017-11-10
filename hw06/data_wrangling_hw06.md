Data Wrangling wrap up
================
Santiago David
2017-11-07

#### Load data and packages

``` r
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(gapminder))
suppressPackageStartupMessages(library(forcats))
suppressPackageStartupMessages(library(purrr))
suppressPackageStartupMessages(library(stringr))
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

The ideal function, will be one that takes a variable `life expectancty` and `year` as input, fit a model, and return the coefficients `intercept`, and `slope` and potentially the R-squared or Residual st error...

We should start by fitting the models, and check how they behave by extracting the coefficients:

``` r
# three models
linear_mod <- lm(lifeExp ~ I(year - 1952), gapminder)
quadra_mod <- lm(lifeExp ~ I(year - 1952) + I((year - 1952)^2), gapminder)
robust_mod <- robustbase::lmrob(lifeExp ~ I(year - 1952), gapminder)
```

We have to use `I(year - 1952)` instead of just `year` to fix the intercept to life expectancy on year 1952 (following Jenny Bryan's [post](http://stat545.com/block012_function-regress-lifeexp-on-year.html))

Now, let's see the parameters

``` r
#coefficients
coef(linear_mod)
```

    ##    (Intercept) I(year - 1952) 
    ##     50.5120841      0.3259038

``` r
coef(quadra_mod)
```

    ##        (Intercept)     I(year - 1952) I((year - 1952)^2) 
    ##       48.916137600        0.517417408       -0.003482065

``` r
coef(robust_mod)
```

    ##    (Intercept) I(year - 1952) 
    ##     50.1219139      0.3500189

And the R-squared to get a sense of how close the data are to the fitted regression line

``` r
#adjusted r squared
summary(linear_mod)$adj.r.squared
```

    ## [1] 0.1892811

``` r
summary(quadra_mod)$adj.r.squared
```

    ## [1] 0.1938648

``` r
summary(robust_mod)$adj.r.squared
```

    ## [1] 0.1946681

``` r
summary(robust_mod)
```

    ## 
    ## Call:
    ## robustbase::lmrob(formula = lifeExp ~ I(year - 1952), data = gapminder)
    ##  \--> method = "MM"
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -40.524  -9.830   1.246   9.943  22.548 
    ## 
    ## Coefficients:
    ##                Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)    50.12191    0.63074   79.47   <2e-16 ***
    ## I(year - 1952)  0.35002    0.01962   17.84   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Robust residual standard error: 12.55 
    ## Multiple R-squared:  0.1951, Adjusted R-squared:  0.1947 
    ## Convergence in 10 IRWLS iterations
    ## 
    ## Robustness weights: 
    ##  72 weights are ~= 1. The remaining 1632 ones are summarized as
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##  0.2754  0.8868  0.9407  0.9216  0.9794  0.9990 
    ## Algorithmic parameters: 
    ##        tuning.chi                bb        tuning.psi        refine.tol 
    ##         1.548e+00         5.000e-01         4.685e+00         1.000e-07 
    ##           rel.tol         solve.tol       eps.outlier             eps.x 
    ##         1.000e-07         1.000e-07         5.869e-05         1.000e-10 
    ## warn.limit.reject warn.limit.meanrw 
    ##         5.000e-01         5.000e-01 
    ##      nResample         max.it       best.r.s       k.fast.s          k.max 
    ##            500             50              2              1            200 
    ##    maxit.scale      trace.lev            mts     compute.rd fast.s.large.n 
    ##            200              0           1000              0           2000 
    ##                   psi           subsampling                   cov 
    ##            "bisquare"         "nonsingular"         ".vcov.avar1" 
    ## compute.outlier.stats 
    ##                  "SM" 
    ## seed : int(0)
