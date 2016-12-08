library(shinythemes)

fluidPage(
  navbarPage(
    theme = shinytheme("spacelab"), "Sony - RShiny",
  
    fluidRow(
      column(3,
             h3("User data"),
             fileInput("user_file", "File input:")
             ),
      column(5,
             h3("User data preview"),
             tableOutput("user_data")
            ),
      column(4,
             # Predictions.
             h3("Model predictions"),
             tableOutput('model_predictions'),
             downloadButton('downloadData', 'Download')
            )
    )
))