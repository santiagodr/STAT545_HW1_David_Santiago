# [HW06](http://stat545.com/hw06_data-wrangling-conclusion.html) Data wrangling wrap up

### Activities
- Writing functions
- Work with a nested data frame

All coding, graphs, and materials are in this [md.file](https://github.com/santiagodr/STAT545_hw_David_Santiago/blob/master/hw06/data_wrangling_hw06.md)

### Reporting process

- All this homework was done using R Studio and the usual workflow
- I included specific objectives, a brief description of the process and a few observations for each independent activity. I decided to work on functions and nested data frames, since these are very common in the work and data I have to analyze. This is the first time that I get to understand how a function works, honestly! I tried before, but never got to understand the flow of arguments, and steps until this assigment, that part was very rewarding. However, it was also hard to put everything together, since I basically tried to have one single function that fit several linear models at once, to produce output that I was interested in.
- I created another nested list in the last part of the exercise, hoping to be able to extract information from several model objects using `broom`, however I could not get that to work...
- Also, I looked up the other activities on this assigment, and found all of them interesting, and complex... this is so far the most challenging homework for me.

### Additional resources

- To understand Robust Regressions, I read [this post](https://stats.idre.ucla.edu/r/dae/robust-regression/) from UCLA

- I also read the documentation for `lm` [Fitting linear models](https://www.rdocumentation.org/packages/stats/versions/3.4.1/topics/lm), and `lmrob` [MM-Type Estimators For Linear Regression](https://www.rdocumentation.org/packages/robustbase/versions/0.92-7/topics/lmrob) to understand how to extract specific information from these objects

- Plus the documentation for [Broom](https://github.com/tidyverse/broom)

- All the notes from previous lectures of [STAT545](http://stat545.com/block012_function-regress-lifeexp-on-year.html) were super useful!, also the notes from this year's lecture on [functions](https://github.com/derekcho/STAT-547M-Notes/blob/master/Supplementary_Notes.md) from Derek were useful to understand how to obtain multiple values from a function.