pollutantmean <- function(directory, pollutant, id=1:332) {
    importeddata <- data.frame()
    for (i in 1:length(id)) {
        importeddata <- rbind(importeddata,
                              read.csv(list.files(directory,full.names=T)[id[i]]))    
    } 
    selcolumn <- importeddata[pollutant]
    mean(selcolumn[,1],na.rm=T)
}