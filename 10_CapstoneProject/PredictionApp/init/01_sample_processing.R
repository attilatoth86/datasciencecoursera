
source("init/f_libraries.R")
source("init/f_sampling.R")

sampleSize <- enterSampleSize()

textSample <- extractTextSample(sampleSize)



save(textSample, file=paste0("01_sampled",sampleSize,"TextObject.RData"), compress = "gzip")



rm(list=ls())