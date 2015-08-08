# Read in the data, making sure that ? are interpreted as missing data
power_data <- read.csv("household_power_consumption.txt", header=T,sep = ";", stringsAsFactors = F, na.strings = "?")

# Note that head(power_data) yields dates as 16/12/2007, i.e. the date format is day / month / year
# We can select on the date strings '1/2/2007' and '2/2/2007', rather than converting
DateSelectData <- power_data[power_data$Date %in% c('1/2/2007','2/2/2007'),]

# Get datatime column in coverted format
DateSelectData$datetime = strptime( paste(DateSelectData$Date, DateSelectData$Time), format = "%d/%m/%Y %H:%M:%S")

#Set up the PNG device to save
png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2))
with(DateSelectData, {
  plot(datetime, Global_active_power, type = 'l', ylab='Global Active Power', xlab='')
  plot(datetime, Voltage, type = 'l')
  
  # This is plot 3, with multiple lines on plot
  plot(datetime, Sub_metering_1, type='l', col='black', ylab = 'Energy sub metering', xlab='')
  lines(datetime, Sub_metering_2, type='l', col='red')
  lines(datetime, Sub_metering_3, type='l', col='blue')
  legend("topright",pch = 1, col=c('black','red','blue'), 
         legend = c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'), bty='n')
  
  # Back to plot 3
  plot(datetime, Global_reactive_power, type = 'l')  
})

#Close the PNG file
dev.off()
