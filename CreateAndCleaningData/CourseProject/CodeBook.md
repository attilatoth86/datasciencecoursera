# CodeBook for Course Project of Getting and Cleaning Data course at [coursera.org](https://www.coursera.org/course/getdata)
#### author: attila.toth86

This document serves as a detailed description of where data has been obtained from, what it actually contains and what my script does with it.

## Description of data

The processed data represent data collected from the accelerometers from the Samsung Galaxy S smartphone during an experiment.

Detailed information is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### Snippets from readme file of original dataset

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

> For each record it is provided:

> - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

> Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

The ultimate source of processed data is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

### Output of processing
During processing, original dataset has been stripped in order to contain only measures that have something to do with mean & standard deviation. Afterwards, this stripped dataset was grouped by subject & activity and calculated average for selected measures.

## Description of variables
|Column Id|Column Name|Variable Description|
| ------------- |-------------| -----|
|1|Subject|An identifier of the subject who carried out the experiment.|
|2|ActivityName|Activities performed during the experiment|
|3|fBodyAccmeanX|Averaged mean of frequency domain body acceleration signals measured by accelerometer on axis X|
|4|fBodyAccmeanY|Averaged mean of frequency domain body acceleration signals measured by accelerometer on axis Y|
|5|fBodyAccmeanZ|Averaged mean of frequency domain body acceleration signals measured by accelerometer on axis Z|
|6|fBodyAccstdX|Averaged standard deviation offrequency domain body acceleration signals measured by accelerometer on axis X|
|7|fBodyAccstdY|Averaged standard deviation offrequency domain body acceleration signals measured by accelerometer on axis Y|
|8|fBodyAccstdZ|Averaged standard deviation offrequency domain body acceleration signals measured by accelerometer on axis Z|
|9|fBodyAccJerkmeanX|Averaged mean of frequency domain body acceleration Jerk signals measured by accelerometer on axis X|
|10|fBodyAccJerkmeanY|Averaged mean of frequency domain body acceleration Jerk signals measured by accelerometer on axis Y|
|11|fBodyAccJerkmeanZ|Averaged mean of frequency domain body acceleration Jerk signals measured by accelerometer on axis Z|
|12|fBodyAccJerkstdX|Averaged standard deviation offrequency domain body acceleration Jerk signals measured by accelerometer on axis X|
|13|fBodyAccJerkstdY|Averaged standard deviation offrequency domain body acceleration Jerk signals measured by accelerometer on axis Y|
|14|fBodyAccJerkstdZ|Averaged standard deviation offrequency domain body acceleration Jerk signals measured by accelerometer on axis Z|
|15|fBodyAccMagmean|Averaged mean of frequency domain body acceleration signal magnitudes measured by accelerometer |
|16|fBodyAccMagstd|Averaged standard deviation offrequency domain body acceleration signal magnitudes measured by accelerometer |
|17|fBodyBodyAccJerkMagmean|Averaged mean of frequency domain body acceleration Jerk signal magnitudes measured by accelerometer |
|18|fBodyBodyAccJerkMagstd|Averaged standard deviation offrequency domain body acceleration Jerk signal magnitudes measured by accelerometer |
|19|fBodyBodyGyroJerkMagmean|Averaged mean of frequency domain body Jerk signal magnitudes measured by gyroscope |
|20|fBodyBodyGyroJerkMagstd|Averaged standard deviation offrequency domain body Jerk signal magnitudes measured by gyroscope |
|21|fBodyBodyGyroMagmean|Averaged mean of frequency domain body signal magnitudes measured by gyroscope |
|22|fBodyBodyGyroMagstd|Averaged standard deviation offrequency domain body signal magnitudes measured by gyroscope |
|23|fBodyGyromeanX|Averaged mean of frequency domain body signals measured by gyroscope on axis X|
|24|fBodyGyromeanY|Averaged mean of frequency domain body signals measured by gyroscope on axis Y|
|25|fBodyGyromeanZ|Averaged mean of frequency domain body signals measured by gyroscope on axis Z|
|26|fBodyGyrostdX|Averaged standard deviation offrequency domain body signals measured by gyroscope on axis X|
|27|fBodyGyrostdY|Averaged standard deviation offrequency domain body signals measured by gyroscope on axis Y|
|28|fBodyGyrostdZ|Averaged standard deviation offrequency domain body signals measured by gyroscope on axis Z|
|29|tBodyAccmeanX|Averaged mean of time domain body acceleration signals measured by accelerometer on axis X|
|30|tBodyAccmeanY|Averaged mean of time domain body acceleration signals measured by accelerometer on axis Y|
|31|tBodyAccmeanZ|Averaged mean of time domain body acceleration signals measured by accelerometer on axis Z|
|32|tBodyAccstdX|Averaged standard deviation oftime domain body acceleration signals measured by accelerometer on axis X|
|33|tBodyAccstdY|Averaged standard deviation oftime domain body acceleration signals measured by accelerometer on axis Y|
|34|tBodyAccstdZ|Averaged standard deviation oftime domain body acceleration signals measured by accelerometer on axis Z|
|35|tBodyAccJerkmeanX|Averaged mean of time domain body acceleration Jerk signals measured by accelerometer on axis X|
|36|tBodyAccJerkmeanY|Averaged mean of time domain body acceleration Jerk signals measured by accelerometer on axis Y|
|37|tBodyAccJerkmeanZ|Averaged mean of time domain body acceleration Jerk signals measured by accelerometer on axis Z|
|38|tBodyAccJerkstdX|Averaged standard deviation oftime domain body acceleration Jerk signals measured by accelerometer on axis X|
|39|tBodyAccJerkstdY|Averaged standard deviation oftime domain body acceleration Jerk signals measured by accelerometer on axis Y|
|40|tBodyAccJerkstdZ|Averaged standard deviation oftime domain body acceleration Jerk signals measured by accelerometer on axis Z|
|41|tBodyAccJerkMagmean|Averaged mean of time domain body acceleration Jerk signal magnitudes measured by accelerometer |
|42|tBodyAccJerkMagstd|Averaged standard deviation oftime domain body acceleration Jerk signal magnitudes measured by accelerometer |
|43|tBodyAccMagmean|Averaged mean of time domain body acceleration signal magnitudes measured by accelerometer |
|44|tBodyAccMagstd|Averaged standard deviation oftime domain body acceleration signal magnitudes measured by accelerometer |
|45|tBodyGyromeanX|Averaged mean of time domain body signals measured by gyroscope on axis X|
|46|tBodyGyromeanY|Averaged mean of time domain body acceleration signals by gyroscope on axis Y|
|47|tBodyGyromeanZ|Averaged mean of time domain body acceleration signals by gyroscope on axis Z|
|48|tBodyGyrostdX|Averaged standard deviation oftime domain body acceleration signals by gyroscope on axis X|
|49|tBodyGyrostdY|Averaged standard deviation oftime domain body acceleration signals by gyroscope on axis Y|
|50|tBodyGyrostdZ|Averaged standard deviation oftime domain body acceleration signals by gyroscope on axis Z|
|51|tBodyGyroJerkmeanX|Averaged mean of time domain body acceleration Jerk signals by gyroscope on axis X|
|52|tBodyGyroJerkmeanY|Averaged mean of time domain body acceleration Jerk signals by gyroscope on axis Y|
|53|tBodyGyroJerkmeanZ|Averaged mean of time domain body acceleration Jerk signals by gyroscope on axis Z|
|54|tBodyGyroJerkstdX|Averaged standard deviation oftime domain body acceleration Jerk signals by gyroscope on axis X|
|55|tBodyGyroJerkstdY|Averaged standard deviation oftime domain body acceleration Jerk signals by gyroscope on axis Y|
|56|tBodyGyroJerkstdZ|Averaged standard deviation oftime domain body acceleration Jerk signals by gyroscope on axis Z|
|57|tBodyGyroJerkMagmean|Averaged mean of time domain body acceleration Jerk signal magnitudes by gyroscope |
|58|tBodyGyroJerkMagstd|Averaged standard deviation oftime domain body acceleration Jerk signal magnitudes by gyroscope |
|59|tBodyGyroMagmean|Averaged mean of time domain body acceleration signal magnitudes by gyroscope |
|60|tBodyGyroMagstd|Averaged standard deviation oftime domain body acceleration signal magnitudes by gyroscope |
|61|tGravityAccmeanX|Averaged mean of time domain gravity acceleration signals by accelerometer on axis X|
|62|tGravityAccmeanY|Averaged mean of time domain gravity acceleration signals by accelerometer on axis Y|
|63|tGravityAccmeanZ|Averaged mean of time domain gravity acceleration signals by accelerometer on axis Z|
|64|tGravityAccstdX|Averaged standard deviation oftime domain gravity acceleration signals by accelerometer on axis X|
|65|tGravityAccstdY|Averaged standard deviation oftime domain gravity acceleration signals by accelerometer on axis Y|
|66|tGravityAccstdZ|Averaged standard deviation oftime domain gravity acceleration signals by accelerometer on axis Z|
|67|tGravityAccMagmean|Averaged mean of time domain gravity acceleration signal magnitudes by accelerometer |
|68|tGravityAccMagstd|Averaged standard deviation oftime domain gravity acceleration signal magnitudes by accelerometer |


