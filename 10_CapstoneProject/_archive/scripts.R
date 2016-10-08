getwd()
setwd("GitHub/datasciencecoursera/10_CapstoneProject/")

###########################################################################
##### Quiz 1 start ###########
# Question 1
file.info("final/en_US/en_US.blogs.txt")["size"]/1024^2

# Question 2
con <- file("final/en_US/en_US.twitter.txt",open="r")
lines <- readLines(con)
length(lines)
close(con)

rm(list=ls())

# Question 3
maxLineDf <- data.frame(file=c("blog","news","twitter"), maxLineLen=c(0,0,0))

con1 <- file("final/en_US/en_US.blogs.txt",open="r")
lines <- readLines(con1)
l <- length(lines)
for (i in 1:l)
{
    line <- lines[i]
    if (nchar(line)>maxLineDf[maxLineDf["file"]=="blog",2]) 
        {
        maxLineDf[maxLineDf["file"]=="blog",2] <- nchar(line)
        }
}
close(con1)

con2 <- file("final/en_US/en_US.news.txt",open="r")
lines <- readLines(con2)
l <- length(lines)
for (i in 1:l)
{
    line <- lines[i]
    if (nchar(line)>maxLineDf[maxLineDf["file"]=="news",2]) 
    {
        maxLineDf[maxLineDf["file"]=="news",2] <- nchar(line)
    }
}
close(con2)

con3 <- file("final/en_US/en_US.twitter.txt",open="r")
lines <- readLines(con3)
l <- length(lines)
for (i in 1:l)
{
    line <- lines[i]
    if (nchar(line)>maxLineDf[maxLineDf["file"]=="twitter",2]) 
    {
        maxLineDf[maxLineDf["file"]=="twitter",2] <- nchar(line)
    }
}
close(con3)
maxLineDf

rm(list=ls())

# Question 4
con4 <- file("final/en_US/en_US.twitter.txt",open="r")
lines <- readLines(con4)
l <- length(lines)
cntlove <- 0
cnthate <- 0
for (i in 1:l)
{
    if(length(grep("love",tolower(lines[i])))==0) {
        cntlove <- cntlove + 0
    }
    else {cntlove <- cntlove + 1}
    if(length(grep("hate",tolower(lines[i])))==0) {
        cnthate <- cnthate + 0
    }
    else {cnthate <- cnthate + 1}
}
cntlove
cnthate
cntlove/cnthate
close(con4)

rm(list=ls())

# Question 5

con5 <- file("final/en_US/en_US.twitter.txt",open="r")
lines <- readLines(con5)
l <- length(lines)
for (i in 1:l)
{
    if(length(grep("biostats",tolower(lines[i])))!=0){
        linenum <- i
    }
}
lines[linenum]

close(con5)

rm(list=ls())

# Question 6

con6 <- file("final/en_US/en_US.twitter.txt",open="r")
lines <- readLines(con6)
l <- length(lines)
rowidx <- vector(mode="numeric", length=0)
for (i in 1:l)
{
    if(length(grep("A computer once beat me at chess, but it was no match for me at kickboxing",lines[i]))!=0){
        rowidx <- c(rowidx,i)
    }
}
lines[rowidx]
close(con6)

rm(list=ls())

##### Quiz 1 end   ###########
###########################################################################
###########################################################################

dir.create("GitHub/datasciencecoursera/10_CapstoneProject/final/en_US/sample")
outputfile <- "GitHub/datasciencecoursera/10_CapstoneProject/final/en_US/sample/sample.txt"
file.create(outputfile)

filepath.blogs <- "GitHub/datasciencecoursera/10_CapstoneProject/final/en_US/en_US.blogs.txt"
filepath.news <- "GitHub/datasciencecoursera/10_CapstoneProject/final/en_US/en_US.news.txt"
filepath.twitter <- "GitHub/datasciencecoursera/10_CapstoneProject/final/en_US/en_US.twitter.txt"

TextSampling <- function(inputfile, outputfile){
    con <- file(inputfile,open="r") # create file connection
    lines <- readLines(con) # read in lines
    length(lines) # number of lines
    
    selLines <- rbinom(n = length(lines), size=1, prob = 0.1) # generate 10% sample
    output <- lines[which(selLines==1)] # selected rows for output

    writeLines(output, con = file(outputfile,open="w"), sep = "\n", useBytes = FALSE)
    
    close(con)
}
TextSampling(filepath.blogs, outputfile)
TextSampling(filepath.news, outputfile)
TextSampling(filepath.twitter, outputfile)
