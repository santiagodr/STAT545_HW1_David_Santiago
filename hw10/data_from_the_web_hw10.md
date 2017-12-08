Data from the Web
================
Santiago David
2017-12-07

Since we already practiced with Web scraping and using API queries in class, I decided that for this homeworkd I will use an R package that wraps an API from the rOpenSci in order to get data from the web.

#### `reBird`

is a package that interface with the [eBird](http://ebird.org/content/ebird/) website, which is a real-time, online bird checklist program that allows birders to record the birds they see, keep track of their lists and at the same time, contribute to science and conservation. Click [here](https://github.com/ropensci/rebird) for more info

#### `rplos`

on the other side, is a package for accessing full text articles from the Public Library of Science journals using their API. Click [here](https://github.com/ropensci/rplos) for more info.

### **Main objectives**:

The general objective is to combine information from these two rOpenSci packages to explore teh question **how many articles have been published on a bird species?**. I will do these for all the bird species recorded on eBird for the UBC campus.

### **Process**

**First**, we need to install and load both packages

``` r
#install.packages("rebird")
#install.packages("rplos")
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(knitr))
suppressPackageStartupMessages(library(rebird))
suppressPackageStartupMessages(library(rplos))
```

    ## Warning: package 'rplos' was built under R version 3.4.2

#### **`rebird` data**

There are several ways to extract information from **eBird** using `rebird`, for example, you can search bird species for a "region", using short codes that refers to political units, for example a country, lets explore the number of birds recorded for CANADA = CAN

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

|        lng| locName           |  howMany| sciName              | obsValid | locationPrivate | obsDt            | obsReviewed | comName                |       lat| locID    |
|----------:|:------------------|--------:|:---------------------|:---------|:----------------|:-----------------|:------------|:-----------------------|---------:|:---------|
|  -64.35237| Front Centre yard |        7| Poecile atricapillus | TRUE     | TRUE            | 2017-12-08 16:29 | FALSE       | Black-capped Chickadee |  44.37528| L1010062 |
|  -64.35237| Front Centre yard |        2| Zenaida macroura     | TRUE     | TRUE            | 2017-12-08 16:29 | FALSE       | Mourning Dove          |  44.37528| L1010062 |
|  -60.29472| Balls Creek Bay   |        2| Bucephala clangula   | TRUE     | TRUE            | 2017-12-08 16:18 | FALSE       | Common Goldeneye       |  46.15367| L6431299 |
|  -60.29472| Balls Creek Bay   |        3| Larus delawarensis   | TRUE     | TRUE            | 2017-12-08 16:18 | FALSE       | Ring-billed Gull       |  46.15367| L6431299 |
|  -60.29472| Balls Creek Bay   |        9| Anas platyrhynchos   | TRUE     | TRUE            | 2017-12-08 16:18 | FALSE       | Mallard                |  46.15367| L6431299 |
|  -60.29472| Balls Creek Bay   |       40| Larus argentatus     | TRUE     | TRUE            | 2017-12-08 16:18 | FALSE       | Herring Gull           |  46.15367| L6431299 |

We can see that `rebird` gives us a lot of information such as scientific name, common name, locality, coordinates... But, the amount of birds in Canada is probably too much for this exercise..., let's narrow it down to birds in UBC campus

For this, we can extract information for a particular geographic location by using `rebird` function `ebirdhotspot()`, which uses categories assigned in `ebird` for particular areas

If we search for birds in [UBC campus](http://ebird.org/ebird/hotspot/L344557) on the website, we will observe something like this:

![](ebird_screenshot.png)

But, we want to get that list on R..., so we can use the code for Vancouver-UBC which is "L344557". (Note: The maximum number of days back allowed to look for observations is 30)

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
  select(sciName, comName)
```

#### **`rplos` data**

Now we can use `rplos` package to extract information of articles from the Public Library of Science journals using their API. The package offers a wide range of functions to access this information, such as:

-   `searchplos()`, the basic function for searching plos
-   `plosauthor()`, search on author name
-   `plostitle()`, search the title
-   `plosabstract()`, search the abstract
-   `plossubject()`, search by subject
-   `citations()`, search the PLOS Rich Citations
-   `plos_fulltext()`, retrieve full text using a DOI
-   `highplos()`, highlight search terms in the results.
-   `highbrow()`, browse search terms in a browser with hyperlinks.

But, we only need the number of articles published for each bird species recorded in the UBC campus in the last month... So, we can use `searchplos()` with several arguments for the results

Let's do it for one species first...

``` r
crowpapers <- searchplos(q = 'Corvus caurinus',
           fl = c("id", "publication_date", "title", "abstract"))
```

This simple code basically sends a request to the PLOS API to retrieve information about papers published for the "Northwestern Crow (Corvus caurinus)"... Let's inspect that object

``` r
crowpapers
```

    ## $meta
    ## # A tibble: 1 x 2
    ##   numFound start
    ##      <int> <int>
    ## 1        4     0
    ## 
    ## $data
    ## # A tibble: 4 x 4
    ##                             id     publication_date
    ##                          <chr>                <chr>
    ## 1 10.1371/journal.pone.0009266 2010-02-24T00:00:00Z
    ## 2 10.1371/journal.pbio.0020312 2004-09-28T00:00:00Z
    ## 3 10.1371/journal.pone.0025877 2011-10-03T00:00:00Z
    ## 4 10.1371/journal.pone.0034678 2012-03-30T00:00:00Z
    ## # ... with 2 more variables: abstract <chr>, title <chr>

This object is basically a list with two elements `$meta` which stands for the number of records found and `$data` which contains the information we asked PLOS for... So, this is useful... We want this information for the 17 species in our list!

But, let's explore the number of papers published for this species, we can access that info by getting into the list elements

``` r
crowpapers$meta$numFound
```

    ## [1] 4

There were four papers retrieved!

**Now**, to get the data for the 17 species in our UBC-bird-list, I will define a function that run the query and retrieve the information for each species name... It will be good to include a `sleep time` parameter, because there is a maximum limit of 10 request per minute on the website.

``` r
extract_papers <- function(sciName){
  searchplos(q = sciName, fl = c("id", "publication_date", "title", "abstract"), sleep = 10)
}
```

Now, we can `map` this function to the ubc bird list and save it on the dataframe, and because the result of the `searchplos()` function is a list, it means we will have a nested dataframe... Luckily we learned how to handle those...

``` r
ubcbirds2 <- ubcbirds2 %>% 
  mutate(info_papers = map(sciName, extract_papers))

head(ubcbirds2)
```

    ## # A tibble: 6 x 3
    ##                    sciName                comName info_papers
    ##                      <chr>                  <chr>      <list>
    ## 1 Haliaeetus leucocephalus             Bald Eagle  <list [2]>
    ## 2            Columba livia            Rock Pigeon  <list [2]>
    ## 3          Corvus caurinus      Northwestern Crow  <list [2]>
    ## 4     Poecile atricapillus Black-capped Chickadee  <list [2]>
    ## 5         Sitta canadensis  Red-breasted Nuthatch  <list [2]>
    ## 6           Junco hyemalis        Dark-eyed Junco  <list [2]>

``` r
glimpse(ubcbirds2)
```

    ## Observations: 17
    ## Variables: 3
    ## $ sciName     <chr> "Haliaeetus leucocephalus", "Columba livia", "Corv...
    ## $ comName     <chr> "Bald Eagle", "Rock Pigeon", "Northwestern Crow", ...
    ## $ info_papers <list> [[<# A tibble: 1 x 2,   numFound start,      <int...

Note the new variable `info_papers` of the type list! That's where all our information is contained...

Pretty good ehh! Now, our original question was **how many articles have been published on a bird species?** This information is contained in our list object `info_papers`, but let's make it more explicit by extracting the number of papers from the object, but also keeping all the information ("id", "publication\_date", "title", "abstract") in another list in the dataframe...

``` r
ubcbirds2 <- ubcbirds2 %>% 
  mutate(N_papers = ubcbirds2$info_papers %>%
                    map_int(~ .x[[1]][[1]][[1]]), # extract only number of papers
        info_papers = ubcbirds2$info_papers %>%
                      map(~ .x[[2]]))  # extract list of papers and override that column

head(ubcbirds2) 
```

    ## # A tibble: 6 x 4
    ##                    sciName                comName       info_papers
    ##                      <chr>                  <chr>            <list>
    ## 1 Haliaeetus leucocephalus             Bald Eagle <tibble [10 x 4]>
    ## 2            Columba livia            Rock Pigeon <tibble [10 x 4]>
    ## 3          Corvus caurinus      Northwestern Crow  <tibble [4 x 4]>
    ## 4     Poecile atricapillus Black-capped Chickadee <tibble [10 x 4]>
    ## 5         Sitta canadensis  Red-breasted Nuthatch <tibble [10 x 4]>
    ## 6           Junco hyemalis        Dark-eyed Junco <tibble [10 x 4]>
    ## # ... with 1 more variables: N_papers <int>

Excellent!, Basically this is what I wanted a dataframe with the bird species recorded in eBird in the last month for the UBC campus, and a list of the papers published in PLOS for each of those species, I also extracted important info from those papers such as the "publication\_date", "title", and "abstract"...

Now, we can easily `unnest()` these papers list and export that info as a .csv file if we want to have a separate copy

``` r
full_list <- ubcbirds2 %>% 
  unnest(info_papers)

head(full_list) #see head of full list
```

    ## # A tibble: 6 x 7
    ##                    sciName    comName N_papers
    ##                      <chr>      <chr>    <int>
    ## 1 Haliaeetus leucocephalus Bald Eagle       42
    ## 2 Haliaeetus leucocephalus Bald Eagle       42
    ## 3 Haliaeetus leucocephalus Bald Eagle       42
    ## 4 Haliaeetus leucocephalus Bald Eagle       42
    ## 5 Haliaeetus leucocephalus Bald Eagle       42
    ## 6 Haliaeetus leucocephalus Bald Eagle       42
    ## # ... with 4 more variables: id <chr>, publication_date <chr>,
    ## #   abstract <chr>, title <chr>

``` r
write_csv(full_list, "ubc_birds_papers_published.csv") #save file
```

The one last thing, I would like to do, is just visualize the number of papers published per species...

``` r
ubcbirds2 %>% 
  ggplot(aes(x = reorder(comName, -N_papers), y = N_papers)) +  theme_bw() +
  geom_bar(stat = "identity") +
  labs(x = "Bird species", y = "Number of published papers") +
  theme(axis.text.x = element_text(angle=90, hjust = 1))
```

![](data_from_the_web_hw10_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png)

Looks like a lot have been published on Rock Pigeons and very little on Varied Thrush!

That's it!!! Happy holidays!
