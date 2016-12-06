library(shiny)

fluidPage(
  titlePanel("Sony Models"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
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
      tableOutput('contents'),
      tableOutput('table')
      
    )
  )
)
# Show a plot of the generated distribution
#mainPanel(
#  plotOutput("distPlot"),
  
  