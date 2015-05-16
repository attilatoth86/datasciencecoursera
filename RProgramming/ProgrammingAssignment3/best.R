best <- function(state, outcome) {
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
    # If "state" argument does not correspond to any item of vector, function fails
    if(length(ListOfStates[ListOfStates==state])==0) stop("invalid state")
    
    ## Return hospital name in given state with the lowest 30-day death rate
    StateMeasure <- RawData[RawData[,2]==state,c(1,OutcomeValueMapping[outcome])]
    StMeaCC <- StateMeasure[complete.cases(StateMeasure[,2]),]
    StMeaCC[StMeaCC[,2]==min(StMeaCC[,2]),1]
}