library(shiny)
source("scenario_planner.R")

function(input, output) {
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    

    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)

    
    #output$table <- renderTable({
    #  predictions
      
    #})
    
  })
  
  output$table <- renderTable({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
    
    df = read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
    
    predictions1(df)

  })
}

