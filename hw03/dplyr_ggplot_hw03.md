Use dplyr to manipulate and explore data
================
Santiago D
2017-10-02

### Load data and packages

``` r
library("gapminder")
library("tidyverse")
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

### Tasks selected

-   Maximum and minimum GDP per capita for all continents
-   Life expectancy change over time on different continents

Task \#1
--------

**Objective**: Get the maximum and minimum of GDP per capita for all continents.

**Process**: Use `group_by` and `summarise` to obtain the min and max of the variable, save that as a new object and use that object to create a table using `knitr::kable` and plot using `ggplot2`.

**Additional Resources**: I got some ideas for the graph from [this](https://stackoverflow.com/questions/27205629/plot-ranges-of-variable-in-data) stackoverflow post

``` r
gdpsummary <- gapminder %>% 
  group_by(continent) %>% 
  summarise(min_gdpPercap = min(gdpPercap),
            max_gdpPercap = max(gdpPercap),
            mean_gdpPercap = mean(gdpPercap))
```

Table

``` r
knitr::kable(gdpsummary, col.names = c("Continent", "Minimum GDP per capita", 
                                       "Maximum GDP per capita", "Mean GDP per capita"))
```

| Continent |  Minimum GDP per capita|  Maximum GDP per capita|  Mean GDP per capita|
|:----------|-----------------------:|-----------------------:|--------------------:|
| Africa    |                241.1659|                21951.21|             2193.755|
| Americas  |               1201.6372|                42951.65|             7136.110|
| Asia      |                331.0000|               113523.13|             7902.150|
| Europe    |                973.5332|                49357.19|            14469.476|
| Oceania   |              10039.5956|                34435.37|            18621.609|

Figure

``` r
ggplot(gdpsummary, aes(x = continent)) +
  geom_point(aes(y = min_gdpPercap), size = 3, color = "skyblue4") +
  geom_point(aes(y = max_gdpPercap), size = 3, color = "skyblue4") +
  geom_linerange(aes(ymin = min_gdpPercap,ymax = max_gdpPercap),linetype = 2,color = "blue") +
  labs(title = "GDP per capita for each continent", x = "Continent", y = "GDP per capita") +
  ylim(0,120000) +
  theme_classic()
```

![](dplyr_ggplot_hw03_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

Optional Figure

Another option would be to use a boxplot of GDP per capita per continent, which would display a better distribution of the values, including the minimum and maximum.

``` r
gapminder %>% 
  group_by(continent) %>% 
  ggplot(aes(x = continent, y = gdpPercap, fill = continent)) +
  geom_boxplot() +
  labs(title = "GDP per capita for each continent", x = "Continent", y = "GDP per capita") +
  ylim(0, 120000) +
  guides(fill = FALSE) +
  theme_classic()
```

![](dplyr_ggplot_hw03_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-1.png)

**Observations**: We can see from both the table and the figure(s) that Asia has the greatest range in GDP per capita, and Oceania and Africa have small ranges compared to the other continents, but Oceania with very high minimum and maximum values for GDP per capita compared to Africa. The boxplot is particularly useful in showing the distribution of values, and that the maximum GDP per capita for every continent are actually very extreme compared to the rest of the data.

Task \#2
--------

**Objective**: Look at the spread of GDP per capita within the continents

**Process**: Use `group_by` and `mutate` to create a new variable that capture the change in ife expectancy over years, but in this case by calculating the difference between life expectancy in a given year with the first year with data for each country. I saved that as a new object.

To display the change over time per continent in a table, I decided to summarize the *average* change in life expectancy per year and used `knitr::kable`. However for the graph, it is more informative to keep all values for each country, but including a linear regression per continent to see the trend in change of life expectancy, also using `ggplot2`.

**Additional Resources**: I used the function `spread` to display an optional table following [this](http://tidyr.tidyverse.org/reference/spread.html) link

``` r
gapminder %>% 
  group_by(continent) %>% 
  summarise("25%" = quantile(gdpPercap, probs = 0.25),
            "50%" = quantile(gdpPercap, probs = 0.50),
            "75%" = quantile(gdpPercap, probs = 0.75), 
            avg = mean(gdpPercap),
            n = n())
