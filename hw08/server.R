# Server file for hw08 Shiny app based on BC Liquor store exercise

# load packages
library(shiny)
library(tidyverse)
library(shinythemes)
library(DT)

# specify all the input/outputs
server <- function(input, output) {
  bcl_data <- read_csv("bcl-data.csv")
  filtered <- reactive({
    bcl_data %>% 
    filter(Price >= input$priceIn[1],
           Price <= input$priceIn[2],
           Type == input$typeIn,
           Country == input$countryInput,
           Sweetness == input$sweetInput)
  })
  
  # customize plot results
  output$hist_content <- renderPlot({
    filtered() %>% 
      ggplot() + aes(Alcohol_Content, fill = Type) + #includes fill to have different colors
      geom_histogram(colour = "black") +
      labs(title = "% Alcohol for BC liquor store products", #add more features to plot
           x = "Alcohol content (%)",
           y = "Count") +
      theme_bw(18)
  })
  
  # modify table to interactive table
  output$results <- DT::renderDataTable({
    filtered()
  })
  
  # include country selector option
  output$countryselector <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl_data$Country)),
                selected = "CANADA")
  })
  
  # include an option for downloading data
  output$download <- downloadHandler( 
    filename = function() { 
      "bcliquorstore_results"
    },
    content = function(file) {
      write.csv(filtered(), file)
  })
}