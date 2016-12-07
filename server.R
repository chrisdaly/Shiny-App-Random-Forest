library(shiny)
source("scenario_planner.R")

function(input, output) {
  
  output$user_data <- renderTable({
    inFile <- input$user_file
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
  })
  
  output$model_predictions <- renderTable({
    
    inFile <- input$user_file
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
    
    df = read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                  quote=input$quote)
    
    predictions1(df)
    
  })
}
