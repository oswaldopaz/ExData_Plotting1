
##########################  DATA ANALYSIS;  PROJECT 1 WEEK 1 PLOT 1 ############################
library(dplyr)

URLF <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## I WILL START BY DOWNLOADING, UNZIPPING AND THEN READING THE FILE:

download.file(URLF, "data.zip")

unzipped <- unzip("data.zip")

unzipped[] ## to display  file path

mydata <- read.table("./household_power_consumption.txt",stringsAsFactors = F, sep = ";", header =T) ## Right arguments to start, particularly the separator

mydata <- mydata %>% mutate(Date=as.Date(Date, format="%d/%m/%Y"), Global_active_power = as.numeric(Global_active_power)) ## Had to take care of the date format, the default format is different in my local system for Chile

## Now subsetting for the two days in question (Feb. 1 an 2, 2007):

subset <- subset(mydata, mydata$Date=="2007-02-01"|mydata$Date=="2007-02-02")

## Now with my subset for the 2 days and the Global_active_power as numeric I'll plot the initial histogram plot for plot 1:

hist(subset$Global_active_power)

## Now adding the annotiations for final plot 1 on screen device:

hist(subset$Global_active_power, col = "red", xlab = "Golbal Active Power (kilowats)", main = "Global Active Power")

## Now copying from screen device to PNG file and saving:

dev.copy(png, "plot1.png") ### The requiered resolution ("a width of 480 pixels and a height of 480 pixels") is the default value so no need to set.

dev.off() ## closing the PNG device












