# This is plot1.R
# plotting a histogram of variable Global_active_power
# from the UCI ML Repository dataset "Electric power consumption"

print("Starting...")

# I'll use the dplyr library to help with data manipulation
library(dplyr)

# first load the data
fulldata <- read.table("../household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# now translate variables Date and Time to variable Date_Time of class POSIXct
fulldata <- mutate(fulldata, Date_Time = paste(Date, Time))
fulldata <- mutate(fulldata, Date_Time = as.POSIXct(Date_Time, format = "%d/%m/%Y %H:%M:%S"))

# now subset the data into the two days we want
twodays <- subset(fulldata, Date_Time >= as.POSIXct("2007-02-01", format="%Y-%m-%d") & Date_Time < as.POSIXct("2007-02-03", format="%Y-%m-%d"))

# now plot a histogram of variable Global_active_power
hist(twodays$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# write the histogram to file "plot1.png"
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

# clean up
rm(fulldata)
rm(twodays)

print("...finished.")