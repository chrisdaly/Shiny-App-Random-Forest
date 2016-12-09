source("scenario_planner.R")
library(plotly)

server = function(input, output) {
  data1 <- reactive({
    
    # Gives error message if no file uploaded.
    validate(
      need(input$user_file, "Upload a file!")
    )
    
    # Return null if file is empty.
    inFile <- input$user_file
    if (is.null(inFile)){return(NULL)}
    #if (dim(inFile)){return(NULL)}
    

    
    # Only read in data when user explicity does so.
    isolate({ 
      my_data <- read.csv(inFile$datapath, header=TRUE)#, stringsAsFactors=FALSE)
    
      validate(
        need((dim(my_data)[1] == 1), label = "One row only")
      )
    })
    
    my_data
  })
  
  get_predictions <- reactive({
    # Fetch the data.
    df <- data1()
    
    # Calc predictions from business code.
    df_pred <- predictions(df)
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
  output$model_predictions <- renderTable({
    
    df_pred <- get_predictions()
    
    # Calc total and bind to bottom of df.
    tot = data.frame(model = "TOTAL", prediction = sum(df_pred$prediction))
    df_pred <- rbind( df_pred[1:5,], tot)
    
    # Format the numbers for output.
    df_pred$prediction <- sapply(df_pred$prediction, FUN=function(x) prettyNum(x, big.mark=","))
    df_pred
    
    }, align='lr')  
  
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

  # renderPlotly() also understands ggplot2 objects!
  output$plot <- renderPlotly({
    
    df_pred <- get_predictions()
    
    plot_ly(df_pred,
      x = ~model,
      y = ~prediction,
      name = "SF Zoo",
      type = "bar"
    )
  })
}

# deployApp(appName="Sony-ShinyApp")
# https://inspirationinformation.shinyapps.io/SpotifyDiscography/ 