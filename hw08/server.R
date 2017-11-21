# Server file for hw08 Shiny app based on BC Liquor store exercise

# load packages
library(shiny)
library(tidyverse)
library(shinythemes)

# specify all the input/outputs
server <- function(input, output) {
  bcl_data <- read_csv("bcl-data.csv")
  filtered <- reactive({
    bcl_data %>% 
    filter(Price >= input$priceIn[1],
           Price <= input$priceIn[2],
           Type == input$typeIn)
  })
  
  output$hist_content <- renderPlot({
  filtered() %>% 
    ggplot() + aes(Alcohol_Content, fill = Type) +
    geom_histogram(colour = "black") +
    theme_bw()
  })
  output$table_head <- renderTable({
    filtered() %>% 
      head()
  })
}