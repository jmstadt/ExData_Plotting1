##Exploratory Data Analysis Project 1

plot1 <- function() {
	
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

	
	##Create Histogram Plot and make a png file
	hist(DT1$Global_active_power, col = "red", main = "Global Active Power", 
		xlab = "Global Active Power (kilowatts)")
	dev.copy(png, file = "./data/plot1.png")
	dev.off()

}