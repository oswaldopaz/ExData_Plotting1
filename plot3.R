##########################  DATA ANALYSIS;  PROJECT 1 WEEK 1 PLOT 3 ############################
library(dplyr)
library (lubridate)

URLF <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## I WILL START BY DOWNLOADING, UNZIPPING AND THEN READING THE FILE:

download.file(URLF, "data.zip")

unzipped <- unzip("data.zip")

unzipped[] ## to display  file path

mydata <- read.table("./household_power_consumption.txt",stringsAsFactors = F, sep = ";", header =T) ## Right arguments to start, particularly the separator

## Now merging Date and Time in the appropiate class, also converting Global_active_power class to numeric:

mydata <- mydata %>% mutate(newdate=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"), Global_active_power = as.numeric(Global_active_power))

mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y") ## Converting to subset by Date below

## Now subsetting for the two days in question (Feb. 1 an 2, 2007):

subset2 <- subset(mydata, Date=="2007-02-01"|Date=="2007-02-02")

subset3 <- subset2%>% mutate_at(c(7:9),as.numeric) ## The three meterings as class numeric


## Now with my subset for the 2 days and the metering's as numeric I'll plot the initial scatter plot for plot 3:

with(subset3, plot(newdate, Sub_metering_1))

## Now with all the annotations for plot 3 (part 1):

with(subset3, plot(newdate, Sub_metering_1, type='l', ylab = "Energy sub metering", xlab = ""))

## Now adding up plot 3 (part2):

with(subset3, points(newdate, Sub_metering_2, type='l', col = "red"))

## Now adding up plot 3 (part 3):

with(subset3, points(newdate, Sub_metering_3, type='l', col = "blue"))

## Now adding legend for final plot 3:

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = names(subset3[7:9]))

## Now copying from screen device to PNG file and saving:

dev.copy(png, "plot3.png") ### The requiered resolution ("a width of 480 pixels and a height of 480 pixels") is the default value so no need to set.

dev.off() ## closing the PNG device

