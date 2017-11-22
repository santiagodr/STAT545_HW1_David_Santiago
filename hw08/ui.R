# ui file for hw08 Shiny app based on BC Liquor store exercise

# define all parameters to be displayed in the app
ui <- fluidPage(theme = shinytheme("yeti"),
  # Application title
  titlePanel("BC Liquor store prices - (STAT547 HW08 SantiagoD version)"),
  
  sidebarPanel(img(src = "bcls_logo.gif", width = "100%"),
              br(), br(),
              "Please use the options below to help you find the right choice!",
              br(), br(),
              sliderInput("priceIn", "Price", min = 0, max = 300, 
                           value = c(10,40), pre = "CAD "),
              br(), br(),
              uiOutput("countryselector"),
              
              checkboxGroupInput("typeIn", "Product type(s)",
                            choices = c("BEER", "SPIRITS", "WINE"),
                            selected = c("WINE")),
  
              conditionalPanel(
              condition = "input.typeIn == 'WINE'",
              sliderInput("sweetInput", "Sweetness", min = 0,
                          max = 10, value = 2))
  ),
  mainPanel(
            downloadButton("download", "Download results table"),
            br(), br(),
            plotOutput("hist_content"),
            br(), br(),
            DT::dataTableOutput("results")
            )
)