library(shiny)

fluidPage(
  titlePanel("Sony Models"),
  
  
  sidebarLayout(
    sidebarPanel(
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
      
      h2("Your input"),
      tableOutput('user_data'),
      
      # Predictions
      h2("Model predictions"),
      tableOutput('model_predictions'),
      
      radioButtons("filetype", "File type:",
                   choices = c("csv", "tsv")),
      downloadButton('downloadData', 'Download')
      
      
      
    )
  )
)
# Show a plot of the generated distribution
#mainPanel(
#  plotOutput("distPlot"),
  
  