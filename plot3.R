## Assumes household_power_consumption.txt file located in working dir

plot_3 <- function(){
  
  ## This function has no parameters and: 
  
  ## 1. reads the household_power_consumption.txt file
  
  ## 2. subsets for data taken from 2 days: 2007-02-01 and 2007-02-02
  
  ## 3. generates a plot of different submetering vs time in working dir
  
  
  ## Assumes household_power_consumption.txt file located in working dir
  
  
  ## read data
  
  powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
  
  
  
  ## Create column in table with date and time merged together
  
  FullTimeDate <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
  
  powerdata <- cbind(powerdata, FullTimeDate)
  
  
  
  ## change class of all columns to correct class
  
  powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
  
  powerdata$Time <- format(powerdata$Time, format="%H:%M:%S")
  
  powerdata$Global_active_power <- suppressWarnings(as.numeric(powerdata$Global_active_power))
  
  powerdata$Global_reactive_power <- suppressWarnings(as.numeric(powerdata$Global_reactive_power))
  
  powerdata$Voltage <- suppressWarnings(as.numeric(powerdata$Voltage))
  
  powerdata$Global_intensity <-suppressWarnings(as.numeric(powerdata$Global_intensity))
  
  powerdata$Sub_metering_1 <-suppressWarnings(as.numeric(powerdata$Sub_metering_1))
  
  powerdata$Sub_metering_2 <-suppressWarnings(as.numeric(powerdata$Sub_metering_2))
  
  powerdata$Sub_metering_3 <-suppressWarnings(as.numeric(powerdata$Sub_metering_3))
  
  
  
  ## subset data from 2007-02-01 and 2007-02-02
  
  subsetdata <- subset(powerdata, Date == "2007-02-01" | Date =="2007-02-02")
  
  
  
  ## plot globalactivepower vs date&time
  
  png("plot_3.png", width=480, height=480)
  
  with(subsetdata, plot(FullTimeDate, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering"))
  
  lines(subsetdata$FullTimeDate, subsetdata$Sub_metering_2,type="l", col= "red")
  
  lines(subsetdata$FullTimeDate, subsetdata$Sub_metering_3,type="l", col= "blue")
  
  legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
  
  dev.off()
  
}