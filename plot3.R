Sys.setlocale("LC_TIME", "English")
temp     <- tempfile()
fileName <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
coll <- c('Date','Time','Global_active_power',
          'Global_reactive_power','Voltage','Global_intensity',
          'Sub_metering_1','Sub_metering_2','Sub_metering_3')    
download.file(fileName,temp)
data     <- read.table(unz(temp, "household_power_consumption.txt"),
                       header = TRUE, sep=";", as.is = TRUE, stringsAsFactors = FALSE,
                       na.strings = "?", skip = 66636 , nrows = 2880, col.names = coll
)
unlink(temp)
DateTime <-strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S") 
data <- cbind(DateTime,data)
##----------------------------------------



plot(data$DateTime, data$Sub_metering_1, type="l",
     ylab="Energy sub metering", xlab = NA)

lines(data$DateTime, data$Sub_metering_2, type="l", col="red")

lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")

legend("topright", lty = "solid" , col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))


dev.copy(png, file = "plot3.png")