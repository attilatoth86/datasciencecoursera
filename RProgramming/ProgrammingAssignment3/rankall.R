rankall <- function(outcome, num="best") {
    ## Read outcome data
    RawData <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"
                        ,colClasses="character")
    RawData <- RawData[,c(2,7,11,17,23)]
    RawData[,3] <- suppressWarnings(as.numeric(RawData[,3]))
    RawData[,4] <- suppressWarnings(as.numeric(RawData[,4]))
    RawData[,5] <- suppressWarnings(as.numeric(RawData[,5]))

    ## Check that argument values are valid
    # Creation of outcome - column mapping vector
    OutcomeValueMapping <- c(3,4,5)
    names(OutcomeValueMapping) <- c("heart attack","heart failure","pneumonia")
    # If "outcome" argument does not correspond to any item of vector, function fails
    if(is.na(OutcomeValueMapping[outcome])) stop("invalid outcome")
    
    # Creation of unique list of states
    ListOfStates <- as.character(unique(RawData[,2]))
    ListOfStates <- ListOfStates[order(ListOfStates)]
    output <- data.frame()
    for(i in seq_along(ListOfStates)) {
        state <- ListOfStates[i]
        StateMeasure <- RawData[RawData[,2]==state,c(1,OutcomeValueMapping[outcome])]
        StMeaCC <- StateMeasure[complete.cases(StateMeasure[,2]),]
        FinalOrder <- StMeaCC[order(StMeaCC[,2],StMeaCC[,1]),]
        if(num=="best") {SelRow <- 1}
        else if(num=="worst") {SelRow <- nrow(FinalOrder)}
        else {SelRow <- as.numeric(num)}
        FinalDF <- cbind(FinalOrder[SelRow,1],state)
        rownames(FinalDF) <- state
        output <- rbind(output,FinalDF)
    }
    colnames(output) <- c("hospital","state")
    output
}