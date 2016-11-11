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


#plot1

hist(myDataset$Global_active_power
     , col = 'red'
     , main="Global Active Power"
     , xlab = "Global Active Power (kilowatts)"
)
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()