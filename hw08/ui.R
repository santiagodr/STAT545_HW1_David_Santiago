# ui file for hw08 Shiny app based on BC Liquor store exercise

# define all parameters to be displayed in the app
ui <- fluidPage(theme = shinytheme("yeti"),
  # Application title
  titlePanel("BC Liquor store prices - (STAT547 HW08 SantiagoD version)"),
  
  sidebarPanel(img(src = "bcls_logo.gif", width = "100%"),
               br(), br(),
               "Please use the options below to help you find the right choice!",
               br(), br(),
               sliderInput("priceIn", "Price",
                           min = 0, max = 300, 
                           value = c(10,20), pre = "CAD "),
               
               radioButtons("typeIn", "Product type(s)",
                            choices = c("BEER", "SPIRITS", "WINE"),
                            selected = c("BEER"))
               ),
               #checkboxInput("filterPrice", "Filter by price", FALSE),
  
  mainPanel(plotOutput("hist_content"),
            br(), br(),
            tableOutput("table_head"))
)