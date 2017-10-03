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
-   

Task \#1
--------

**Objective**: Get the maximum and minimum of GDP per capita for all continents. **Process**: Use `group_by` and `summarise` to obtain the min and max of the variable, save that as a new object and use that object to create table and plot

``` r
gdpmaxmin <- gapminder %>% 
  group_by(continent) %>% 
  summarise(min_gdpPercap = min(gdpPercap),
            max_gdpPercap = max(gdpPercap))

knitr::kable(gdpmaxmin, col.names = c("Continent", "Minimum GDP per capita", "Maximum GDP per capita"))
```

| Continent |  Minimum GDP per capita|  Maximum GDP per capita|
|:----------|-----------------------:|-----------------------:|
| Africa    |                241.1659|                21951.21|
| Americas  |               1201.6372|                42951.65|
| Asia      |                331.0000|               113523.13|
| Europe    |                973.5332|                49357.19|
| Oceania   |              10039.5956|                34435.37|

Pick at least three of the tasks below and attack each with a table and figure
