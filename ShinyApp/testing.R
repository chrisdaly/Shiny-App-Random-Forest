df <- read.csv('input data.csv', header = TRUE)

df[2, ] <- names(df)
#df <-df[,c(2,1)]

df <- t(df)
df <- df[, c(2, 1)]
colnames(df) <- c('parameter','value')
df <- as.data.frame(df)



###################
df_pred <- predictions(df)

df_pred

df_pred$prediction <- sapply(df_pred$prediction, FUN=function(x) prettyNum(x, big.mark=","))
df_