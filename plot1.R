## set the working directory adn load the data.
setwd("source")
proj.data <- read.table("./data/household_power_consumption.txt", sep=";", header=T, na.strings = "?")

## convert to a date to make subsetting easier
proj.data$Date <- as.Date(proj.data$Date, format="%d/%m/%Y", na.omit=T)

## get the subset of data to be plotted
useData <- proj.data[proj.data$Date >= as.Date("2007-02-01") & proj.data$Date <= as.Date("2007-02-02"),]

## perform conversions to make plotting easier (no need to convert within the plot functions)
useData$Global_active_power <- as.numeric(useData$Global_active_power)

## create the plot
png("plot1.png", width=480, height=480, units="px", bg="white")
hist(useData$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()