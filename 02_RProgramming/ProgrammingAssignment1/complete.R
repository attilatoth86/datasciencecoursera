complete <- function(directory, id=1:332) {
    df <- data.frame()
    for (i in 1:length(id)) {
        importeddata <- read.csv(list.files(directory,full.names=T)[id[i]])
        df <- rbind(df,
                    data.frame(id= id[i], nobs=nrow(importeddata[complete.cases(importeddata),])))
    }
    df
}
