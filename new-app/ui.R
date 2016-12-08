library(shinythemes)

fluidPage(
  navbarPage(
    theme = shinytheme("spacelab"), "RShiny",
    
    tabPanel("Home",
             sidebarPanel(
               fileInput("user_file", "File input:"),
               tags$hr()
             ),
             
             mainPanel(
               tabsetPanel(
                 tabPanel("Data",
                          h3("Input data preview"),
                          tableOutput("user_data"),
                          
                          
                          
                          # Predictions.
                          h3("Model predictions"),
                          tableOutput('model_predictions'),
                          
                          downloadButton('downloadData', 'Download')
                 ),
                 tabPanel("Test",
                          h4("Table"),
                          tableOutput("table"),
                          h4("Verbatim text output"),
                          verbatimTextOutput("txtout"),
                          h1("Header 1"),
                          h2("Header 2"),
                          h3("Header 3"),
                          h4("Header 4"),
                          h5("Header 5"),
                          tags$code('SALES_PHY')),
                 tabPanel("Tab 3")
               )
             )
    ),
    tabPanel("Codebook"),
    tabPanel("About")
  )
)