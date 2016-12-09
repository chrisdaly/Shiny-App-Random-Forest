source("scenario_planner.R")


#df <- read.csv('input data.csv', header = TRUE)
df <- read.csv('new_input2.csv', header = TRUE)#, stringsAsFactors=FALSE)

df[2, ] <- colnames(df)
#df <-df[,c(2,1)]

df_T <- t(df)
df_T <- df_T[, c(2, 1)]
colnames(df_T) <- c('parameter','value')
df_T <- as.data.frame(df_T)



###################
df_pred <- predictions(df)

df_pred

df_pred$prediction <- sapply(df_pred$prediction, FUN=function(x) prettyNum(x, big.mark=","))
df_


barplot(df_pred$prediction, main="Predicted Sales Distribution", names.arg=(df_pred$model),
        xlab="Model")
