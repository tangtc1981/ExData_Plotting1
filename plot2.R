# check if a data folder exists; create new if not available
if (!file.exists("data")) 
{
  dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# download the file
download.file(fileUrl, destfile="./data/power_consumption.zip")

unzip ("./data/power_consumption.zip", exdir = "./data/power_consumption.txt")

# read dated records
data <- read.table(text = grep("^[1,2]/2/2007", readLines("./data/power_consumption.txt"), value = TRUE), sep = ";", skip = 0, na.strings = "?", stringsAsFactors = FALSE)

# rename columns
names(data) <- c("date", "time", "active_power", "reactive_power", "voltage", "intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

# add new datetime column
data$new_time <- as.POSIXct(paste(data$date, data$time), format = "%d/%m/%Y %T")

# plot 2 - line graph
par(mfrow = c(1, 1))
plot(data$new_time, data$active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)" )

# copy plot to png file
dev.copy(png, file = "./data/plot2.png")

# close connection to png device
dev.off()