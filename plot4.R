## set the working directory adn load the data.
setwd("source")
proj.data <- read.table("./data/household_power_consumption.txt", sep=";", header=T, na.strings = "?")

## convert to a date to make subsetting easier
proj.data$Date <- as.Date(proj.data$Date, format="%d/%m/%Y", na.omit=T)

## get the subset of data to be plotted
useData <- proj.data[proj.data$Date >= as.Date("2007-02-01") & proj.data$Date <= as.Date("2007-02-02"),]

## perform conversions to make plotting easier (no need to convert within the plot functions)
useData$Global_active_power <- as.numeric(useData$Global_active_power)
useData$Global_reactive_power <- as.numeric(useData$Global_reactive_power)
useData$Sub_metering_1 <- as.numeric(useData$Sub_metering_1)
useData$Sub_metering_2 <- as.numeric(useData$Sub_metering_2)
useData$Sub_metering_3 <- as.numeric(useData$Sub_metering_3)
useData$Voltage <- as.numeric(useData$Voltage)
useData$Time <- strptime(paste(useData$Date, useData$Time), "%Y-%m-%d %H:%M:%S")

## create the plot
png("plot4.png", width=480, height=480, units="px", bg="white")
par(mfrow=c(2,2))

## upper left plot
plot(useData$Time, useData$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## upper right plot
plot(useData$Time, useData$Voltage, type="l", ylab="Voltage", xlab="datetime")

## lower left plot
plot(useData$Time, useData$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col="black")
points(useData$Time, useData$Sub_metering_2, type="l", col = "red")
points(useData$Time, useData$Sub_metering_3, type="l", col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1, 1,1))

## lower right plot
plot(useData$Time, useData$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

dev.off()