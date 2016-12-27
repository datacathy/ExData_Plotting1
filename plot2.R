# This is plot2.R
# plotting Global_active_power vs Date_Time
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

# now plot Global_active_power vs Date_Time
with(twodays, plot(Date_Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# write the plot to file "plot2.png"
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()

# clean up
rm(fulldata)
rm(twodays)

print("...finished.")