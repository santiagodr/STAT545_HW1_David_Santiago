gapminder exploration hw02
================

We already installed the packages, so I'll just go ahead and load them

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

Explore the gapminder object:
-----------------------------

Is it a data.frame, a matrix, a vector, a list?

``` r
typeof(gapminder)
```

    ## [1] "list"

Answer: Gapminder is an object of the type *list*. I used the function `typeof` to ask for its type

What’s its class?

``` r
class(gapminder)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

How many variables/columns?

``` r
dim(gapminder)
```

    ## [1] 1704    6

How many rows/observations? Can you get these facts about “extent” or “size” in more than one way? Can you imagine different functions being useful in different contexts? What data type is each variable?
