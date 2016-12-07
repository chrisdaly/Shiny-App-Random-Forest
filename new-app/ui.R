ui = fluidPage(
  
  sidebarPanel(
    titlePanel("RShiny"),
    fileInput('user_file', 'Upload CSV File',
              accept=c('text/csv', 
                       'text/comma-separated-values,text/plain', 
                       '.csv')),
    
    tags$hr(),
    checkboxInput('header', 'Header', TRUE),
    radioButtons('sep', 'Separator',
                 c(Comma=',',
                   Semicolon=';',
                   Tab='\t'),
                 ','),
    
    radioButtons('quote', 'Quote',
                 c(None='',
                   'Double Quote'='"',
                   'Single Quote'="'"),
                 '"')
    ),
  
  mainPanel(
    
    # User data.
    h2("Input data preview"),
    tableOutput("user_data"),
            
    # Predictions.
    h2("Model predictions"),
    tableOutput('model_predictions'),
    
    downloadButton('downloadData', 'Download')
    )
)