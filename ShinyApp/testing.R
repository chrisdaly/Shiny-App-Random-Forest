source("scenario_planner.R")


df <- read.csv('input data.csv', header = TRUE)
#df <- read.csv('new_input2.csv', header = TRUE)#, stringsAsFactors=FALSE)

df[2, ] <- colnames(df)
#df <-df[,c(2,1)]

df_T <- t(df)
df_T <- df_T[, c(2, 1)]
colnames(df_T) <- c('parameter','value')
df_T <- as.data.frame(df_T)



###################
df_pred <- predictions(df)

df_pred


datatable(df_pred, class = 'cell-border stripe')

makeIndexCol <- function(df){
  df$ID<-seq.int(nrow(df))
  df
}