## Description of transformations
The following transformations take place on sourced data.

After downloading,
```{r}
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                destfile = "data.zip",
                method="curl")
```
source file will be placed in the local working directory in an archive named 'data.zip' and will be eventually unzipped.
```{r}
unzip("data.zip")
```

Script reads the necessary files in the memory (X_test.txt, y_test.txt, subject_test.txt, X_train.txt, y_train.txt, subject_train.txt, features.txt, activity_labels.txt files are being used):
```{r}
        x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
        y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
        test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
        x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
        y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
        train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
        features <- read.table("UCI HAR Dataset/features.txt")
        activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
```

Created a dataframe from features that contains only relevant measures:
```{r}
        features_needed <- arrange(
                            features[features[c(grep("mean\\(\\)",tolower(features[,2])),grep("std\\(\\)",tolower(features[,2]))),1],], 
                            V2)
```
Only measures containing 'mean()' or 'std()' character strings will be later processed!

For further usage it creates a single vector of column indexes:
```{r}
collistid <- as.numeric(features_needed[,1])
```

Cleaning column names to comply with R standards (removing dash, comma, parantheses):
```{r}
        collistnames <- gsub(",","",
                             gsub("-","",
                                  gsub("\\)","",
                                       gsub("\\(","",
                                            as.character(features_needed[,2])
                                           )
                                      )
                                 )
                            )
```

