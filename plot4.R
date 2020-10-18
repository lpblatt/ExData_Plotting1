##Download File

library(dplyr)
if (!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./data/ElectricPower.zip")
unzip(zipfile = "./data/ElectricPower.zip", exdir = "./data")

##Read data into R
powerdata <- read.table("./data/household_power_consumption.txt", sep = ";",
                        header = TRUE)

powerdata <- filter(powerdata, powerdata$Date == "1/2/2007" | 
                        powerdata$Date == "2/2/2007")

#create datetime based on date and time
powerdata$Date <- paste(powerdata$Date, powerdata$Time)
powerdata$Date <- as.POSIXct(powerdata$Date, format = "%d/%m/%Y %H:%M:%S")

#format other variables as numeric
powerdata[,3:9] <- sapply(powerdata[,3:9], as.numeric)

##plot data
png(file = 'plot4.png')
par(mfrow = c(2,2))

##Top Left Plot
plot(powerdata$Date, powerdata$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)",
     cex = .5)

##Top right plot
plot(powerdata$Date, powerdata$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage", ylim = c(234, 246),
     cex = .5)

##Bottom left plot
plot(powerdata$Date, powerdata$Sub_metering_1, type = "l", col = "black",
     ylab = "Energy sub metering", xlab = "", ylim = c(0,40))
lines(powerdata$Date, powerdata$Sub_metering_2, col = "red")
lines(powerdata$Date, powerdata$Sub_metering_3, col = "blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       lwd=c(2,2),
       col=c("black","red", "blue"),
       cex = .5,
       box.lty = 0)

#Bottom right plot
plot(powerdata$Date, powerdata$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power", ylim = c(0.0, 0.5),
     cex = .5)

dev.off()