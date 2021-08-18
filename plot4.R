## ********************************************************
##
## Script: plot4.R
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

datetime <- paste(power_data$Date, power_data$Time)
datetime <- strptime(datetime, format = "%Y-%m-%d %H:%M:%S")
power_data <- cbind(datetime, power_data)

power_data[ , 4:10] <- sapply(power_data[ , 4:10], as.character)
power_data[ , 4:10] <- sapply(power_data[ , 4:10], as.numeric)

# Plot graphs to a .png file and store in the output directory
if (!file.exists("output")){
  dir.create("output")
}

png(filename = "./output/plot4.png")
par(mfrow = c(2, 2))

# Plot 1 (Upper Left)
plot(power_data$datetime, power_data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power"
)

# Plot 2 (Upper Right)
plot(power_data$datetime, power_data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage"
)

# Plot 3 (Lower Left)
plot(power_data$datetime, power_data$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering"
)
lines(power_data$datetime, power_data$Sub_metering_2, col = "red")
lines(power_data$datetime, power_data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, lwd = 1, col = c("black", "red", "blue"),
       bty = "n", cex = 0.75, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

# Plot 4 (Lower Right)
plot(power_data$datetime, power_data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power"
)

dev.off()
