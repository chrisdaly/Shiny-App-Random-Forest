library(shinythemes)

fluidPage(
  navbarPage(
    theme = shinytheme("spacelab"), "Sony - RShiny",
  
    fluidRow(
      column(3,
             h4("User data"),
             fileInput("user_file", "File input:"),
             helpText("Upload a CSV file with a header and one row of data.")
             ),
      column(5,
             h4("User data preview"),
             tableOutput("user_data")
            ),
      column(4,
             # Predictions.
             h4("Model predictions"),
             tableOutput('model_predictions'),
             downloadButton('downloadData', 'Download')
            )
    )
))