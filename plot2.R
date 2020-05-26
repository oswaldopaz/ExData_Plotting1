
##########################  DATA ANALYSIS;  PROJECT 1 WEEK 1 PLOT 2 ############################
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

## Now with my subset for the 2 days and the Global_active_power as numeric I'll plot the initial scatter plot for plot 2:

with(subset2, plot(newdate, Global_active_power))

## Now with all the annotations for final plot 2:

with(subset2, plot(newdate, Global_active_power, type='l', ylab = "Global Active Power (kilowatts)", xlab = ""))


## Now copying from screen device to PNG file and saving:

dev.copy(png, "plot2.png") ### The requiered resolution ("a width of 480 pixels and a height of 480 pixels") is the default value so no need to set.

dev.off() ## closing the PNG device

