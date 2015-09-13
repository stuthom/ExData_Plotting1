# This script is to show a simple example of plotting using the base plotting system in R.

# It uses the Individual household electric power consumption Data Set available from the
# UCI Machine Learning Repository. (http://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption)

# The direct link to the original source data file is here http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip
# however we will use the course-supplied source data file which can be found here:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# We will only be using data from the dates 2007-02-01 and 2007-02-02.

# This example shows a simple histogram with some colours.


########
# Load required packages
install.packages("lubridate")
library(lubridate)

########
# Get the data file and load it.
sourceURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destzipfilename <- "datafile.zip"
datafilename <- "household_power_consumption.txt"

download.file(sourceURL, method="libcurl", destfile=destzipfilename)
unzip(destzipfilename)

alldata <- read.delim(datafilename, header=TRUE, sep=";", na.strings="?")

########
# Do some preprocessing and get the days we're interested in, then remove the main data set to save memory
alldata$Date <- dmy(alldata$Date)

plotData <- alldata[alldata$Date >= "2007-02-01" & alldata$Date < "2007-02-03", ]
plotData$datetime <- as.POSIXct(paste(plotData$Date, plotData$Time))

########
## Now we have our data, plot it and save to PNG
png("plot4.png")

# Make the layout 2 x 2
par(mfrow = c(2, 2))

# Now show the plots
with(plotData, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

with(plotData, plot(datetime, Voltage, type="l"))

with(plotData, plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
    with(plotData, lines(datetime, Sub_metering_2, type="l", col="red"))
    with(plotData, lines(datetime, Sub_metering_3, type="l", col="blue"))
    with(plotData, legend("topright", col=c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lwd=1, box.lwd=0))

with(plotData, plot(datetime, Global_reactive_power, type="l"))

dev.off()

