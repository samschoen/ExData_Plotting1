# set working directory
setwd("~/Samantha/Coursera/Exploratory Data Analysis/Peer Assignment 1")


# read first 5 rows to determine the column classes
read5rows <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 5)
classes <- sapply(read5rows, class)

# it was possible to verify the data is sorted by date and time
# we will only be using data from the dates 2007-02-01 and 2007-02-02. 
# the data we need are in rows 66638 - 69517 (2880 rows)
# the first row is the header so the data starts in row 66637

myDataset <- read.table("household_power_consumption.txt"
                        , header = FALSE
                        , col.names = names(read5rows)
                        , skip = 66637 
                        , nrows = 2880
                        , colClasses = classes
                        , na.strings = "?"
                        , sep = ";"
)

# coerce the Date and Time columns 
myDate <- as.Date(myDataset$Date, format = "%d/%m/%Y")
myDateTime <- as.POSIXct(paste(myDate, myDataset$Time), format="%Y-%m-%d %H:%M:%S")


#plot4

par(mfrow= c(2,2), cex = 0.8, mar = c(6,4,2,2))

#1
plot(myDataset$Global_active_power ~ myDateTime
     , type = "l"
     , main= ""
     , xlab = ""
     , ylab = "Global Active Power")

#2
plot(myDataset$Voltage ~ myDateTime
     , type = "l"
     , main= ""
     , xlab = "datetime"
     , ylab = "Voltage")

#3
plot(myDateTime, myDataset$Sub_metering_1
     , lwd = 0.5
     , col = "black"
     , type = "l"
     , xlab = ""
     , ylab = "Energy sub metering")
lines(myDateTime, myDataset$Sub_metering_2
      , col = "red")
lines(myDateTime, myDataset$Sub_metering_3
      , col = "blue")
legend("topright"
       , c("Sub_metering_1"
           , "Sub_metering_2"
           , "Sub_metering_3"
       )
       , col=c("black", "red", "blue")
       , bty = "n"
       , lwd = 0.5
       , cex = 0.8
       , x.intersp = 0.2
       , y.intersp = 0.4
       , inset = -0.05)

#4
plot(myDateTime, myDataset$Global_reactive_power
     , type = "l"
     , xlab = "datetime"
     , ylab = "Global_reactive_power")

dev.copy(png, "plot4.png", width=480, height=480)
dev.off()
