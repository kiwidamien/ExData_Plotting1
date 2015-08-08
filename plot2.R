# Read in the data, making sure that ? are interpreted as missing data
power_data <- read.csv("household_power_consumption.txt", header=T,sep = ";", stringsAsFactors = F, na.strings = "?")

# Note that head(power_data) yields dates as 16/12/2007, i.e. the date format is day / month / year
# We can select on the date strings '1/2/2007' and '2/2/2007', rather than converting
DateSelectData <- power_data[power_data$Date %in% c('1/2/2007','2/2/2007'),]

# Get datatime column in coverted format
DateSelectData$datetime = strptime( paste(DateSelectData$Date, DateSelectData$Time), format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(DateSelectData, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "",))
dev.off()