library(plotly)
library(shinythemes)

makeIndexCol <- function(df){
  df$ID<-seq.int(nrow(df))
  df
}
