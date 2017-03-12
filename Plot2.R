##Download data file from web and unzip it and read it
power_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(power_url, temp)
unzip(temp, "household_power_consumption.txt")
table <- read.table("household_power_consumption.txt"
                    , sep = ';'
                    , header = TRUE)
unlink(temp)

##Get subset of the two days i'm working on
twoday <- subset(table, Date %in% c("1/2/2007", "2/2/2007"))

##Combining the date and time so a continuous date/time axis can be created
date_time <- paste(twoday$Date, twoday$Time)
twoday$date_time_format <- strptime(date_time, "%d/%m/%Y %H:%M:%S" )

##Covert factor to numeric value
Global_active_power_num <- as.numeric(levels(twoday$Global_active_power)[twoday$Global_active_power])

##Create plot
png(file = 'Plot2.png')
with(twoday, plot(date_time_format, Global_active_power_num, pch = '.', ylab = 'Global Active Power (Kilowatts)', xlab = '', type = 'l'))
dev.off()
