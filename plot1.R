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

##Create plot
png(file = "plot1.png")
hist(powerdata$Global_active_power, breaks = 12, xlim = c(0,6), ylim = c(0,1200),
     col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()
