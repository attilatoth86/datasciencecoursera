
source("f_libraries.R")

fileSizeblog <- file.size("final/en_US/en_US.blogs.txt")/1024^2
fileSizenews <- file.size("final/en_US/en_US.news.txt")/1024^2
fileSizetwitter <- file.size("final/en_US/en_US.twitter.txt")/1024^2

fileblog <- file("final/en_US/en_US.blogs.txt","r")
filenews <- file("final/en_US/en_US.news.txt","r")
filetwitter <- file("final/en_US/en_US.twitter.txt","r")

blogLines <- readLines(fileblog)
newsLines <- readLines(filenews)
twitterLines <- readLines(filetwitter)

blogLines.length <- length(blogLines)
newsLines.length <- length(newsLines)
twitterLines.length <- length(twitterLines)

blogLines.wc <- stri_count_words(blogLines)
newsLines.wc <- stri_count_words(newsLines)
twitterLines.wc <- stri_count_words(twitterLines)

blogLines.chars <- nchar(blogLines)
newsLines.chars <- nchar(newsLines)
twitterLines.chars <- nchar(twitterLines)

g.blogLines.char <- qplot(x=blogLines.chars[-order(blogLines.chars,decreasing = TRUE)[1:1000]], 
                     geom = "histogram",
                     main = "blogs.txt",
                     ylab="", xlab="",
                     binwidth=1)
g.newsLines.char <- qplot(x=newsLines.chars[-order(newsLines.chars,decreasing = TRUE)[1:1000]], 
                     geom = "histogram",
                     main = "news.txt",
                     ylab="", xlab="",
                     binwidth=1)
g.twitterLines.char <- qplot(x=twitterLines.chars, 
                        geom = "histogram",
                        main = "twitter.txt",
                        ylab="", xlab="",
                        binwidth=1)


g.blogLines.wc <- qplot(x=blogLines.wc[-order(blogLines.wc,decreasing = TRUE)[1:1000]], 
                        geom = "histogram",
                        main = "blogs.txt",
                        ylab="", xlab="",
                        binwidth=10)
g.newsLines.wc <- qplot(x=newsLines.wc[-order(newsLines.wc,decreasing = TRUE)[1:1000]], 
                        geom = "histogram",
                        main = "news.txt",
                        ylab="",xlab="",
                        binwidth=10)
g.twitterLines.wc <- qplot(x=twitterLines.wc, 
                          geom = "histogram",
                          main = "twitter.txt",
                          ylab="",xlab="",
                          binwidth=1)


save(fileSizeblog, 
     fileSizenews, 
     fileSizetwitter, 
     fileblog, 
     filenews, 
     filetwitter,
     blogLines.length,
     newsLines.length,
     twitterLines.length,
     blogLines.wc,
     newsLines.wc,
     twitterLines.wc,
     blogLines.chars,
     newsLines.chars,
     twitterLines.chars,
     g.blogLines.char,
     g.newsLines.char,
     g.twitterLines.char,
     g.blogLines.wc,
     g.newsLines.wc,
     g.twitterLines.wc,
     file="desc.RData")


