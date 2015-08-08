# Read in the data, making sure that ? are interpreted as missing data
power_data <- read.csv("household_power_consumption.txt", header=T,sep = ";", stringsAsFactors = F, na.strings = "?")

# Note that head(power_data) yields dates as 16/12/2007, i.e. the date format is day / month / year
# We can select on the date strings '1/2/2007' and '2/2/2007', rather than converting
DateSelectData <- power_data[power_data$Date %in% c('1/2/2007','2/2/2007'),]

# Get datatime column in coverted format
DateSelectData$datetime = strptime( paste(DateSelectData$Date, DateSelectData$Time), format = "%d/%m/%Y %H:%M:%S")


#Set up the PNG device to save
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# Get the legend names directly from the header (avoid mistyping)
legend_titles <- names(DateSelectData)[7:9]

# Make the base plot, and add extra lines.
with(DateSelectData, plot(datetime, Sub_metering_1, type='l', col='black', ylab = 'Energy sub metering', xlab=''))
with(DateSelectData, lines(datetime, Sub_metering_2, type='l', col='red'))
with(DateSelectData, lines(datetime, Sub_metering_3, type='l', col='blue'))

# Note: This way of putting the legend up is a little error prone and cumbersome.
#       I have to manually type in the colors and make sure they match the titles
legend("topright",pch = 1, col=c('black','red','blue'), legend = legend_titles)


# Finish writing the plot3.R PNG
dev.off()