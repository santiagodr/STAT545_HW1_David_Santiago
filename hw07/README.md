# [HW07](http://stat545.com/hw07_automation.html) Automating DAta-analysis Pipelines

### Activities

- All coding, graphs, and materials are in this [md.file]

### Reporting process

The goal would be to get data from the internet (tentatively SACC species list by country) (http://www.museum.lsu.edu/~Remsen/SACCListByCountry.xls), run some cleaning to produce a csv file that is usable, run some stats and produce graphs. The idea would be that in some months when the list is updated, we can just run a Makefile and produce an update of everything...

First, need to decide how to extract the data, using base R, or curl???



### Citation for Data used in this homework

- Wilman etal. 2014 Elton Traits 1.0: Species-level foraging attributes of the world's birds and mammals. Ecology 95:2027 [link](http://onlinelibrary.wiley.com/doi/10.1890/13-1917.1/abstract)
- Ricklefs 2017 Passerine morphology: external measurements of approximately one-quarter of passerines bird species. Ecology 98(5): 1472 [link](http://onlinelibrary.wiley.com/doi/10.1002/ecy.1783/suppinfo)

### Additional resources

- One of the files was a zip file. I followed recommendations from this stackoverflow [post](https://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data) to read that type of data. **Very useful**

