setwd("/Users/ati/GitHub/datasciencecoursera/CreateAndCleaningData/CourseProject")

library(dplyr, plyr)

rm(list = ls())
if(file.exists("data.zip")==TRUE) file.remove("data.zip")
if(file.exists("tidy_dataset.txt")==TRUE) file.remove("tidy_dataset.txt")
if(file.exists("UCI HAR Dataset")==TRUE) unlink("UCI HAR Dataset",recursive = TRUE)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = "data.zip",
              method="curl")
unzip("data.zip")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
collistid <- as.numeric(features[c(grep("mean",tolower(features[,2])),grep("std",tolower(features[,2]))),1])
collistnames <- gsub(",","",
                     gsub("-","",
                          gsub("\\)","",
                               gsub("\\(","",
                                    as.character(
                                        features[
                                            c(
                                                grep("mean",tolower(features[,2])),
                                                grep("std",tolower(features[,2]))
                                              ),
                                            2]
                                                )
                                    )
                               )
                          )
                     )

x_test_f <- x_test[,collistid]
x_train_f <- x_train[,collistid]

colnames(activity_labels) <- c("ActivityId","ActivityName")
colnames(features) <- c("FeatureId","FeatureName")
colnames(x_test_f) <- collistnames
colnames(x_train_f) <- collistnames
colnames(y_test) <- "ActivityId"
colnames(y_train) <- "ActivityId"
colnames(test_subject) <- "Subject"
colnames(train_subject) <- "Subject"

c_test <- cbind(x_test_f,y_test,test_subject)
c_train <- cbind(x_train_f,y_train,train_subject)

c_tt <- rbind(c_test, c_train)
c_merged <- join(c_tt,activity_labels)
final_dataset <- select(c_merged,Subject,ActivityName,tBodyAccmeanX:fBodyBodyGyroJerkMagstd)

gb <- group_by(final_dataset,Subject,ActivityName)
sum_final_dataset <- summarise_each(gb,funs(mean))
write.table(sum_final_dataset,file = "tidy_dataset.txt", row.names = FALSE)