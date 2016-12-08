library(randomForest)


predictions <- function(inputs) {
  # Read the model metadata
  models = read.csv('model_details.csv', as.is=TRUE)
  
  # Set up empty data frame to store the predictions
  predictions <- data.frame()
  
  # Get the input data
  my_data.ds <- inputs
  my_data.ds$genre_num = as.factor(my_data.ds$genre_num)
  my_data.ds$score_mpaa = as.factor(my_data.ds$score_mpaa)
  
  # Fix levels, so they match training data
  levels(my_data.ds$genre_num) <- c(1,4,5,6,8,9,11)
  levels(my_data.ds$score_mpaa) <- c(1,2,3,4)
  levels(my_data.ds$sales_label) <- c("blockbuster", "high", "low", "mid")
  levels(my_data.ds$film_appeal_overindex_quadrant_dvd_m1) <- c(">25", "F", "F<25", "F>25", "M", "M>25", "mixed")
  
  for (active_model in models$id) {
    
    # Load the model
    model_details = models[models$id==active_model,]
    
    load(model_details$rda_file)
    my_rf = model_details$forest_name
    
    # Run the prediction and append it to dataframe "predictions"
    result = data.frame(
      model = active_model,
      prediction = round(exp(predict(get(my_rf), newdata = my_data.ds))/100)*100
    )
    predictions = rbind(predictions, result)
    
  }
  predictions
}
