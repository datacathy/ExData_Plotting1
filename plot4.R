# This is plot4.R
# plotting: Global_active_power vs Date_Time, and
#           Voltage vs Date_Time, and
#           Sub_metering_1 through Sub_metering_3 vs. Date_Time, and
#           Global_reactive_power vs. Date_Time.
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

# first set up grid
par(mfrow = c(2,2))

# now plot Global_active_power vs. Date_Time
with(twodays, plot(Date_Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

# next, plot Voltage vs. Date_Time
with(twodays, plot(Date_Time, Voltage, type = "l", xlab = "datetime"))

# now plot three Sub_metering zones vs. Date_Time
with(twodays, plot(Date_Time, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
with(twodays, lines(Date_Time, Sub_metering_2, col = "red"))
with(twodays, lines(Date_Time, Sub_metering_3, col = "blue"))
legend("topright", lty = c(1,1,1), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))

# finally, plot Global_reactive_power vs. Date_Time
with(twodays, plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime"))

# write the multiplot to file "plot4.png"
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()

# clean up
par(mfrow = c(1,1))
rm(fulldata)
rm(twodays)

print("...finished.")