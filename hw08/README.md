# [HW08](http://stat545.com/hw08_shiny.html) Building Shiny apps

### Files

- Here is the final product, a Shiny app for the BC liquor store products, version SantiagoD
- If needed, you can check the `server.R` code here and `ui.R` code here

### Process
For this assignment I decided to add some features and improve the BC liquor store prices app that we started in class. 

### Functionality
This shiny app allows the user to explore liquor products from the BC Liquor Store based on different options, such as Type of liquor, range of prices, country, and level of sweetness (only for wines). The user can also export the data as a csv file.

### Features we developed in class

- Included a title using `titlePanel`
- Included a side bar panel that allows user to select a range of prices using `sliderInput` and a button option to allow user to select among alcohol types using `radioButtons`
- Included a main panel with a histogram and a table that gives the user the result of the selection, we did it by using `plotOutput`, and `tableOutput`.
- Included an image in the main panel by using `img(src = )`

### Additional features

- From the base features we added, I modified the title, side bar text, and graph options, and included the country selector option. 
- I added an image of the BC Liquor Store logo to the top of the sidebar Panel
- I added a theme to my Shiny app using `shinythemes`
- I modified the simple results table, to an interactive table using the `DT` package
- I modified the `radioButtons` to `checkboxGroupInput` option, so that user can select several types of product at once
- I included the option to download the filtered data as a csv file using `downloadHandler()` in the server file, and `downloadButton()` in the ui file
- Finally, I added an option to select a level of sweetness only when the option "WINE" is selected in the product types. I created a new input `sweetness` and used `conditionalPanel` to display the info of that input in a slider.


### Resources

- The [Shiny Themes](https://rstudio.github.io/shinythemes/) was useful to include a specific theme in my Shiny app, it was very clear and the `shinythemes::themeSelector()` option was very good to explore all the options easily.
- I also read most of the documentation for each function to try it and understand what was it doing, and explored the original code for the BC Liquor Store developed by Dean Attali [link](https://github.com/daattali/shiny-server/blob/master/bcl/app.R).

### Final thoughts...

I think this homework was very useful to understand the basic of Shiny apps, however it wasn't always straightforward for me to create new inputs, or to call information from the server to the ui file. I looked at different packages such as `shinyjs`, or `leaflet`, and thought about ways to incorporate those functions on this homework, but didn't have enough knowledge and time at this point, to make something functional... I'm still very happy to be able to include the "sweetness" option in the app.