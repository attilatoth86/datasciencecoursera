
plotngramfreq <- function(dataframe, title, xaxisname, yaxisname) {
    options(scipen=10000)
    ggplot(dataframe, aes(x=reorder(dataframe[,1], dataframe[,2]), y=dataframe[,2])) +
           geom_bar(stat = "identity") +  coord_flip() +
           xlab(xaxisname) + ylab(yaxisname) +
           labs(title = title)    
}
