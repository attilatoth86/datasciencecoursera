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

## Plot 2
## Place a plot to screen device
plot(hpc_final$DateTime, 
     hpc_final$Global_active_power, 
     type = "l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

## Copy content of screen device to PNG file ("plot2.png", 480x480)
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")

## Close file device connection
dev.off()