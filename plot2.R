## ********************************************************
##
## Script: plot2.R
##
## Author: Brian Crilly
##
## Date: 17 AUG 2021
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
date_time <- strptime(date_time, format = "%d/%m/%Y %H:%M:%S")
power_data$Time <- date_time

power_data$Global_active_power <- 
  as.numeric(as.character(power_data$Global_active_power))

# Plot histogram to a .png file and store in the output directory
if (!file.exists("output")){
  dir.create("output")
}

png(filename = "./output/plot2.png")
plot(power_data$Time, power_data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
)
dev.off()
