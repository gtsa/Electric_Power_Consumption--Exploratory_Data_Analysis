# We are loading the "dplyr" and "tidyr" libraries (piping and its select function will be used)
library(dplyr)
library(tidyr)
unzip("exdata_data_household_power_consumption.zip")
# We are checking names of the directories available in our woring directory
# in order to localise the one concerning us (e.g. "UCI HAR Dataset")
list.dirs(getwd())
list.files(getwd())

# We are loading the txt file in a data frame replacing the missing values (coded as "?") with NA
my_data <- read.delim("./household_power_consumption.txt", sep = ";", header=TRUE, na.strings="?")
# We are converting dates columns' values in date objects in date (format yyyy/mm/dd)
my_data$Date <- as.Date(my_data$Date, format = "%d/%m/%Y")
# We are filtering only the rows corresponding to the dates we're interested in 
my_data <- filter(my_data, Date == "2007/02/01" | Date == "2007/02/02")
# We are uniting tha date and time collumns
my_data <- unite(my_data, "Date_Time", c("Date","Time"), sep = " ")
# We are converting the resulting character vector into class "POSIXlt" 
my_data$Date_Time <- strptime(my_data$Date_Time, format="%Y-%m-%d %T")


# --- Create and save plot in png file
png(filename = "plot3.png") # Default values: width = 480, height = 480, units = "px"
with(my_data, plot(Date_Time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "" ))
points(my_data$Date_Time, my_data$Sub_metering_2, type = "l", col="red" )
points(my_data$Date_Time, my_data$Sub_metering_3, type = "l", col="blue" )
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1)
dev.off()