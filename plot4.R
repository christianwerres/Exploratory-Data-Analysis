

#############################
## 1. Read relevant data
#############################
##  R-script must be in the same folder as the "data" folder that contains
##  the relevant data.
household_power_cons <- read.table(file ="data/household_power_consumption.txt",
                                   header = TRUE, sep = ";",
                                   na.strings = "?",
                                   check.names=F, 
                                   stringsAsFactors=F, 
                                   comment.char="", 
                                   quote='\"')

## Get dimension:
dim(household_power_cons)
## 2075259       9
## check NA values
table(is.na(household_power_cons))
#    FALSE     TRUE 
# 18495478   181853


#############################
## 2. Subset relevant dates
#############################
tmp <- subset(household_power_cons, Date == "1/2/2007" | Date == "2/2/2007")
## Get dimension:
dim(tmp)
# 2880    9

## Transform the date column to a proper parsed date:
tmp$Date_parsed <- as.Date(tmp$Date, format = "%d/%m/%Y")

## Create new feature containing parsed and combined date & time
tmp$Date_Time_Parsed <- strptime(paste(tmp$Date,tmp$Time), "%d/%m/%Y %H:%M:%S")
tmp$Date_Time_Parsed <- as.POSIXct(tmp$Date_Time_Parsed)


## save default parameters for graphics:
.pardefault <- par() 
# par(.pardefault)


#############################
## 3. create plot 2
#############################
## Output the plot:
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(tmp, {
  plot(Global_active_power~Date_Time_Parsed, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~Date_Time_Parsed, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Date_Time_Parsed, type="l", 
       ylab="Global Active Power", xlab="")
  lines(Sub_metering_2~Date_Time_Parsed,col='Red')
  lines(Sub_metering_3~Date_Time_Parsed,col='Blue')
  legend("topright"
         , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
         , lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o"
  )
  plot(Global_reactive_power~Date_Time_Parsed, type="l", 
       ylab="Global Rective Power",xlab="datetime")
})


## Export to png-file
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(tmp, {
  plot(Global_active_power~Date_Time_Parsed, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~Date_Time_Parsed, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Date_Time_Parsed, type="l", 
       ylab="Global Active Power", xlab="")
  lines(Sub_metering_2~Date_Time_Parsed,col='Red')
  lines(Sub_metering_3~Date_Time_Parsed,col='Blue')
  legend("topright"
         , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
         , lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o"
  )
  plot(Global_reactive_power~Date_Time_Parsed, type="l", 
       ylab="Global Rective Power",xlab="datetime")
})
dev.off()
