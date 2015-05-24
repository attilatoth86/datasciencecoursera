rankall <- function(outcome, num="best") {
    ## Read outcome data
    RawData <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv"
                        ,colClasses="character")
    # Subset only required columns
    RawData <- RawData[,c(2,7,11,17,23)]
    # Convert measure columns into numeric format // turned of warnings in case of NA introduction
    RawData[,3] <- suppressWarnings(as.numeric(RawData[,3]))
    RawData[,4] <- suppressWarnings(as.numeric(RawData[,4]))
    RawData[,5] <- suppressWarnings(as.numeric(RawData[,5]))

    ## Check that argument values are valid
    # Creation of outcome - column mapping vector
    OutcomeValueMapping <- c(3,4,5) # column identifiers
    names(OutcomeValueMapping) <- c("heart attack","heart failure","pneumonia")  # assign column names
    # If "outcome" argument does not correspond to any item of vector, function fails
    if(is.na(OutcomeValueMapping[outcome])) stop("invalid outcome")
    
    # Creation of unique list of states
    ListOfStates <- as.character(unique(RawData[,2]))
    # Realign list of states in alphabetical order
    ListOfStates <- ListOfStates[order(ListOfStates)]
    # Created an empty data frame
    output <- data.frame()
    ## Loop that fills up output data frame with valuation results
    for(i in seq_along(ListOfStates)) {
    	# Selecting i-th state
        state <- ListOfStates[i]
        # Subset loaded data by i-th state & selected measure
        StateMeasure <- RawData[RawData[,2]==state,c(1,OutcomeValueMapping[outcome])]
        # Clear out NAs
        StMeaCC <- StateMeasure[complete.cases(StateMeasure[,2]),]
        # Ordering
        FinalOrder <- StMeaCC[order(StMeaCC[,2],StMeaCC[,1]),]
        # Translation & usage of "num" attribute
        if(num=="best") {SelRow <- 1}
        else if(num=="worst") {SelRow <- nrow(FinalOrder)}
        else {SelRow <- as.numeric(num)}
        # Bind i-th state name to calculated result
        FinalDF <- cbind(FinalOrder[SelRow,1],state)
        # Assign proper rowname
        rownames(FinalDF) <- state
        # Bind final object to "output" data frame
        output <- rbind(output,FinalDF)
    }
    # Set up proper column name
    colnames(output) <- c("hospital","state")
    # Print
    output
}