# [HW09](hhttp://stat545.com/hw09_package.html) Building your own R package

### Files

- Here is the link to my version of the [powers](https://github.com/santiagodr/powers) package on github, and here is the [vignette](https://htmlpreview.github.io/?https://github.com/santiagodr/powers/blob/master/inst/doc/using_powers.html)

### Process

In class we developed a basic package called `powers`, I modified most elements on this package as following:
- modified `square())` and `cube()` functions, and separate them in R files
- defined and exported a new function `boxcox()`
- defined an option to remove NA's to each function, and give a default
- used assertions on each function to specify use of numerical data
- included three unit tests for each function using `testthat`
- The package pass `check()` without errors
- updated documentation on each step and file
- pushed package to github

### Report
Although I didn't modify a lot the initial package created in class, the few additions I did still took me a lot of time and patience. The incorporation of a new function for Box-Cox transformation wasn't easy, since I wanted to include assertions for the type of inputs and it didn't work smoothly. Also, writing the unit tests was complicated, but more exploration of the different options in the package helped me to define good tests, and fix them until I didn't get errors in the `check()`. 
Building packages is a very useful skill to have, but still a hard for me to understand!

### Additional resources
- This [link](https://tgmstat.wordpress.com/2013/06/26/devtools-and-testthat-r-packages/) was useful to understand different options for`testthat`
- Also, I read several examples to understand the box-cox transformations (including wikipedia), but didn't save any of those links.