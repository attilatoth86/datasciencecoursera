
# Sourcing sample size
enterSampleSize <- function() {
    input <- readline(prompt="Enter a sample size:")
    
    while(is.na(suppressWarnings(as.numeric(input)))==TRUE){
        input <- readline(prompt="Invalid number. Enter a sample size:")
    }
    while(as.numeric(input)<=0 | as.numeric(input)>1){
        input <- readline(prompt="Enter a sample size (between 0 and 1):")
    }
    
    as.numeric(input)
    
}



# Sampling function
samplingText <- function(textObj, sampleSize) {
    selectedRows <- rbinom(n=length(textObj), size=1, prob=sampleSize)
    textObj[selectedRows==1]
}



# Extract sample from text object
extractTextSample <- function(sampleSize) {
    textinput <- readline(prompt="Enter the filename of text object input:")
    load(textinput, textObjEnv <- new.env())
    txt <- as.character()
    for(obj in ls(textObjEnv)){
        txt <- c(txt,samplingText(textObjEnv[[obj]], sampleSize))    
    }
    txt
}