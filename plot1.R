## ********************************************************
##
## Script: plot1.R
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

power_data$Global_active_power <- 
  as.numeric(as.character(power_data$Global_active_power))

# Plot histogram to a .png file and store in the output directory
if (!file.exists("output")) {
  dir.create("output")
}

png(filename = "./output/plot1.png")
hist(power_data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)"
)
dev.off()
