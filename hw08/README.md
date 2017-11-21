# [HW08](http://stat545.com/hw08_shiny.html) Building Shiny apps

### Files


### Process
For this assignment I decided to add some features and improve the BC liquor store prices app that we started in class. 

### Functionality

### Features we developed in class

- Included a title using `titlePanel`
- Included a side bar panel that allows user to select a range of prices using `sliderInput` and a button option to allow user to select among alcohol types using `radioButtons`
- Included a main panel with a histogram and a table that gives the user the result of the selection, we did it by using `plotOutput`, and `tableOutput`.
- Included an image in the main panel by using `img(src = )`

### Additional features

- from the base features we added, I modified the title, side bar text, and graph options 
- I added an image of the BC Liquor Store logo to the top of the sidebar Panel
- I added a theme to my Shiny app using `shinythemes`


### Resources

- The [Shiny Themes](https://rstudio.github.io/shinythemes/) was useful to include a specific theme in my Shiny app, it was very clear and the `shinythemes::themeSelector()` option was very good to explore all the options easily.