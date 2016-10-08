#Q1
fileblog <- file("final/en_US/en_US.blogs.txt","r")
file.size("final/en_US/en_US.blogs.txt")/1024^2

#Q2
filetwitter <- file("final/en_US/en_US.twitter.txt","r")
lines <- readLines(filetwitter)
length(lines)

#Q3
filenews <- file("final/en_US/en_US.news.txt","r")
blogl <- readLines(fileblog)
twitterl <- readLines(filetwitter)
newsl <- readLines(filenews)

max(c(nchar(blogl),nchar(twitterl),nchar(newsl)))
max(nchar(blogl))
max(nchar(newsl))

#Q4
length(grep("love",twitterl))/length(grep("hate",twitterl))

#Q5
twitterl[grep("biostats",twitterl)]

#Q6
twitterl[grep("A computer once beat me at chess, but it was no match for me at kickboxing",twitterl)]
