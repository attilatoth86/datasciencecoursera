# Initialization



# Clear environment
rm(list=ls())
getwd()
setwd("/Users/ati/GitHub/datasciencecoursera/10_CapstoneProject/")
getwd()



# Load libraries

## String operations
library(stringi)
## Data manipulation
library(dplyr)
library(data.table)
## Graphs
library(ggplot2)
library(gridExtra)
## Text mining
library(quanteda)
## Export capabilities
library(knitr)
## Boost performance
library(parallel)



# Setup general variables

## Paths of files to be processed
filePathblog <- "final/en_US/en_US.blogs.txt"
filePathnews <- "final/en_US/en_US.news.txt"
filePathtwitter <- "final/en_US/en_US.twitter.txt"

## Set sample size
sampleSize <- 0.3333

# Read in files
fileblog <- file(filePathblog)
blg <- readLines(con = fileblog, n = -1, warn = FALSE, skipNul = TRUE)
close(fileblog)
rm(fileblog)

filenews <- file(filePathnews)
nws <- readLines(con = filenews, n = -1, warn = FALSE, skipNul = TRUE)
close(filenews)
rm(filenews)

filetwitter <- file(filePathtwitter)
twttr <- readLines(con = filetwitter, n = -1, warn = FALSE, skipNul = TRUE)
close(filetwitter)
rm(filetwitter)



# Sampling for faster execution
blg.sample <- blg[rbinom(n=length(blg), size=1, prob=sampleSize)==1]
nws.sample <- nws[rbinom(n=length(nws), size=1, prob=sampleSize)==1]
twttr.sample <- twttr[rbinom(n=length(twttr), size=1, prob=sampleSize)==1]

rm(blg,nws,twttr)



# Create corpus
sampleCorpus <- corpus(c(blg.sample,nws.sample,twttr.sample)) # using sampled texts
#totalCorpus <- corpus(c(blg,nws,twttr))

rm(blg.sample,nws.sample,twttr.sample)



# Create DFMs

dfm.1gram <- dfm(sampleCorpus, # !!replace with totalCorpus when using the entire dataset
                  ngrams=1,
                  toLower = TRUE,
                  removeNumbers = TRUE, 
                  removePunct = TRUE, 
                  removeSeparators = TRUE,
                  removeTwitter = TRUE,
                  language="english")

n1gramdf <- data.frame(ngram=names(colSums(dfm.1gram)),
                       n=1,
                       cnt=colSums(dfm.1gram),
                       prob=colSums(dfm.1gram)/sum(colSums(dfm.1gram)),
                       nminus1gram="",
                       row.names=NULL,
                       stringsAsFactors = FALSE)

rm(dfm.1gram)

dfm.2gram <- dfm(sampleCorpus, # !!replace with totalCorpus when using the entire dataset
                 ngrams=2,
                 toLower = TRUE,
                 removeNumbers = TRUE, 
                 removePunct = TRUE, 
                 removeSeparators = TRUE,
                 removeTwitter = TRUE,
                 language="english")

n2gramdf <- data.frame(ngram=names(colSums(dfm.2gram)),
                       n=2,
                       cnt=colSums(dfm.2gram),
                       row.names=NULL,
                       stringsAsFactors = FALSE)

rm(dfm.2gram)

n2gramdf <- n2gramdf %>%
                mutate(nminus1gram=sapply(strsplit(n2gramdf$ngram, split = "_"),"[[",1)) %>%
                left_join(n1gramdf, by=c("nminus1gram"="ngram")) %>%
                mutate(prob=cnt.x/cnt.y) %>%
                select(ngram, n=n.x, cnt=cnt.x, prob, nminus1gram)


dfm.3gram <- dfm(sampleCorpus, # !!replace with totalCorpus when using the entire dataset
                 ngrams=3,
                 toLower = TRUE,
                 removeNumbers = TRUE, 
                 removePunct = TRUE, 
                 removeSeparators = TRUE,
                 removeTwitter = TRUE,
                 language="english")

n3gramdf <- data.frame(ngram=names(colSums(dfm.3gram)),
                       n=3,
                       cnt=colSums(dfm.3gram),
                       row.names=NULL,
                       stringsAsFactors = FALSE)

rm(dfm.3gram)

n3gramdf <- n3gramdf %>%
                mutate(nminus1gram=paste(sapply(strsplit(n3gramdf$ngram, split = "_"),"[[",1),
                                         sapply(strsplit(n3gramdf$ngram, split = "_"),"[[",2),
                                         sep="_")
                       ) %>%
                left_join(n2gramdf, by=c("nminus1gram"="ngram")) %>%
                mutate(prob=cnt.x/cnt.y) %>%
                select(ngram, n=n.x, cnt=cnt.x, prob, nminus1gram)


dfm.4gram <- dfm(sampleCorpus, # !!replace with totalCorpus when using the entire dataset
                 ngrams=4,
                 toLower = TRUE,
                 removeNumbers = TRUE, 
                 removePunct = TRUE, 
                 removeSeparators = TRUE,
                 removeTwitter = TRUE,
                 language="english")