```

    ## # A tibble: 5 x 6
    ##   continent     `25%`     `50%`     `75%`       avg     n
    ##      <fctr>     <dbl>     <dbl>     <dbl>     <dbl> <int>
    ## 1    Africa   761.247  1192.138  2377.417  2193.755   624
    ## 2  Americas  3427.779  5465.510  7830.210  7136.110   300
    ## 3      Asia  1056.993  2646.787  8549.256  7902.150   396
    ## 4    Europe  7213.085 12081.749 20461.386 14469.476   360
    ## 5   Oceania 14141.859 17983.304 22214.117 18621.609    24

``` r
?quantile
```

Task \#3
--------

**Objective**: How is life expectancy changing over time on different continents?

**Process**: Use `group_by` and `mutate` to create a new variable that capture the change in ife expectancy over years, but in this case by calculating the difference between life expectancy in a given year with the first year with data for each country. I saved that as a new object.

To display the change over time per continent in a table, I decided to summarize the *average* change in life expectancy per year and used `knitr::kable`. However for the graph, it is more informative to keep all values for each country, but including a linear regression per continent to see the trend in change of life expectancy, also using `ggplot2`.

**Additional Resources**: I used the function `spread` to display an optional table following [this](http://tidyr.tidyverse.org/reference/spread.html) link

``` r
life_change <- gapminder %>% 
  group_by(country) %>% 
  arrange(year) %>% 
  mutate (change_lifeExp = lifeExp - lifeExp[1]) 
```

Table option 1 (only visualizing the very first rows, 'cause its a long table)

``` r
mean_change <- life_change %>% 
  group_by(continent, year) %>% 
  summarise(mean_change = mean(change_lifeExp))
head(mean_change) %>%  knitr::kable(col.names = c("Continent", "year", "Mean ∆ Life expectancy"))
```

| Continent |  year|  Mean ∆ Life expectancy|
|:----------|-----:|-----------------------:|
| Africa    |  1952|                0.000000|
| Africa    |  1957|                2.130846|
| Africa    |  1962|                4.183942|
| Africa    |  1967|                6.199039|
| Africa    |  1972|                8.315442|
| Africa    |  1977|               10.444923|

Table option 2 (using `spread` from tidyr to see a comparison across years of the mean change in life expectancy by continent)

``` r
mean_change <- life_change %>% 
  group_by(continent, year) %>% 
  summarise(mean_change = mean(change_lifeExp)) %>% 
  spread(year, mean_change)
knitr::kable(mean_change)
```

| continent |  1952|      1957|      1962|      1967|       1972|       1977|      1982|       1987|      1992|      1997|      2002|      2007|
|:----------|-----:|---------:|---------:|---------:|----------:|----------:|---------:|----------:|---------:|---------:|---------:|---------:|
| Africa    |     0|  2.130846|  4.183942|  6.199039|   8.315442|  10.444923|  12.45737|  14.209288|  14.49408|  14.46277|  14.18973|  15.67054|
| Americas  |     0|  2.680440|  5.118920|  7.131080|   9.115080|  11.111720|  12.94900|  14.810880|  16.28852|  17.87064|  19.14220|  20.32828|
| Asia      |     0|  3.004150|  5.248829|  8.349246|  11.004875|  13.296162|  16.30355|  18.536788|  20.22282|  21.70612|  22.91948|  24.41409|
| Europe    |     0|  2.294567|  4.130733|  5.329100|   6.366533|   7.529267|   8.39790|   9.233667|  10.03160|  11.09667|  12.29210|  13.24010|
| Oceania   |     0|  1.040000|  1.830000|  2.055000|   2.655000|   3.600000|   5.03500|   6.065000|   7.69000|   8.93500|  10.48500|  11.46450|

Figure

``` r
ggplot(life_change, aes(year, change_lifeExp, colour = continent)) +
  geom_point() +
  facet_wrap(~ continent) +
  geom_smooth(method = "loess") +
  labs(title = "Change in life expectancy for each continent relative to 1952", x = "Years", y = "Change in Life Expectancy") +
  guides(colour = FALSE) +
  theme_classic() 
```

![](dplyr_ggplot_hw03_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-10-1.png)

**Observations**: There must be lots of ways to show the change in Life expectancy over years for each continent. I decided to calculate the change in life expectancy relative to the first year in the database, which is 1952. We can see from the table and figure that overall all continents have shown an increase in life expectancy from 1952 to 2007. Asia and America exhibit a very high increase in life expectancy in this time period of 24.4 and 20.3 years, respectively, compared to the other continents. This is also evident in the slopes of the graph. Interestingly, there are some points in the graph that exhibit a negative value, which imply that for that year the life expectancy of that country was actually lower than the life expectancy in 1952.
