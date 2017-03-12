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

##Covert factor to numeric value
Voltage_num <- as.numeric(levels(twoday$Voltage)[twoday$Voltage])
Global_reactive_power_num <- as.numeric(levels(twoday$Global_reactive_power)[twoday$Global_reactive_power])

##PlotA
png(file = 'PlotA.png')
with(twoday, plot(date_time_format, Voltage_num, type = 'l', xlab = 'datetime', ylab = 'Voltage'))
dev.off()

##PlotB
png(file = 'PlotB.png')
with(twoday, plot(date_time_format, Global_reactive_power_num, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power'))
dev.off()

##Combine all plots into Plot4
png(file = 'Plot4.png')
par(mfrow = c(2,2), cex.lab = 0.75)
with(twoday, {
  plot(date_time_format, Global_active_power_num, pch = '.', ylab = 'Global Active Power (Kilowatts)', xlab = '', type = 'l')
  
  plot(date_time_format, Voltage_num, type = 'l', xlab = 'datetime', ylab = 'Voltage')

  plot(date_time_format, Sub_metering_1_num, col = 'black', type = "l", ylab = 'Energy sub metering', xlab = '')
    points(date_time_format, Sub_metering_2_num, col = 'red', type = "l")
    points(date_time_format, twoday$Sub_metering_3, col = 'blue', type = "l")
    legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = '-')

  plot(date_time_format, Global_reactive_power_num, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')
})
  dev.off()