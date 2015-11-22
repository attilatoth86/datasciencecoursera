###################
# File operations #
###################

## Downloading source file
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "household_power_consumption.zip")

## Unzipping the downloaded file
unzip(zipfile = "household_power_consumption.zip")

## Reading in the unzipped source file to data frame called "hpc"
hpc <- read.table(file = "household_power_consumption.txt", 
                  sep = ";", 
                  header = TRUE)

###############################
# Data cleaning & preparation #
###############################

## Loading in "dplyr" package
library(dplyr)

## Filtering for 1st & 2nd Feb 2007, store into "hpc_filt" data frame
hpc_filt <- filter(hpc, Date %in% c("1/2/2007","2/2/2007"))

## Creating DateTime field by combining Date & Time columns
## and converting into proper data format; selecting only
## necessary fields - storing into "hpc_final" data frame
hpc_final <- cbind(
  DateTime = strptime(
    paste(hpc_filt$Date, 
          hpc_filt$Time, 
          sep=" "),
    "%d/%m/%Y %H:%M:%S"),
  hpc_filt[,c(3:9)]
)

## Converting necessary columns into numeric data type
hpc_final$Global_active_power <- as.numeric(as.character(hpc_final$Global_active_power))
hpc_final$Global_reactive_power <- as.numeric(as.character(hpc_final$Global_reactive_power))
hpc_final$Voltage <- as.numeric(as.character(hpc_final$Voltage))
hpc_final$Global_intensity <- as.numeric(as.character(hpc_final$Global_intensity))
hpc_final$Sub_metering_1 <- as.numeric(as.character(hpc_final$Sub_metering_1))
hpc_final$Sub_metering_2 <- as.numeric(as.character(hpc_final$Sub_metering_2))
hpc_final$Sub_metering_3 <- as.numeric(as.character(hpc_final$Sub_metering_3))

## Set environment's language to English 
Sys.setlocale("LC_TIME","English")

##################
# Building graph #
##################

## Plot 3
## Place a plot to file (png) device

png(filename = "plot3.png",
    width = 480, height = 480, units = "px")

### 1st step: create an empty plot 
plot(hpc_final$DateTime, 
     hpc_final$Sub_metering_1, 
     type = "n", 
     xlab="", 
     ylab="Energy sub metering")
### 2nd step: fill up with graphs
points(hpc_final$DateTime, 
       hpc_final$Sub_metering_1, 
       type = "l",
       col="black")
points(hpc_final$DateTime, 
       hpc_final$Sub_metering_2, 
       type = "l",
       col="red")
points(hpc_final$DateTime, 
       hpc_final$Sub_metering_3, 
       type = "l",
       col="blue")
### 3rd step: place a legend
legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=1, 
       col=c("black","red","blue"))

## Close file device connection
dev.off()