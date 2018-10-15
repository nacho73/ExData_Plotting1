## Assumes household_power_consumption.txt file located in working dir

plot_2 <- function(){
  
  ## This function has no parameters and:
  
  ## 1. reads the household_power_consumption.txt file
  
  ## 2. subsets for data taken from 2 days: 2007-02-01 and 2007-02-02
  
  ## 3. generates a plot of global active power vs. time in working dir
  
  
  
 
  
  ## Assumes household_power_consumption.txt file located in working dir
  
  
  
  ## read data
  
  powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
  
  
  
  ## Create column in table with date and time merged together
  
  FullTimeDate <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
  
  powerdata <- cbind(powerdata, FullTimeDate)
  
  
  
  ## change class of all columns to correct class
  
  powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
  
  powerdata$Time <- format(powerdata$Time, format="%H:%M:%S")
  
  powerdata$Global_active_power <-suppressWarnings(as.numeric(powerdata$Global_active_power))
  
  powerdata$Global_reactive_power <-suppressWarnings(as.numeric(powerdata$Global_reactive_power))
  
  powerdata$Voltage <- suppressWarnings(as.numeric(powerdata$Voltage))
  
  powerdata$Global_intensity <-suppressWarnings(as.numeric(powerdata$Global_intensity))
  
  powerdata$Sub_metering_1 <-suppressWarnings(as.numeric(powerdata$Sub_metering_1))
  
  powerdata$Sub_metering_2 <-suppressWarnings(as.numeric(powerdata$Sub_metering_2))
  
  powerdata$Sub_metering_3 <-suppressWarnings(as.numeric(powerdata$Sub_metering_3))
  
  
  
  ## subset data from 2007-02-01 and 2007-02-02
  
  subsetdata <- subset(powerdata, Date == "2007-02-01" | Date =="2007-02-02")
  
  
  
  ## plot globalactivepower vs date&time
  
  png("plot_2.png", width=480, height=480)
  
  with(subsetdata, plot(FullTimeDate, Global_active_power, type="l", xlab="Day", ylab="Global Active Power (kilowatts)"))
  
  dev.off()
  
}