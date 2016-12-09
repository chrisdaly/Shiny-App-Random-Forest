fluidPage(
    theme = shinytheme("spacelab"), 
    br(),
    titlePanel("Sony ShinyApp"),
    hr(),
  
    fluidRow(
      column(3,
             h4("User input"),
             fileInput("user_file", "File input:"),
             helpText("Upload a CSV file with a header and one row of data."),
             downloadLink("downloadExample", "Sample input file")
             ),
      
      column(5,
             h4("Data preview"),
             tableOutput("user_data")
            ),
      
      column(4,
             # Predictions.
             h4("Model output"),
             
             tabsetPanel(
               tabPanel("Data", 
                        tableOutput('model_predictions'),
                        downloadButton('downloadPredictions', 'Download')),
               tabPanel("Plot",
                        plotlyOutput("plot"),
                        datatable('model_predictions', class = 'cell-border stripe')
                        )
             )

))
)

#,
#tabPanel("Testing DT table", 
#         datatable(head(iris), class = 'cell-border stripe'),
#         datatable('model_predictions', class = 'cell-border stripe')
#         
#)