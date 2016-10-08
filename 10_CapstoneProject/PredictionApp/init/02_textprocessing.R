
source("init/f_libraries.R")

inputTextObj <- readline(prompt="Enter the file name (a sampled text object) to be processed:")

load(inputTextObj, textObjEnv <- new.env())

corpus <- corpus(textObjEnv[["textSample"]])

dfm1gram <- dfm(corpus,
                toLower = TRUE,
                removeNumbers = TRUE, 
                removePunct = TRUE, 
                removeSeparators = TRUE,
                removeTwitter = FALSE,
                language="english")

dfm2gram <- dfm(corpus,
                ngrams = 2,
                toLower = TRUE,
                removeNumbers = TRUE, 
                removePunct = TRUE, 
                removeSeparators = TRUE,
                removeTwitter = FALSE,
                language="english")

dfm3gram <- dfm(corpus,
                ngrams = 3,
                toLower = TRUE,
                removeNumbers = TRUE, 
                removePunct = TRUE, 
                removeSeparators = TRUE,
                removeTwitter = FALSE,
                language="english")

save(corpus,
     dfm1gram,
     dfm2gram,
     dfm3gram,
     file=paste0("02_",substr(inputTextObj,4,nchar(inputTextObj)-16),"CorpusObject.RData"), 
     compress = "gzip")

rm(list=ls())
