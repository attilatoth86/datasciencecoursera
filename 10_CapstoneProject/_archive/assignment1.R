# Environment cleaning
rm(list=ls())

# Load libraries
library(tm)
library(SnowballC)
library(ggplot2)

# Init
corpus.path <- "GitHub/datasciencecoursera/10_CapstoneProject/final/en_US/sample/"

# Load in
corpus.raw <- VCorpus(DirSource(corpus.path), 
                      readerControl = list(reader=readPlain))
str(corpus.raw)
# Data cleaning
corpus.clean <- tm_map(corpus.raw, removeWords, stopwords("english"))
corpus.clean <- tm_map(corpus.clean, removeNumbers) 
corpus.clean <- tm_map(corpus.clean, removePunctuation)
corpus.clean <- tm_map(corpus.clean, stripWhitespace)
corpus.clean <- tm_map(corpus.clean, tolower)
corpus.clean <- tm_map(corpus.clean, stemDocument)

corpus.clean.final <- tm_map(corpus.clean, PlainTextDocument)

# DTM

dtm <- DocumentTermMatrix(corpus.clean.final)
dtm
inspect(dtm[1,1:20])

freq <- colSums(as.matrix(dtm))
length(freq)
ord <- order(freq)

freq
freq[head(ord)]
freq[tail(ord,25)]

wf <- data.frame(word=names(freq), freq=freq)


p <- ggplot(subset(wf, freq>500), aes(word, freq))    
p <- p + geom_bar(stat="identity")   
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))   
p   
