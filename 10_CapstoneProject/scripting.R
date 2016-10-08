load("train_textObject.RData")
corpus <- corpus(train)
rm(train)
dfm1gram <- dfm(corpus,
                toLower = TRUE,
                removeNumbers = TRUE, 
                removePunct = TRUE, 
                removeSeparators = TRUE,
                removeTwitter = FALSE,
                language="english")
rm(corpus)
dim(dfm1gram)
unigramdf <- data.frame(expr=names(colSums(dfm1gram)),
                        freq=colSums(dfm1gram),
                        row.names=NULL,
                        stringsAsFactors = FALSE)

write.csv(unigramdf,"train_1gramfreq.csv",row.names=FALSE)
rm(list=ls())

###

load("train_textObject.RData")
corpus <- corpus(train)
rm(train)

dfm2gram <- dfm(corpus,
                ngrams=2,
                toLower = TRUE,
                removeNumbers = TRUE, 
                removePunct = TRUE, 
                removeSeparators = TRUE,
                removeTwitter = FALSE,
                language="english")
rm(corpus)
dim(dfm2gram)
bigramdf <- data.frame(expr=names(colSums(dfm2gram)),
                        freq=colSums(dfm2gram),
                        row.names=NULL,
                        stringsAsFactors = FALSE)

write.csv(bigramdf,"train_2gramfreq.csv",row.names=FALSE)