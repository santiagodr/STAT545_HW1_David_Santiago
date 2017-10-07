Homework 4: Tidy data and joins
================
Santiago David
2017-10-06

### Load data and packages

``` r
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(gapminder))
```

Data reshaping
--------------

### Activity \#2

**Objective**: Make a tibble with one row per year and columns for life expectancy for two or more countries, and use that to make a plot.

**Process**: Colombia and Venezuela were the same country many years ago, I'm curious how life expectancy have changed in their recent past (as separate countries), so I will analyze them. First, I filter gapminder by those two countries and all years. Then, I select the variables `country`,`year`, and `lifeExp`, and use `spread` to convert that table into its wide format, and save as a new object.

``` r
colven <- gapminder %>% 
  filter(country %in% c("Colombia", "Venezuela")) %>% 
  select(country, year, lifeExp) %>% 
  spread(country, lifeExp)
knitr::kable(colven, col.names = c("Year", "Life expectancy in Colombia", "Life expectancy in Venezuela"))
```

|  Year|  Life expectancy in Colombia|  Life expectancy in Venezuela|
|-----:|----------------------------:|-----------------------------:|
|  1952|                       50.643|                        55.088|
|  1957|                       55.118|                        57.907|
|  1962|                       57.863|                        60.770|
|  1967|                       59.963|                        63.479|
|  1972|                       61.623|                        65.712|
|  1977|                       63.837|                        67.456|
|  1982|                       66.653|                        68.557|
|  1987|                       67.768|                        70.190|
|  1992|                       68.421|                        71.150|
|  1997|                       70.313|                        72.146|
|  2002|                       71.682|                        72.766|
|  2007|                       72.889|                        73.747|

**Figure**: We can use this new data shape to look at the comparison of life expectancy of Colombia vs Venezuela. I will include a `geom_abline` with slope=1 and intercept=0, so we can see how different is this comparison to a perfect 1 to 1 relationship in life expectancy for both countries over the years.

``` r
colven %>% 
  ggplot(aes(x = Colombia, y = Venezuela)) +
  geom_point() +
  geom_label(aes(x = Colombia, y = Venezuela, label = year, vjust = -0.5)) + #add years to points
  ylim(50, 75) + xlim(50, 75) +
  geom_abline(slope = 1, intercept = 0, colour = "4", linetype="longdash") + #add line
  ggtitle("Comparison of Life Expectancy between Venezuela and Colombia") +
  theme_bw()
```

![](tidy_data_joins_hw04_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

**Observations**: From this plot and table we can see that both countries have increased the life expectancy over the years, but Venezuela has always had a life expectancy higher than Colombia (above blue line), specially in the 50's-60's. Both countries have more similar life expectancy in recent years.

**Additional resources**: I got help from the ggplot2 reference webpage for adding [text and labels to a plot](http://ggplot2.tidyverse.org/reference/geom_text.html).

But I want to do more!
----------------------

``` r
life_exp_mean <- 
  gapminder %>% 
  group_by(continent, year) %>% 
  summarise(life_mean = mean(lifeExp)) %>% 
  spread(continent, life_mean)
knitr::kable(life_exp_mean, caption = "Life expectancy")
```

|  year|    Africa|  Americas|      Asia|    Europe|  Oceania|
|-----:|---------:|---------:|---------:|---------:|--------:|
|  1952|  39.13550|  53.27984|  46.31439|  64.40850|  69.2550|
|  1957|  41.26635|  55.96028|  49.31854|  66.70307|  70.2950|
|  1962|  43.31944|  58.39876|  51.56322|  68.53923|  71.0850|
|  1967|  45.33454|  60.41092|  54.66364|  69.73760|  71.3100|
|  1972|  47.45094|  62.39492|  57.31927|  70.77503|  71.9100|
|  1977|  49.58042|  64.39156|  59.61056|  71.93777|  72.8550|
|  1982|  51.59287|  66.22884|  62.61794|  72.80640|  74.2900|
|  1987|  53.34479|  68.09072|  64.85118|  73.64217|  75.3200|
|  1992|  53.62958|  69.56836|  66.53721|  74.44010|  76.9450|
|  1997|  53.59827|  71.15048|  68.02052|  75.50517|  78.1900|
|  2002|  53.32523|  72.42204|  69.23388|  76.70060|  79.7400|
|  2007|  54.80604|  73.60812|  70.72848|  77.64860|  80.7195|
