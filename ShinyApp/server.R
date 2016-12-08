source("scenario_planner.R")

server = function(input, output) {
  data1 <- reactive({
    
    # Gives error message if no file uploaded.
    validate(
      need(input$user_file, "Upload a file!")
    )
    
    # Return null if file is empty.
    inFile <- input$user_file
    if (is.null(inFile)){return(NULL)}
    
    # Only read in data when user explicity does so.
    isolate({ 
      my_data <- read.csv(inFile$datapath, header=TRUE)
    })
  })
  
  get_predictions <- reactive({
    # Fetch the data.
    df <- data1()
    
    # Calc predictions from business code.
    df_pred <- predictions(df)
    
    # Format the numbers for output.
    df_pred$prediction <- sapply(df_pred$prediction, FUN=function(x) prettyNum(x, big.mark=","))
    df_pred
  })
  
  # Display user data.
  output$user_data <- renderTable({
    # Fetch the data.
    df <- data1()
    
    # Copy the header into an extra row.
    df[2, ] <- names(df)

    # Tranpose the df.
    df <- t(df)
    
    # Swap column order.
    df <- df[, c(2, 1)]
    
    # Rename cols.
    colnames(df) <- c('parameter','value')
    
    # Coerce to df type.
    df <- as.data.frame(df)
    
    df
  }) 
  
  # Display predictions.
  output$model_predictions <- renderTable({get_predictions()}, align='lr')  
  
  
  # Predictions download handler.
  output$downloadPredictions <- downloadHandler(
    # Set filename.
    filename = function() { 
      'predictions.csv'
    },
    
    # Write file.
    content = function(file) {
      write.csv(get_predictions(), file, row.names=FALSE)
    }
  )
  
  # Sample download handler.
  output$downloadExample <- downloadHandler(
    # Set filename.
    filename = function() { 
      'sample_data.csv'
    },
    
    # Write file.
    content = function(file) {
      write.csv(read.csv('input data.csv'), file, row.names=FALSE)
    }
  )
}