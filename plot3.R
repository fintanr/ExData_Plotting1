#
# plot3.R - Coursera exdata-012
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

#
# Load our input data into a data frame for useage
# We make use of the dplyr package, and "chaining"
# See ?tbl_df and ?filter and ?mutate for more details on 
# the functions, used.
#


df <- tbl_df(read.csv(ourData, header = TRUE, na.strings = "?", sep = ";")) %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Date = as.POSIXct(paste(as.Date(Date, format = "%d/%m/%Y"), Time)))


#
# Create our plot - Submetering Parts v's Date
#

png(filename = "plot3.png", width = 480, height = 480)
with(df, {
     plot( Sub_metering_1 ~ Date, 
           type = "l",
           col = "Black",
           xlab = "",
           ylab = "Energy sub metering")
     lines( Sub_metering_2 ~ Date,
            col = "Red")
     lines( Sub_metering_3 ~ Date,
            col = "Blue")
     })
legend("topright",
       col = c("Black", "Red", "Blue"),
       lty = 1,
       lwd = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))   
dev.off()
