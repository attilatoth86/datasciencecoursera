# Readme for Course Project of Getting and Cleaning Data course at [coursera.org](https://www.coursera.org/course/getdata)
#### author: attila.toth86

This document serves as detailed description of how scripts should be used in order to perform the requested analyses on the elected dataset. For detailed code snippets please refer to [CodeBook.md](https://github.com/attilatoth86/datasciencecoursera/blob/master/CreateAndCleaningData/CourseProject/CodeBook.md).

## Step I - Read in the run_analysis.R script

This script contains the body of analysis. While reading in to R, by default it cleans up the environments (remove pre-loaded variables, functions, etc) and loads ```dplyr``` & ```pylr``` libraries as they will be used in later steps. 

**Note: Running script requires ```dplyr``` & ```plyr``` packages installed on your local computer!**
```{r}
rm(list=ls())
library(dplyr, plyr)
```

In the course of script loading, two functions will be passed to running environment: ```dl_file()``` that obtains source data and ```run_analysis()``` that actually performs data transformations.

## Step II - Obtaining source data

To gather dataset appointed in the excersise, one should run ```dl_file()``` function that checks if source file is missing from working directory, if so, script will download and unzip it.

*Note: Skipping this step is totally safe as ```run_analysis()``` function has a built in check to warn you if source file missing. In this case one receives a descriptive error message with clear guidance what to do going forward.*

## Step III - Running analysis

By calling ```run_analysis()``` function the entire stack of transformation will run and result a tidy_dataset.txt as an output to the working directory.
Missing source files will cause a handled exception and will throw a descriptive warning message how to proceed.
In case of tidy_dataset.txt is already existing, process will replace it with the new outcome.
