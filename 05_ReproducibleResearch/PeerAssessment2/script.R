if(!file.exists("StormData.csv.bz2")) {
    download.file(url = "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2",
                  destfile = "StormData.csv.bz2", method = "curl")    
}

if(!exists("stormdata")){
    stormdata <- read.csv("StormData.csv.bz2")    
}

str(stormdata)

summary(stormdata$EVTYPE)
summary(stormdata$FATALITIES) 
summary(stormdata$INJURIES)
summary(stormdata$PROPDMG)
summary(stormdata$CROPDMG)
summary(stormdata$PROPDMGEXP)
summary(stormdata$CROPDMGEXP)

sdata_subset <- data.frame(
                            BGN_DATE = as.Date(as.character(stormdata$BGN_DATE),"%m/%d/%Y"),
                            END_DATE = as.Date(as.character(stormdata$END_DATE),"%m/%d/%Y"),
                            EVTYPE = stormdata$EVTYPE,
                            FATALITIES = stormdata$FATALITIES,
                            INJURIES = stormdata$INJURIES,
                            PROPDMG = stormdata$PROPDMG,
                            PROPDMGEXP = toupper(as.character(stormdata$PROPDMGEXP)),
                            CROPDMG = stormdata$CROPDMG,
                            CROPDMGEXP = toupper(as.character(stormdata$CROPDMGEXP)))

str(sdata_subset)

sdata_subset2 <- sdata_subset[!(sdata_subset$FATALITIES==0 & 
                                    sdata_subset$INJURIES==0 & 
                                    sdata_subset$PROPDMG==0 & 
                                    sdata_subset$CROPDMG==0),]

summary(sdata_subset2)
str(sdata_subset2)
unique(sdata_subset2$PROPDMGEXP)
unique(sdata_subset2$CROPDMGEXP)

library(dplyr)

## define decode function
decode <- function(x, search, replace, default = NULL) {
    
    # build a nested ifelse function by recursion
    decode.fun <- function(search, replace, default = NULL)
        if (length(search) == 0L) {
            function(x) if (is.null(default)) x else rep(default, length(x))
        } else {
            function(x) ifelse(x == search[1L], replace[1L],
                               decode.fun(tail(search,  -1L),
                                          tail(replace, -1L),
                                          default)(x))
        }
    
    return(decode.fun(search, replace, default)(x))
}
### decode(basket, search  = c("banana", "orange"),
###        replace = c("apple", "pineapple"),
###        default = "fig")

#####
sdata_clean <- sdata_subset2 %>%
                mutate(PROPDMGUSD = decode(PROPDMGEXP,
                                            c("K","M","B","H"),
                                            c(1000,1000000,1000000000,100),
                                            1)*PROPDMG,
                       CROPDMGUSD = decode(CROPDMGEXP,
                                            c("K","M","B","H"),
                                            c(1000,1000000,1000000000,100),
                                            1)*CROPDMG
                    ) %>%
                select(EVTYPE, FATALITIES, INJURIES, PROPDMGUSD, CROPDMGUSD)

summary(sdata_clean)

