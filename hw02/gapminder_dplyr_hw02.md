Gapminder exploration with dplyr and ggplot2 hw02
================

Bring data in
-------------

We already installed the packages, so I'll just load them

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

Smell test the data
-------------------

Is it a data.frame, a matrix, a vector, a list?

``` r
typeof(gapminder)
```

    ## [1] "list"

**Answer**: Gapminder is an object of the type *list*. I used the function `typeof` to ask for its type

What’s its class?

``` r
class(gapminder)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

**Answer**: If I understand *data structures*, gapminder is both a tibble and a dataframe as we can see using `class` for the different elements in the list.

How many variables/columns?

``` r
ncol(gapminder)
```

    ## [1] 6

**Answer**: There are 6 columns in gapminder. The easiest way to see this is using `ncol` as well as for the number of rows using `nrow`

How many rows/observations?

``` r
nrow(gapminder)
```

    ## [1] 1704

**Answer**: There are 1704 rows

Can you get these facts about “extent” or “size” in more than one way? Can you imagine different functions being useful in different contexts?

**Answer**: Yes! I'm sure there are tons of ways to do that in r. Two ways I can think of are using `dim` to see the dimensions of the dataframe, and `str` to see the whole structure. Personally, I always use `str` to inspect not only the dimensions of the dataframe but also the type of all variables. But in a different context if someone is only interested in the size of the dataframe, `dim` would make the trick.

``` r
dim(gapminder)
```

    ## [1] 1704    6

``` r
str(gapminder)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    1704 obs. of  6 variables:
    ##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
    ##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
    ##  $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
    ##  $ gdpPercap: num  779 821 853 836 740 ...

What data type is each variable?

**Answer**: We can easily check this using `str` as seen above. *country* and *continent* are objects of the type `Factor`, *year* and *pop* are `integer`, and *lifeExp* and *gdpPercap* are `numeric`.

Explore individual variables
----------------------------

I will explore the categorical variable `country` and two quantitative variables population `pop` and year `year`

What are possible values (or range, whichever is appropriate) of each variable?

**Answer1**: For the categorical variable, we can see all possible values or *non-repeated* entries using the function `unique`

``` r
unique(gapminder$country)
```

    ##   [1] Afghanistan              Albania                 
    ##   [3] Algeria                  Angola                  
    ##   [5] Argentina                Australia               
    ##   [7] Austria                  Bahrain                 
    ##   [9] Bangladesh               Belgium                 
    ##  [11] Benin                    Bolivia                 
    ##  [13] Bosnia and Herzegovina   Botswana                
    ##  [15] Brazil                   Bulgaria                
    ##  [17] Burkina Faso             Burundi                 
    ##  [19] Cambodia                 Cameroon                
    ##  [21] Canada                   Central African Republic
    ##  [23] Chad                     Chile                   
    ##  [25] China                    Colombia                
    ##  [27] Comoros                  Congo, Dem. Rep.        
    ##  [29] Congo, Rep.              Costa Rica              
    ##  [31] Cote d'Ivoire            Croatia                 
    ##  [33] Cuba                     Czech Republic          
    ##  [35] Denmark                  Djibouti                
    ##  [37] Dominican Republic       Ecuador                 
    ##  [39] Egypt                    El Salvador             
    ##  [41] Equatorial Guinea        Eritrea                 
    ##  [43] Ethiopia                 Finland                 
    ##  [45] France                   Gabon                   
    ##  [47] Gambia                   Germany                 
    ##  [49] Ghana                    Greece                  
    ##  [51] Guatemala                Guinea                  
    ##  [53] Guinea-Bissau            Haiti                   
    ##  [55] Honduras                 Hong Kong, China        
    ##  [57] Hungary                  Iceland                 
    ##  [59] India                    Indonesia               
    ##  [61] Iran                     Iraq                    
    ##  [63] Ireland                  Israel                  
    ##  [65] Italy                    Jamaica                 
    ##  [67] Japan                    Jordan                  
    ##  [69] Kenya                    Korea, Dem. Rep.        
    ##  [71] Korea, Rep.              Kuwait                  
    ##  [73] Lebanon                  Lesotho                 
    ##  [75] Liberia                  Libya                   
    ##  [77] Madagascar               Malawi                  
    ##  [79] Malaysia                 Mali                    
    ##  [81] Mauritania               Mauritius               
    ##  [83] Mexico                   Mongolia                
    ##  [85] Montenegro               Morocco                 
    ##  [87] Mozambique               Myanmar                 
    ##  [89] Namibia                  Nepal                   
    ##  [91] Netherlands              New Zealand             
    ##  [93] Nicaragua                Niger                   
    ##  [95] Nigeria                  Norway                  
    ##  [97] Oman                     Pakistan                
    ##  [99] Panama                   Paraguay                
    ## [101] Peru                     Philippines             
    ## [103] Poland                   Portugal                
    ## [105] Puerto Rico              Reunion                 
    ## [107] Romania                  Rwanda                  
    ## [109] Sao Tome and Principe    Saudi Arabia            
    ## [111] Senegal                  Serbia                  
    ## [113] Sierra Leone             Singapore               
    ## [115] Slovak Republic          Slovenia                
    ## [117] Somalia                  South Africa            
    ## [119] Spain                    Sri Lanka               
    ## [121] Sudan                    Swaziland               
    ## [123] Sweden                   Switzerland             
    ## [125] Syria                    Taiwan                  
    ## [127] Tanzania                 Thailand                
    ## [129] Togo                     Trinidad and Tobago     
    ## [131] Tunisia                  Turkey                  
    ## [133] Uganda                   United Kingdom          
    ## [135] United States            Uruguay                 
    ## [137] Venezuela                Vietnam                 
    ## [139] West Bank and Gaza       Yemen, Rep.             
    ## [141] Zambia                   Zimbabwe                
    ## 142 Levels: Afghanistan Albania Algeria Angola Argentina ... Zimbabwe

We can also see from this list of names that there are 142 countries. Or we can directly ask that using `n_distinct` or `length`

``` r
length(unique(gapminder$country))
```

    ## [1] 142

For the **quantitative variables**, I am assuming there wont be data for many years so we can also use `unique` to see the specific years and `range` to see the oldest and most recent. But for population, we can expect that all countries will have different pop sizes every year, so that would be a very long list, in this case it is better to explore the range.

For `year`:

``` r
unique(gapminder$year)
```

    ##  [1] 1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 2002 2007

``` r
range(gapminder$year)
```

    ## [1] 1952 2007

``` r
n_distinct(gapminder$year)
```

    ## [1] 12

For `pop`

``` r
range(gapminder$pop)
```

    ## [1]      60011 1318683096

**Answer2**: There are data from 12 years starting in 1952 with the most recent data from 2007. There are population sizes starting from 60011 to 1318683096 (individuals!, I guess...)

What values are typical? What’s the spread? What’s the distribution? Etc., tailored to the variable at hand
