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
  png(filename="plot1.png",width = 480,height = 480)
    #First plot, histogram
    hist(data2007$Global_active_power,col="red",main="Global Active Power",xlab ="Global Active Power (kilowatts)")
  dev.off()
  