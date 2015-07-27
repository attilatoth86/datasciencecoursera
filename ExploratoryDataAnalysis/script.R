download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
              destfile = "nei_data.zip", 
              method = "curl")

unzip("nei_data.zip")

# Load data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Loading dplyr library for data manipulation
library(dplyr)

## Question 1
################################################################################
# Create variable of total pm2.5 emission per year
TotPM25EmByYear <- NEI %>% 
                   group_by(year) %>% 
                   summarise(TotalEmission = sum(Emissions))

# Place a plot to file (png) device 
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

# Plot total pm2.5 emission per year
barplot(TotPM25EmByYear$TotalEmission/1000000, 
        ylab="Total Emission (MM t)", 
        names.arg = TotPM25EmByYear$year, 
        main="Total emissions of PM2.5 in the United States from 1999 to 2008")

# Close file device connection
dev.off()
################################################################################

## Question 2
################################################################################
# Create variable of total pm2.5 emission per year in Baltimore City, Maryland
TotPm25EmBC <- NEI %>% 
               filter(fips == "24510") %>% 
               group_by(year) %>% 
               summarise(TotalEmission = sum(Emissions))

# Place a plot to file (png) device 
png(filename = "plot2.png",
    width = 480, height = 480, units = "px")

# Plot total pm2.5 emission per year in Baltimore City, Maryland
barplot(TotPm25EmBC$TotalEmission/1000,
        ylab="Total Emission (thousand t)", 
        names.arg = TotPm25EmBC$year, 
        main="Total emissions of PM2.5 \nin Baltimore City, Maryland from 1999 to 2008"
        )

# Close file device connection
dev.off()
################################################################################

## Question 3
################################################################################
# Load ggplot2 library
library(ggplot2)

# Create variable of total pm2.5 emission per year & emission type 
# in Baltimore City, Maryland
TotPm25EmBCTyp <-   NEI %>% 
                    filter(fips == "24510") %>% 
                    group_by(year, type) %>% 
                    summarise(TotalEmission = sum(Emissions))

# Place a plot to file (png) device 
png(filename = "plot3.png",
    width = 480, height = 480, units = "px")

# Plot total pm2.5 emission per year & type in Baltimore City, Maryland
qplot(year,
      TotalEmission, 
      data = TotPm25EmBCTyp, 
      geom = "line", 
      fill = type,
      color = type,
      ylab = "Total Emission (tons)",
      xlab = NULL,
      main = "Total emissions of PM2.5 by source type \nin Baltimore City, Maryland from 1999 to 2008"
      )

# Close file device connection
dev.off()
################################################################################

## Question 4
################################################################################
# Create a subset of NEI by sectors that contain "coal" expression that contains
# only sources that are coal combustion related
NEIByCoal <- NEI[NEI$SCC %in% as.character(
                                SCC[grep(pattern = "coal",
                                         x = SCC$EI.Sector,  
                                         ignore.case = T
                                         )
                                    ,1]
                                        )
               ,]

# Create a variable of total PM2.5 emission from coal combustion related sources
# per year
TotPm25EmByCoal <- NEIByCoal %>%
                    group_by(year) %>%
                    summarise(TotalEmission = sum(Emissions))

# Place a plot to file (png) device 
png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

# Plot total pm2.5 emission per year from coal combustion related sources
barplot(TotPm25EmByCoal$TotalEmission/1000000, 
        ylab="Total Emission (MM t)", 
        names.arg = TotPm25EmByCoal$year, 
        main="Total emissions of PM2.5 in the United States from 1999 to 2008\nfrom coal combustion related sources")

# Close file device connection
dev.off()
################################################################################

## Question 5
################################################################################
## Motor vehicle sources ~ vehicles driven on the road

# Create variable of total pm2.5 emission from motor vehicles per year 
# in Baltimore City, Maryland
TotPm25EmBCOnRoad <-   NEI %>% 
                        filter(fips == "24510" & type == "ON-ROAD") %>% 
                        group_by(year) %>% 
                        summarise(TotalEmission = sum(Emissions))

# Place a plot to file (png) device 
png(filename = "plot5.png",
    width = 480, height = 480, units = "px")

# Plot total pm2.5 emission per year from motor vehicles in Baltimore City, Maryland
barplot(TotPm25EmBCOnRoad$TotalEmission, 
        ylab="Total Emission (tons)", 
        names.arg = TotPm25EmBCOnRoad$year, 
        main="Total emissions of PM2.5 in Baltimore City, Maryland\nfrom 1999 to 2008 from motor vehicles")

# Close file device connection
dev.off()
################################################################################

## Question 6
################################################################################
## Motor vehicle sources ~ vehicles driven on the road

# Create variable of total pm2.5 emission from motor vehicles per year 
# in Baltimore City, Maryland & Los Angeles County, California 
TotPm25EmBCLAOnRoad <- NEI %>% 
                        filter(fips %in% c("24510","06037") & type =="ON-ROAD") %>% 
                        group_by(year, fips) %>% 
                        summarise(TotalEmission = sum(Emissions))

# Place a plot to file (png) device 
png(filename = "plot6.png",
    width = 480, height = 480, units = "px")

par(mfrow = c(1,2), mar=c(3,4,5,0))
barplot(TotPm25EmBCLAOnRoad$TotalEmission[TotPm25EmBCLAOnRoad$fips == "24510"], 
        ylab="Total Emission (tons)", 
        names.arg = TotPm25EmBCLAOnRoad$year[TotPm25EmBCLAOnRoad$fips == "24510"],
        main="Baltimore City, Maryland",
        cex.main=0.8
        )
barplot(TotPm25EmBCLAOnRoad$TotalEmission[TotPm25EmBCLAOnRoad$fips == "06037"], 
        names.arg = TotPm25EmBCLAOnRoad$year[TotPm25EmBCLAOnRoad$fips == "06037"],
        main="Los Angeles County,\nCalifornia",
        cex.main=0.8
        )
title("Total emission of PM2.5 from 1999 to 2008 from motor vehicles", outer = T, line = -1)

# Close file device connection
dev.off()
################################################################################