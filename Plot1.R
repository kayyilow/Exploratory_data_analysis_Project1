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

##Covert factor to numeric value
Global_active_power_num <- as.numeric(levels(twoday$Global_active_power)[twoday$Global_active_power])

##Plot histogram
png(file = 'Plot1.png')
hist(Global_active_power_num, col = 'red', xlab = 'Global Active Power (Kilowatts)', main = 'Global Active Power')
dev.off()
