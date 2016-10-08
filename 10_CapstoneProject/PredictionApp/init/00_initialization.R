
# Paths of files to be processed
filePathblog <- "../final/en_US/en_US.blogs.txt"
filePathnews <- "../final/en_US/en_US.news.txt"
filePathtwitter <- "../final/en_US/en_US.twitter.txt"

# Read in files
fileblog <- file(filePathblog, "r")
blg <- readLines(con = fileblog, n = -1, warn = FALSE, skipNul = TRUE)
close(fileblog)
rm(fileblog)

filenews <- file(filePathnews, "r")
nws <- readLines(con = filenews, n = -1, warn = FALSE, skipNul = TRUE)
close(filenews)
rm(filenews)

filetwitter <- file(filePathtwitter, "r")
twttr <- readLines(con = filetwitter, n = -1, warn = FALSE, skipNul = TRUE)
close(filetwitter)
rm(filetwitter)

# Housekeeping
rm(filePathblog);rm(filePathnews);rm(filePathtwitter)

save(blg, nws, twttr, file="00_textObject.RData", compress = "gzip")