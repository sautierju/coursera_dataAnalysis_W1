setwd("~/Documents/MOOC/1 - Data Scientist/4 - Data Explanatory/W1")

##Get the File if don't exist and Unzip it
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/PowerConsumption.zip",method="curl")
unzip(zipfile="./data/PowerConsumption.zip",exdir="./data")

#Read the data
data <- read.table("./data/household_power_consumption.txt",sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Load dplyr library to manipulate data
library(dplyr)
data<-tbl_df(data)

#Subset of data with only two dates and convert data type and date
data2007 <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")
data2007[, 3:9] <- lapply(data2007[, 3:9], as.numeric)
data2007 <- mutate(data2007, DateTime = paste(Date, Time, sep = " "))
data2007$DateTime <- strptime(data2007$DateTime, "%d/%m/%Y %H:%M:%S")


#Save as png
png(filename="plot4.png",width = 480,height = 480)
#Combination of 4plots, 2 lines 2 columns
  par(mfrow=c(2,2))
      #plot first graph (plot2)
      plot(data2007$DateTime,data2007$Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  
      #plot 2nd graph
      plot(data2007$DateTime,data2007$Voltage,type = "l", xlab = "datetime", ylab = "")
      
      #plot 3rd graph (plot3)
          #plot graph with 1st parameter
          plot(data2007$DateTime,data2007$Sub_metering_1,type = "l", ylab = "Energy sub metering", xlab = "", col="black")
          #Add 2nd line
          lines(data2007$DateTime,data2007$Sub_metering_2,type = "l", col="red")
          #Add 3rd line
          lines(data2007$DateTime,data2007$Sub_metering_3,type = "l", col="blue")
          #Add legend to corner topleft
          legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      
      #plot 4rd graph
      plot(data2007$DateTime,data2007$Global_reactive_power,type = "l", xlab = "datetime",ylab="Global_reactive_power")
          
    dev.off()

