library(stringi)
library(stringr)
library(tm)
library(dplyr)

textInp2modelInp <- function(inputString){

    stringSplit <- unlist(strsplit(gsub("\\s+"," ",tolower(removeNumbers(removePunctuation(str_trim(inputString))))),split = " "))
    stringLength <- length(stringSplit)
    if(stringLength<2){
        adjString <- stringSplit
        adjString1 <- stringSplit
        adjString2 <- stringSplit
        adjStringLength <- 1
    } else {
        adjString <- paste(stringSplit[stringLength-1],stringSplit[stringLength],sep = "_")
        adjString1 <- stringSplit[stringLength-1]
        adjString2 <- stringSplit[stringLength]
        adjStringLength <- 2
    }
#    adjString <- "his_wide"
#    adjString2 <- "wide"
    
    if(nrow(ngramdf[ngramdf$expr==adjString,])==0){
        if(nrow(ngramdf[ngramdf$expr==adjString2,])==0){
            maxFreq <- max(ngramdf[ngramdf$n==1,"freq"])
            ngramdf[ngramdf$freq==maxFreq,"expr"]
        }
        else{
            head(ngramdf[ngramdf$expr.j==adjString2,]%>% dplyr::arrange(desc(freq)) %>% 
                     select(expr, n, freq)) %>%
                     mutate(lastword=sapply(strsplit(expr, split = "_"),"[[",2)) %>%
                     left_join(ngramdf, by=c("lastword"="expr")) %>% 
                dplyr::arrange(desc(freq.x),desc(freq.y)) %>% select(lastword)
        }
    }
    else{
        head(ngramdf[ngramdf$expr.j==adjString,] %>% dplyr::arrange(desc(freq)) %>% 
                 select(expr, n, freq))%>% 
                 mutate(lastword=sapply(strsplit(expr, split = "_"),"[[",adjStringLength+1)) %>%
                 left_join(ngramdf, by=c("lastword"="expr")) %>% 
            dplyr::arrange(desc(freq.x),desc(freq.y)) %>% select(lastword)
        
    }
}


