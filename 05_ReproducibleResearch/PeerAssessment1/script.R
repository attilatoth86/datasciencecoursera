setwd("/Users/ati/GitHub/RepData_PeerAssessment1/")

## download.file(url="https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip",
##              destfile="repdata_data_activity.zip", method="curl")
unzip(zipfile = "activity.zip")

raw_data <- read.csv(file = "activity.csv")

# Ignore the missing values
raw_data_nona <- raw_data[!is.na(raw_data$steps),]

library(dplyr)
tot_steps <- raw_data_nona %>% 
             group_by(date) %>% 
             summarise(total_steps = sum(steps))

hist(tot_steps$total_steps)

mean(tot_steps$total_steps)
median(tot_steps$total_steps)

avg_steps_intval <- raw_data_nona %>%
                    group_by(interval) %>%
                    summarise(avg_steps = mean(steps))

plot(x = avg_steps_intval$interval, y = avg_steps_intval$avg_steps, type="l")

arrange(avg_steps_intval, desc(avg_steps))[1,1]

length(raw_data[is.na(raw_data$steps),1])

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

tot_steps_cd <- clear_data %>% 
                group_by(date) %>% 
                summarise(total_steps = sum(steps))

hist(tot_steps_cd$total_steps)

mean(tot_steps_cd$total_steps)
median(tot_steps_cd$total_steps)

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

tot_steps_cdw <- clear_data_w %>% 
                group_by(interval, weekday_weekend) %>% 
                summarise(total_steps = sum(steps))

library(ggplot2)
ggplot(tot_steps_cdw, aes(interval, total_steps)) + geom_line() + facet_grid(weekday_weekend ~ .)

