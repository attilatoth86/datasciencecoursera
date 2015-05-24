rankhospital <- function(state, outcome, num="best") {
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
    names(OutcomeValueMapping) <- c("heart attack","heart failure","pneumonia") # assign column names
    # If "outcome" argument does not correspond to any item of vector, function fails
    if(is.na(OutcomeValueMapping[outcome])) stop("invalid outcome")
    
    # Creation of unique list of states
    ListOfStates <- as.character(unique(RawData[,2]))
    # If "state" argument does not correspond to any item of vector, function fails
    if(length(ListOfStates[ListOfStates==state])==0) stop("invalid state")
    
    # Subset loaded data - only rows belong to selected state & selected measure to be proceeded    
    StateMeasure <- RawData[RawData[,2]==state,c(1,OutcomeValueMapping[outcome])]
    # Clear out NAs
    StMeaCC <- StateMeasure[complete.cases(StateMeasure[,2]),]
    # Ordering
    FinalOrder <- StMeaCC[order(StMeaCC[,2],StMeaCC[,1]),]
    # Decoding & using "num" function attribute
    if(num=="best") {SelRow <- 1}
    else if(num=="worst") {SelRow <- nrow(FinalOrder)}
    else {SelRow <- as.numeric(num)}
    # Selecting "num"-th item from ordered list
    print(FinalOrder[SelRow,1])
}