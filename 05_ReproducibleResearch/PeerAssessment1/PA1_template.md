# Reproducible Research: Peer Assessment 1

This document is created for Peer Assessment 1 in Reproducible Research course on coursera.org.

## Loading and preprocessing the data
Assuming the file to be processed is in the working directory the following code
will unzip & load the source data into a data frame called *raw_data* for further analyses.


```r
unzip(zipfile = "activity.zip")
raw_data <- read.csv(file = "activity.csv")
```

To gain a better understanding of the data, I shooted some summary functions:

```r
str(raw_data)
```

```
## 'data.frame':	17568 obs. of  3 variables:
##  $ steps   : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ date    : Factor w/ 61 levels "2012-10-01","2012-10-02",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
```

```r
summary(raw_data)
```

```
##      steps                date          interval     
##  Min.   :  0.00   2012-10-01:  288   Min.   :   0.0  
##  1st Qu.:  0.00   2012-10-02:  288   1st Qu.: 588.8  
##  Median :  0.00   2012-10-03:  288   Median :1177.5  
##  Mean   : 37.38   2012-10-04:  288   Mean   :1177.5  
##  3rd Qu.: 12.00   2012-10-05:  288   3rd Qu.:1766.2  
##  Max.   :806.00   2012-10-06:  288   Max.   :2355.0  
##  NA's   :2304     (Other)   :15840
```

## Mean total number of steps taken per day
This part of the assignment, I ignored the missing values in the dataset.

```r
raw_data_nona <- raw_data[!is.na(raw_data$steps),]
```

That eliminated **2304** rows from the original dataset.

To prepare a histogram of the total number of steps taken each day I used *dplyr*
package to sum total number of steps for each day included in the observed period.

```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
tot_steps <- raw_data_nona %>% 
             group_by(date) %>% 
             summarise(total_steps = sum(steps))

hist(tot_steps$total_steps, main="", xlab="Total steps per day")
```

![](PA1_template_files/figure-html/unnamed-chunk-5-1.png) 

Histogram shows that our population is close to normal distribution.

Additional descriptive statistic measures:

 - Mean: **1.0766189\times 10^{4}**
 - Median: **10765**

## Average daily activity pattern

To discover activity pattern I calculated a mean figure for each 5-minute interval across the entire observation period and placed the result on a line plot.

```r
avg_steps_intval <- raw_data_nona %>%
                    group_by(interval) %>%
                    summarise(avg_steps = mean(steps))

plot(x = avg_steps_intval$interval, y = avg_steps_intval$avg_steps, type="l", ylab="Average steps in the given interval", xlab="Measured intervals")
```

![](PA1_template_files/figure-html/unnamed-chunk-6-1.png) 

This shows us that the following 5-minute interval contains the maximum number of steps on average: **835**

## Inputing missing values

Total number of rows with missing values in the dataset: **2304**

I chose a strategy of filling in all of the missing values that consists of replacing *'NA'* to the mean of that certain time interval. This cleared dataset went into *clear_data* dataframe.

Created a new dataset that is equal to the original dataset but with the missing data filled in.


```r
col_replaced_NA  <- with(
                        left_join(raw_data,
                                  avg_steps_intval,
                                  by="interval"
                                  ), 
                        ifelse(is.na(steps)==TRUE, 
                               avg_steps, 
                               steps
                               )
                        )

clear_data  <- data_frame(steps = col_replaced_NA, 
                          date = raw_data$date, 
                          interval = raw_data$interval)
```

Calculating distribution of cleared data to raw data:

```r
tot_steps_cd <- clear_data %>% 
                group_by(date) %>% 
                summarise(total_steps = sum(steps))

hist(tot_steps_cd$total_steps, xlab="Total steps per day", main = "")
```

![](PA1_template_files/figure-html/unnamed-chunk-8-1.png) 


## Differences in activity patterns between weekdays and weekends

I used *weekdays()* function to identify whether the given date is either weekday or belong to weekend. The dataset with the filled-in missing values has been used for this part.
Also, I created a new factor variable, called *weekday_weekend*, with two levels ("weekday" or "weekend") and incorporated that in the *clear_data_w* data frame. 


```r
clear_data_w <- cbind(clear_data,
                      weekday_weekend = factor(
                                              with(clear_data, 
                                                   ifelse(
                                                          weekdays(as.Date(as.character(clear_data$date))) %in% c("Sunday","Saturday"),
                                                          "weekend", "weekday"
                                                          )
                                                   )
                                               )
                      )
```

I made a panel plot containing a time series plot of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). (I used ggplot2 library for graph creation.)


```r
tot_steps_cdw <- clear_data_w %>% 
                group_by(interval, weekday_weekend) %>% 
                summarise(total_steps = sum(steps))


library(ggplot2)

ggplot(tot_steps_cdw, aes(interval, total_steps)) + 
    geom_line() + 
    facet_grid(weekday_weekend ~ .) +
    ylab("Average number of steps") +
    xlab("Measured intervals")
```

![](PA1_template_files/figure-html/unnamed-chunk-10-1.png) 
