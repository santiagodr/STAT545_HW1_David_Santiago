# [HW07](http://stat545.com/hw07_automation.html) Automating Data-analysis Pipelines

## Activities and Process report

This is so far the most complex but rewarding homework for me. I decided to move on from gapminder and tried to build an analytical pipeline for new data that might be useful for my own research.

For this homework I use two recently published databases for bird species. One is for morphological traits for one quarter of the birds of the world (~2500), the other one is about functional traits such as diet, foraging strata for all bird species in the world (~10000).

- Wilman etal. 2014 Elton Traits 1.0: Species-level foraging attributes of the world's birds and mammals. Ecology 95:2027 [link](http://onlinelibrary.wiley.com/doi/10.1890/13-1917.1/abstract)
- Ricklefs 2017 Passerine morphology: external measurements of approximately one-quarter of passerines bird species. Ecology 98(5): 1472 [link](http://onlinelibrary.wiley.com/doi/10.1002/ecy.1783/suppinfo)

### 1 - Download data
I needed data from two sources and used package `downloader` to extract them. This code is in [1_download_data.R](https://github.com/santiagodr/STAT545_hw_David_Santiago/blob/master/hw07/1_download_data.R)

### 2 - Clean data
In order to get the data I needed. I had to read the data, fix some inconsistencies, such as the scientific names in both databases, and use a join to combine both set of data into one usable dataset for species that were in both databases. I exported this file. This code is in [2_read_join_filter_data.R](https://github.com/santiagodr/STAT545_hw_David_Santiago/blob/master/hw07/2_read_join_filter_data.R)

### 3 - Analyze data
With a clean version of the data, I was able to summarize and analized some variables that produced 5 figures. There are many more uses of these data, but I feel this was enough for the purpose of this assignment. The code is in [3_analysis.R](https://github.com/santiagodr/STAT545_hw_David_Santiago/blob/master/hw07/3_analysis.R)

### 4 - Report!!!
I decided to show the figures in a standard md.file like the ones we have been using so far... In this homework, I'm not including chunks of code in the md file, because the objective was to show you only the figures... So, the code is available in the previous scripts, and here is the [report](https://github.com/santiagodr/STAT545_hw_David_Santiago/blob/master/hw07/automating_data_pipelines_hw07.md)

### 5 - Makefile
Finally, I built a makefile to run (and clean) all the analytical pipeline, and to `render` the Rmd file without using Rstudio. I struggled a bit with this part and was having several error messages. However, most of these errors were because I didn't provide enough information for the files to be build... Here is the [Makefile](https://github.com/santiagodr/STAT545_hw_David_Santiago/blob/master/hw07/Makefile)


### Additional resources

There were a number of times I needed help from the web... Here are the specific links that helped me.

- One of the files was a zip file. I followed recommendations from this stackoverflow [post](https://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data) to read that type of data. **Very useful**

- To fix names I used str_c from `stringr` following some recommendations from this [blog](https://blog.exploratory.io/7-most-practically-useful-operations-when-wrangling-with-text-data-in-r-7654bd9d1a0c)

- To help me thinking in ways to display the data, I was inspired by these awesome [ggplot visualizations](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html)