
# Load libraries
library(quanteda)
library(doParallel); CPU <- parallel::detectCores(); registerDoParallel(makeCluster(CPU))
library(stringi)
library(knitr)
library(ggplot2)
library(gridExtra)
library(plyr)
library(dplyr)
library(tidyr)
rm(list=ls())