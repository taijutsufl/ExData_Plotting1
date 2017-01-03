## set the working directory adn load the data.
setwd("source")
proj.data <- read.table("./data/household_power_consumption.txt", sep=";", header=T, na.strings = "?")

## convert to a date to make subsetting easier
proj.data$Date <- as.Date(proj.data$Date, format="%d/%m/%Y", na.omit=T)

## get the subset of data to be plotted
useData <- proj.data[proj.data$Date >= as.Date("2007-02-01") & proj.data$Date <= as.Date("2007-02-02"),]

## perform conversions to make plotting easier (no need to convert within the plot functions)
useData$Sub_metering_1 <- as.numeric(useData$Sub_metering_1)
useData$Sub_metering_2 <- as.numeric(useData$Sub_metering_2)
useData$Sub_metering_3 <- as.numeric(useData$Sub_metering_3)
useData$Time <- strptime(paste(useData$Date, useData$Time), "%Y-%m-%d %H:%M:%S")

## create the plot
png("plot3.png", width=480, height=480, units="px", bg="white")
plot(useData$Time, useData$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col="black")
points(useData$Time, useData$Sub_metering_2, type="l", col = "red")
points(useData$Time, useData$Sub_metering_3, type="l", col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1, 1,1))
dev.off()