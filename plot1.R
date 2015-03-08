#
# plot1.R - Coursera exdata-012
# 

library(dplyr)
library(RCurl)

ourData <- "household_power_consumption.txt"
ourZip <- "data.zip"
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if ( !file.exists(ourData) ) {
  print("Source data not found, downloading")
  download.file(dataUrl, ourZip, method = "curl")
  unzip(ourZip, files = ourData, junkpaths = TRUE)
}

# Load our input data into a data frame for useage
# We make use of the dplyr package, and "chaining"
# See ?tbl_df and ?filter for more details on the functions,
# used.
#

df <- tbl_df(read.csv(ourData, header = TRUE, na.strings = "?", sep = ";")) %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")

#
# Create our plot - histogram for Global Active Power
#

png(filename = "plot1.png", width = 480, height = 480)
with(df, hist(Global_active_power, 
              col="red", 
              xlab="Global Active Power (kilowatts)", 
              main="Global Active Power"))
dev.off()
