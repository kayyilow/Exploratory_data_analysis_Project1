##Download data file from web and unzip it and read it
power_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(power_url, temp)
unzip(temp, "household_power_consumption.txt")
table <- read.table("household_power_consumption.txt"
                    , sep = ';'
                    , header = TRUE)
unlink(temp)

##Getting subset of the 2 days which I'm analysing
twoday <- subset(table, Date %in% c("1/2/2007", "2/2/2007"))

##Combining the date and time so a continuous date/time axis can be created
date_time <- paste(twoday$Date, twoday$Time)
twoday$date_time_format <- strptime(date_time, "%d/%m/%Y %H:%M:%S" )

## Covert factors to numeric values (note: Sub_metering_3 values are already numeric)
Sub_metering_1_num <- as.numeric(levels(twoday$Sub_metering_1)[twoday$Sub_metering_1])
Sub_metering_2_num <- as.numeric(levels(twoday$Sub_metering_2)[twoday$Sub_metering_2])


##Creating the plot and saving it into png file
png(file = 'Plot3.png')

with(twoday, plot(date_time_format, Sub_metering_1_num, col = 'black', type = "l", ylab = 'Energy sub metering', xlab = ''))
points(date_time_format, Sub_metering_2_num, col = 'red', type = "l")
points(date_time_format, twoday$Sub_metering_3, col = 'blue', type = "l")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = '-')

dev.off()
