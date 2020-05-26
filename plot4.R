
##########################  DATA ANALYSIS;  PROJECT 1 WEEK 1 PLOT 4 ############################
library(dplyr)
library (lubridate)

URLF <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## I WILL START BY DOWNLOADING, UNZIPPING AND THEN READING THE FILE:

download.file(URLF, "data.zip")

unzipped <- unzip("data.zip")

unzipped[] ## to display  file path

mydata <- read.table("./household_power_consumption.txt",stringsAsFactors = F, sep = ";", header =T) ## Right arguments to start, particularly the separator

## Now merging Date and Time in the appropiate class:

mydata <- mydata %>% mutate(newdate=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y") ## Converting to subset by Date below

## Now subsetting for the two days in question (Feb. 1 an 2, 2007):

subset2 <- subset(mydata, Date=="2007-02-01"|Date=="2007-02-02")

subset3 <- subset2%>% mutate_at(c(3:5,7:9),as.numeric) ## The needed meterings as class numeric

## Now constructing the 4-table plot 4:

par(mfcol= c(2,2), mar= c(4,4,2,1))

with(subset3, {
  
  plot(newdate, Global_active_power, type='l', ylab = "Global Active Power (kilowatts)", xlab = "")
  plot(newdate, Sub_metering_1, type='l', ylab = "Energy sub metering", xlab = "")
    points(newdate, Sub_metering_2, type='l', col = "red")
    points(newdate, Sub_metering_3, type='l', col = "blue")
    legend("topright", lty = 1, col = c("black", "red", "blue"), legend = names(subset3[7:9]))
  plot(newdate, Voltage, type='l', ylab = "Voltage")
  plot(newdate, Global_reactive_power, type='l')
})

## Now copying from screen device to PNG file and saving:

dev.copy(png, "plot4.png") ### The requiered resolution ("a width of 480 pixels and a height of 480 pixels") is the default value so no need to set.

dev.off() ## closing the PNG device


