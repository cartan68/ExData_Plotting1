## ********************************************************
##
## Script: plot3.R
##
## Author: Brian Crilly
##
## Date: 18 AUG 2021
##
## Description:
##  This script takes data from the file 'household_power_consumption.txt' and
##  creates a histogram for the 'Global Active Power' variable. This graph is
##  saved as 'plot1.png'.
##
## ********************************************************

# Load any needed libraries


# Load the data file
file_location <- "./data/household_power_consumption.txt"
power_data <- read.table(file_location, header = TRUE, sep = ";")

# Per instructions, subset only to Feb 1 & 2, 2007
power_data <-subset(power_data, Date == "1/2/2007" | Date == "2/2/2007")

# Tidy data
power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")

date_time <- paste(power_data$Date, power_data$Time)
date_time <- strptime(date_time, format = "%Y-%m-%d %H:%M:%S")
power_data$Time <- date_time

power_data$Sub_metering_1 <- 
  as.numeric(as.character(power_data$Sub_metering_1))
power_data$Sub_metering_2 <- 
  as.numeric(as.character(power_data$Sub_metering_2))

# Plot graph to a .png file and store in the output directory
if (!file.exists("output")){
  dir.create("output")
}

png(filename = "./output/plot3.png")
plot(power_data$Time, power_data$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering"
)
lines(power_data$Time, power_data$Sub_metering_2, col = "red")
lines(power_data$Time, power_data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, lwd = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
