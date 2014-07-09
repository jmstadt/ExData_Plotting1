##Exploratory Data Analysis Project 1

plot4 <- function() {
	
	##Set up a directory to put downloaded file
	if (!file.exists("data")) {
		dir.create("data")
	} else {message("directory already exists")}

	##Description of File to download
	##http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

	##Download file into directory
	if (!file.exists("./data/Dataset.zip")) {
		fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
		download.file(fileUrl, destfile = "./data/Dataset.zip")
		filelist <- list.files("./data")
		print(filelist)
		dateDownloaded <- date()
		print(dateDownloaded)
	} else {message("Dataset.zip already exists")}

	##Unzip File
	if (!file.exists("household_power_consumption.txt")) {
		unzip("./data/Dataset.zip")
	} else {message("Household Power Consumption Dataset already exists")}

	##Read File only for dates 2007-02-01 and 2007-02-02
	##library(sqldf)
	DT1 <- read.csv.sql("./household_power_consumption.txt", sep = ";", 
		sql = 'select * from file where 
		Date == "1/2/2007" or Date == "2/2/2007"')

	##Create DateTime Column
	DT1$DateTime = paste(DT1$Date, DT1$Time)
	DT1$DateTime <- strptime(DT1$DateTime, "%d/%m/%Y %H:%M:%S")

	
	##Create Plot and make a png file
	par(mfrow = c(2,2))

	with(DT1, plot(DateTime, Global_active_power, 
		type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

	with(DT1, plot(DateTime, Voltage, xlab = "datetime", type = "l"))

	with(DT1, plot(DateTime, Sub_metering_1, 
		type = "l", xlab = "", ylab = "Energy sub metering"))
	lines(DT1$DateTime, DT1$Sub_metering_2, col = "red")
	lines(DT1$DateTime, DT1$Sub_metering_3, col = "blue")
	legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), 
		legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

	with(DT1, plot(DateTime, Global_reactive_power, 
		xlab = "datetime", type = "l"))
	
	dev.copy(png, file = "./data/plot4.png")
	dev.off()

}