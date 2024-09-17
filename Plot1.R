rm(list = ls())
library(tidyverse)
library(dplyr)
library(ggplot2)

#Read in the data and convert from text to csv.
powerConsumption <- read.csv("C:/Users/rockw_000/Desktop/Coursera/household_power_consumption.txt",
                             header = TRUE, sep = ";")

#Filter out the required 2 days of data.
power2days <- dplyr::filter(powerConsumption, Date == "1/2/2007" | Date == "2/2/2007")

#Convert the data in the Date and Time column from character to Date and Time.
power2days$Date <- as.Date(power2days$Date, "%d/%m/%y%y")
power2days$Time <- strptime(power2days$Time, "%H:%M:%S")

#Convert selected remaining data from character to numeric.
power2days <- transform(power2days, Global_active_power = as.numeric(Global_active_power), 
                        Global_reactive_power = as.numeric(Global_reactive_power), 
                        Voltage = as.numeric(Voltage), 
                        Global_intensity = as.numeric(Global_intensity), 
                        Sub_metering_1 = as.numeric(Sub_metering_1), 
                        Sub_metering_2 = as.numeric(Sub_metering_2), 
                        Sub_metering_3 = as.numeric(Sub_metering_3))

#How many rows in the Time column correspond to each day.
table(power2days$Date)
# = 2007-02-01 is 1440 (1 - 1440)
# = 2007-02-02 is 1440 (1441 - 2880)

#Format the Time in accordance with each required date.
power2days[1:1440, "Time"] <- format(power2days[1:1440, "Time"], "2007-02-01 %H:%M:%S")
power2days[1441:2880, "Time"] <- format(power2days[1441:2880, "Time"], "2007-02-02 %H:%M:%S")


#Plot 1
hist(power2days$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

#Copy to PNG
dev.copy(png, file = "Plot1.png")

dev.off()
#Close PNG device
