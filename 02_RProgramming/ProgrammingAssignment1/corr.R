corr <- function(directory,threshold=0) {
    output <- numeric()
    obsids <- complete(directory)[complete(directory)["nobs"]>threshold,"id"]
    if(length(obsids)>0) {
    for(i in 1:length(obsids)){
        iread <- read.csv(list.files(directory,full.names=T)[obsids[i]])
        importdata <- iread[complete.cases(iread),]
        output <- c(output,cor(importdata[2],importdata[3]))
    }
    output
    }
}