n4gramdf <- data.frame(ngram=names(colSums(dfm.4gram)),
                       n=4,
                       cnt=colSums(dfm.4gram),
                       row.names=NULL,
                       stringsAsFactors = FALSE)

rm(dfm.4gram)

n4gramdf <- n4gramdf %>%
    mutate(nminus1gram=paste(sapply(strsplit(n4gramdf$ngram, split = "_"),"[[",1),
                             sapply(strsplit(n4gramdf$ngram, split = "_"),"[[",2),
                             sapply(strsplit(n4gramdf$ngram, split = "_"),"[[",3),
                             sep="_")
    ) %>%
    left_join(n3gramdf, by=c("nminus1gram"="ngram")) %>%
    mutate(prob=cnt.x/cnt.y) %>%
    select(ngram, n=n.x, cnt=cnt.x, prob, nminus1gram)

ngramdf <- rbind(n1gramdf,
                 n2gramdf,
                 n3gramdf,
                 n4gramdf)

rm(n1gramdf,n2gramdf,n3gramdf,n4gramdf)

searchExpr <- function(expr) {
    n <- length(tokenize(expr)[[1]])
    if (n>3) {expr <- paste(strsplit(expr, split = " ")[[1]][n-2],
                            strsplit(expr, split = " ")[[1]][n-1],
                            strsplit(expr, split = " ")[[1]][n],
                            sep=" ")}
    expr <- tolower(expr)
    expr <- gsub(" ","_",expr)
    nlookup <- min(n+1,4)

    head(
        ngramdf %>% 
            filter(n==nlookup & nminus1gram==expr) %>%  
            arrange(desc(prob)) %>%
            mutate(prediction=sapply(strsplit(ngram, split = "_"),"[[",nlookup)),
        10)
    
}


    searchExpr("i am a")





# 
# 
# # Create 4-grams
# dfm.4gram <- dfm(sampleCorpus, # !!replace with totalCorpus when using the entire dataset
#                   ngrams=4,
#                   toLower = TRUE,
#                   removeNumbers = TRUE, 
#                   removePunct = TRUE, 
#                   removeSeparators = TRUE,
#                   removeTwitter = TRUE,
#                   language="english")
# 
# #dfm.4gram
# #topfeatures(dfm.4gram)
# #head(dfm.4gram)
# #summary(dfm.4gram)
# #str(dfm.4gram)
# freq.ngram <- data.frame(ngram=names(colSums(dfm.4gram)),
#                          n=4,
#                          cnt=colSums(dfm.4gram),
#                          freq=colSums(dfm.4gram)/sum(colSums(dfm.4gram)),
#                          row.names=NULL,
#                          stringsAsFactors = FALSE)
# rm(dfm.4gram)
# # Create 3-grams
# dfm.3gram <- dfm(sampleCorpus, # !!replace with totalCorpus when using the entire dataset
#                  ngrams=3,
#                  toLower = TRUE,
#                  removeNumbers = TRUE, 
#                  removePunct = TRUE, 
#                  removeSeparators = TRUE,
#                  removeTwitter = TRUE,
#                  language="english")
# freq.ngram <- rbind(freq.ngram,
#                     data.frame(ngram=names(colSums(dfm.3gram)),
#                                n=3,
#                                cnt=colSums(dfm.3gram),
#                                freq=colSums(dfm.3gram)/sum(colSums(dfm.3gram)),
#                                row.names=NULL,
#                                stringsAsFactors = FALSE)
#                     )
# 
# rm(dfm.3gram)
# 
# # Create 2-grams
# dfm.2gram <- dfm(sampleCorpus, # !!replace with totalCorpus when using the entire dataset
#                  ngrams=2,
#                  toLower = TRUE,
#                  removeNumbers = TRUE, 
#                  removePunct = TRUE, 
#                  removeSeparators = TRUE,
#                  removeTwitter = TRUE,
#                  language="english")
# 
# freq.ngram <- rbind(freq.ngram,
#                     data.frame(ngram=names(colSums(dfm.2gram)),
#                                n=2,
#                                cnt=colSums(dfm.2gram),
#                                freq=colSums(dfm.2gram)/sum(colSums(dfm.2gram)),
#                                row.names=NULL,
#                                stringsAsFactors = FALSE)
#                     )
# 
# rm(dfm.2gram)
# 
# str(freq.ngram)
# 



################################################################################
### APPENDIX ###################################################################
################################################################################

# Sampling
TextSampling <- function(inputfile, outputfile, samplesize){
    if(samplesize>0 && samplesize<=1) {
        con <- file(inputfile,open="r") # create file connection
        lines <- readLines(con) # read in lines
        length(lines) # number of lines
        
        selLines <- rbinom(n = length(lines), size=1, prob = samplesize) # generate sample
        output <- lines[which(selLines==1)] # selected rows for output
        
        writeLines(output, con = file(outputfile,open="w"), sep = "\n", useBytes = FALSE)
        
        close(con)    
    } 
    else {
        "Invalid sample size! Please provide a number between 0 and 1."
    }
}