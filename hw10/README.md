# [HW10](http://stat545.com/hw10_data-from-web.html) Data from the web

Since we already practiced with Web scraping by hand and using API queries in class, I decided that for this homeworkd I will **use an R package that wraps an API** from the rOpenSci in order to get data from the web.

I was motivated by the question **how many articles are published on a bird species?** suggested in one of the HW prompts.

### Process
- For this hw I explored the R packages `rebird` and `rplos` which interface with their respectives API's, see descriptions and links in the [.md](https://github.com/santiagodr/STAT545_hw_David_Santiago/blob/master/hw10/data_from_the_web_hw10.md) file
- Specifically, I used `rebird` to extract a list of bird species recorded in the website eBird for the locality "UBC campus" in the last 30 days...
- I cleaned the scientific names on that list 
- then I used `rplos` to extract the number of articles published for one species and to retrieve information such as title and abstract for those articles
- I defined a function to extract this information for a list of species and included that result in a dataframe
- Finally, I dealt with the nested dataframe and exported a [.csv file](https://github.com/santiagodr/STAT545_hw_David_Santiago/blob/master/hw10/ubc_birds_papers_published.csv) with the information and created a simple graph to visualize the results


### Final thoughts...
Since I worked with Packages that wrap specific API's, obtaining the information from the websites was not very difficult... The functions and documentation for working with these packages was very clear... However, the most challenging part was creating the function to extract information for multiple species at once, and dealing with nested dataframes after that... The codes at the end look simple, but I spent a tremendous amount of time trying to extract elemeents of a list using `map_int(~ .x[[1]][[1]][[1]])`. 
Overall, this was an interesting homework and a good chance to practice other tools that I learned during this course..

### Resources
I basically read the [documentation](https://github.com/ropensci/rplos) and [tutorial](https://ropensci.org/tutorials/rplos_tutorial/) for `rplos`, as well as the [documentation](https://github.com/ropensci/rebird) for `rebird` to understand how they work... Very useful packages!!!

Also, I got help from my friend and officemate [Melissa](https://github.com/lmguzman), when extracting information from a list using `map_int()`