Selected only relevant columns from original train & test datasets (using previously defined collistid numeric vector):
```{r}
        x_test_f <- x_test[,collistid]
        x_train_f <- x_train[,collistid]
```

Labeled dataframes with descriptive names:
```{r}
        colnames(activity_labels) <- c("ActivityId","ActivityName")
        colnames(features) <- c("FeatureId","FeatureName")
        colnames(x_test_f) <- collistnames
        colnames(x_train_f) <- collistnames
        colnames(y_test) <- "ActivityId"
        colnames(y_train) <- "ActivityId"
        colnames(test_subject) <- "Subject"
        colnames(train_subject) <- "Subject"
```
For test & train datasets column names come from prevously cleaned column name vector ('collistnames').

Bound subject & activity codes (y) to test & train datasets:
```{r}
        c_test <- cbind(x_test_f,y_test,test_subject)
        c_train <- cbind(x_train_f,y_train,train_subject)
```

Merged test & train data into a single data frame:
```{r}
c_tt <- rbind(c_test, c_train)
```

Translated activity identifiers to descriptive names:
```{r}
c_merged <- invisible(join(c_tt,activity_labels,by = "ActivityId",type = "left"))
```

Rearranged column order to have subject identifier & activity description on the very left side (parallelly left out activity identifier from final dataset):
```{r}
final_dataset <- select(c_merged,Subject,ActivityName,fBodyAccmeanX:tGravityAccMagstd)
```

In order to calculate average of each variable for each activity and each subject, firstly grouped the final dataset by activity & subject,
```{r}
gb <- group_by(final_dataset,Subject,ActivityName)
```

then applied mean function on each measure.
```{r}
sum_final_dataset <- summarise_each(gb,funs(mean))
```

Content of this ```sum_final_dataset``` dataframe is being extracted.
