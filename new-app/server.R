source("scenario_planner.R")
library(dplyr)


server = function(input, output) {
  
  data1 <- reactive({
    validate(
      need(input$user_file, "Upload a file!")
    )
    
    inFile <- input$user_file
    if (is.null(inFile)){return(NULL)}
    
    isolate({ 
      my_data <- read.csv(inFile$datapath, header=FALSE)
    })
    
  })
  
  get_predictions <- reactive({
    #if(input$load_button == 0){return()}
    
    df <- data1()
    
    names(df) <- as.matrix(df[1, ])
    df <- df[-1, ]
    df[] <- lapply(df, function(x) type.convert(as.character(x)))
    df
    
    if(is.null(df)){return()}
    
    predictions(df)
  })
  
  # User data preview.
  output$user_data <- renderTable({
    df <- data1()
    t(df)
  }) 
  
  output$table <- renderDataTable({df}, 
                                  options = list(scrollX = TRUE))
  
  # Model predictions.
  output$model_predictions <- renderTable({get_predictions()})  
  
  output$downloadData <- downloadHandler(
    filename = function() { 
      'predictions.csv'
    },
    content = function(file) {
      write.csv(get_predictions(), file, row.names=FALSE)
    }
  )
}




# Reactivity
# http://shiny.rstudio.com/gallery/reactivity.html

# Sliders, graphs
# http://shiny.rstudio.com/gallery/retirement-simulation.html

# Select columns
#http://stackoverflow.com/questions/36784906/shiny-allowling-users-to-choose-which-columns-to-display