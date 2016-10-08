
source("init/f_libraries.R")

inputCorpusObj <- readline(prompt="Enter the file name (a sampled corpus object) to be processed:")

load(inputCorpusObj, corpusObjEnv <- new.env())

ngramdf <- data.frame(expr=character(),
                      n=integer(),
                      freq=integer(),
                      expr.j=character(),
                      row.names=NULL
)

ngramdf <- rbind(ngramdf,
                  data.frame(expr=names(colSums(corpusObjEnv$dfm1gram)),
                             n=1,
                             freq=colSums(corpusObjEnv$dfm1gram),
                             expr.j="",
                             row.names=NULL,
                             stringsAsFactors = FALSE),
                  data.frame(expr=names(colSums(corpusObjEnv$dfm2gram)),
                             n=2,
                             freq=colSums(corpusObjEnv$dfm2gram),
                             expr.j=sapply(strsplit(names(colSums(corpusObjEnv$dfm2gram)), split = "_"),"[[",1),
                             row.names=NULL,
                             stringsAsFactors = FALSE),
                  data.frame(expr=names(colSums(corpusObjEnv$dfm3gram)),
                             n=3,
                             freq=colSums(corpusObjEnv$dfm3gram),
                             expr.j=paste(
                                 sapply(strsplit(names(colSums(corpusObjEnv$dfm3gram)), split = "_"),"[[",1),
                                 sapply(strsplit(names(colSums(corpusObjEnv$dfm3gram)), split = "_"),"[[",2),
                                 sep="_"),
                             row.names=NULL,
                             stringsAsFactors = FALSE)
                )

# ngrammod <- rbind(
#                 ngramdf %>% filter(n == 1) 
#                         %>% mutate(prob=freq/sum(colSums(corpusObjEnv$dfm1gram))),
#                 ngramdf %>% filter(n %in% c(2,3)) 
#                         %>% left_join(ngramdf,by=c("expr.j"="expr"))
#                         %>% mutate(prob=freq.x/freq.y)
#                         %>% select(expr, n=n.x, freq=freq.x, expr.j, prob)    
#                 )

save(ngramdf,
     file=paste0("03_",substr(inputCorpusObj,4,nchar(inputCorpusObj)-18),"NGramObject.RData"), 
     compress = "gzip")

rm(inputCorpusObj); rm(corpusObjEnv);





