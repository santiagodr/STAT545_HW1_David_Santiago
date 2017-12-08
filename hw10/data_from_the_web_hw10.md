Data from the Web
================
Santiago David
2017-12-07

Since we already practiced with Web scraping and using API queries in class, I decided that for this homeworkd I will use an R package that wraps an API from the rOpenSci in order to get data from the web.

`reBird` is a package that interface with the [eBird](http://ebird.org/content/ebird/) website, which is a real-time, online bird checklist program that allows birders to record the birds they see, keep track of their lists and at the same time, contribute to science and conservation. Click [here](https://github.com/ropensci/rebird) for more info

`rplos` on the other side, is a package for accessing full text articles from the Public Library of Science journals using their API. Click [here](https://github.com/ropensci/rplos) for more info.

### **Main objectives**:

The general objective is to combine information from these two rOpenSci packages to explore how many articles have been published on a bird species. I will do these for all the bird species recorded on eBird for the UBC campus.

Specifically, I did the following: 1 - Download data from the internet from two sources 2 - Read, Join, Filter and Clean the data for Analysis and Graphics 3 - Analyze the combined dataset in different ways to produce some summary graphs 4 - Render this R Markdown document without using RStudio's buttons.

### **Process**

**First**, we need to install and load both packages

``` r
#install.packages("rebird")
#install.packages("rplos")
suppressPackageStartupMessages(library(rebird))
suppressPackageStartupMessages(library(rplos))
```

    ## Warning: package 'rplos' was built under R version 3.4.2

``` r
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(knitr))
```

**`rebird` data** There are several ways to extract information from **eBird** using `rebird`, for example, you can search bird species for a "region", using short codes that refers to political units, for example a country, lets explore the number of birds recorded for CANADA = CAN

``` r
canadianbirds <- ebirdregion("CA")
```

    ## Warning in strptime(x, fmt, tz = "GMT"): unknown timezone 'zone/tz/2017c.
    ## 1.0/zoneinfo/America/Vancouver'

``` r
canadianbirds %>% 
  head() %>% 
  knitr::kable()
```

|        lng| locName                                             |  howMany| sciName            | obsValid | locationPrivate | obsDt            | obsReviewed | comName             |       lat| locID    |
|----------:|:----------------------------------------------------|--------:|:-------------------|:---------|:----------------|:-----------------|:------------|:--------------------|---------:|:---------|
|  -62.64702| 105 George St, New Glasgow CA-NS (45.5896,-62.6470) |        5| Anas platyrhynchos | TRUE     | TRUE            | 2017-12-07 19:53 | FALSE       | Mallard             |  45.58959| L6542144 |
|  -97.10361| Burland Park                                        |        1| Bubo virginianus   | TRUE     | TRUE            | 2017-12-07 18:06 | FALSE       | Great Horned Owl    |  49.80298| L3480626 |
|  -80.68160| Tower line rd at Middletown line                    |        1| Bubo scandiacus    | TRUE     | TRUE            | 2017-12-07 17:30 | FALSE       | Snowy Owl           |  43.12617| L6542141 |
|  -79.80622| CA-ON-New Tecumseth (44.1111,-79.8062)              |        3| Anas rubripes      | TRUE     | TRUE            | 2017-12-07 16:51 | FALSE       | American Black Duck |  44.11111| L6541848 |
|  -79.80622| CA-ON-New Tecumseth (44.1111,-79.8062)              |      400| Branta canadensis  | TRUE     | TRUE            | 2017-12-07 16:51 | FALSE       | Canada Goose        |  44.11111| L6541848 |
|  -76.61208| Kingston--Lemoine Point CA                          |        1| Asio flammeus      | TRUE     | FALSE           | 2017-12-07 16:45 | FALSE       | Short-eared Owl     |  44.22582| L298965  |

We can see that `rebird` gives us a lot of information such as scientific name, common name, locality, coordinates... But, the amount of birds in Canada is probably too much for this exercise..., let's narrow it down to birds in UBC campus

For this, we can extract information for a particular geographic location by using `rebird` function `ebirdhotspot()`, which uses categories assigned in `ebird` for particular areas

If we search for birds in [UBC campus](http://ebird.org/ebird/hotspot/L344557) on the website, we will observe something like this:

![](ebird_screenshot.png) But, we want to get that list on R..., so we can use the code for Vancouver-UBC which is "L344557". (Note: The maximum number of days back allowed to look for observations is 30)

``` r
ubcbirds <- ebirdhotspot(locID = "L344557", back = 30) 

glimpse(ubcbirds)
```

    ## Observations: 19
    ## Variables: 11
    ## $ lng             <dbl> -123.2526, -123.2526, -123.2526, -123.2526, -1...
    ## $ locName         <chr> "Vancouver--University of British Columbia", "...
    ## $ howMany         <int> 1, 1, 5, 4, 3, 3, 1, 1, 2, 2, 4, 2, 3, 1, 1, 1...
    ## $ sciName         <chr> "Accipiter striatus/cooperii", "Haliaeetus leu...
    ## $ obsValid        <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE...
    ## $ locationPrivate <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALS...
    ## $ obsDt           <chr> "2017-12-03 14:30", "2017-12-03 14:30", "2017-...
    ## $ obsReviewed     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALS...
    ## $ comName         <chr> "Sharp-shinned/Cooper's Hawk", "Bald Eagle", "...
    ## $ lat             <dbl> 49.26476, 49.26476, 49.26476, 49.26476, 49.264...
    ## $ locID           <chr> "L344557", "L344557", "L344557", "L344557", "L...

``` r
ubcbirds %>%
  head() %>%
  kable()
```

|        lng| locName                                   |  howMany| sciName                     | obsValid | locationPrivate | obsDt            | obsReviewed | comName                     |       lat| locID   |
|----------:|:------------------------------------------|--------:|:----------------------------|:---------|:----------------|:-----------------|:------------|:----------------------------|---------:|:--------|
|  -123.2526| Vancouver--University of British Columbia |        1| Accipiter striatus/cooperii | TRUE     | FALSE           | 2017-12-03 14:30 | FALSE       | Sharp-shinned/Cooper's Hawk |  49.26476| L344557 |
|  -123.2526| Vancouver--University of British Columbia |        1| Haliaeetus leucocephalus    | TRUE     | FALSE           | 2017-12-03 14:30 | FALSE       | Bald Eagle                  |  49.26476| L344557 |
|  -123.2526| Vancouver--University of British Columbia |        5| Larinae sp.                 | TRUE     | FALSE           | 2017-12-03 14:30 | FALSE       | gull sp.                    |  49.26476| L344557 |
|  -123.2526| Vancouver--University of British Columbia |        4| Columba livia               | TRUE     | FALSE           | 2017-12-03 14:30 | FALSE       | Rock Pigeon                 |  49.26476| L344557 |
|  -123.2526| Vancouver--University of British Columbia |        3| Corvus caurinus             | TRUE     | FALSE           | 2017-12-03 14:30 | FALSE       | Northwestern Crow           |  49.26476| L344557 |
|  -123.2526| Vancouver--University of British Columbia |        3| Poecile atricapillus        | TRUE     | FALSE           | 2017-12-03 14:30 | FALSE       | Black-capped Chickadee      |  49.26476| L344557 |

Apparently, in the last month, there have been only 19 species of birds recorded at UBC campus (or at least 19 submitted to ebird), we know there are way more birds on campus, but it's okay... We can work with this list and explore how many articles have been published about these species of birds.

But **before** moving to the second part, we should tidy this list first, right?, lets make sure scientific names are correct (i.e. binomial) and unique for each secies...

``` r
ubcbirds$sciName 
```

    ##  [1] "Accipiter striatus/cooperii" "Haliaeetus leucocephalus"   
    ##  [3] "Larinae sp."                 "Columba livia"              
    ##  [5] "Corvus caurinus"             "Poecile atricapillus"       
    ##  [7] "Sitta canadensis"            "Junco hyemalis"             
    ##  [9] "Melospiza melodia"           "Pipilo maculatus"           
    ## [11] "Haemorhous mexicanus"        "Spinus tristis"             
    ## [13] "Calypte anna"                "Turdus migratorius"         
    ## [15] "Larus delawarensis"          "Larus glaucescens"          
    ## [17] "Ixoreus naevius"             "Poecile rufescens"          
    ## [19] "Psaltriparus minimus"

There are two dubious names on this list (i.e. observer didn't know exactly which species it was), so let's get rid off them and select only variables of interest...

``` r
ubcbirds2 <- ubcbirds %>% 
  filter(!(sciName == "Larinae sp." | sciName == "Accipiter striatus/cooperii")) %>% 
  select(sciName, howMany, comName, lat, lng)
```

**`rplos` data** Now we can use `rplos` package to extract information from full text articles from the Public Library of Science journals using their API

``` r
searchplos('Corvus caurinus', 'id,publication_date', limit = 5)
```

    ## $meta
    ## # A tibble: 1 x 2
    ##   numFound start
    ##      <int> <int>
    ## 1        4     0
    ## 
    ## $data
    ## # A tibble: 4 x 2
    ##                             id     publication_date
    ##                          <chr>                <chr>
    ## 1 10.1371/journal.pone.0009266 2010-02-24T00:00:00Z
    ## 2 10.1371/journal.pone.0025877 2011-10-03T00:00:00Z
    ## 3 10.1371/journal.pbio.0020312 2004-09-28T00:00:00Z
    ## 4 10.1371/journal.pone.0034678 2012-03-30T00:00:00Z
