

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
with(tmp
     , plot(Date_Time_Parsed, Sub_metering_1
            , type = "l"
            , col = "black"
            , xlab = ""  ## Label x-axis
            , ylab = "Energy sub metering"  ## Label y-axis
            , main = ""
     )
     , plot(Date_Time_Parsed, Sub_metering_2
            , type = "l"
     )
)
with(tmp
     , points(Date_Time_Parsed, Sub_metering_2
              , type = "l"
              , col = "red" ## Colour
     )
)
with(tmp
     , points(Date_Time_Parsed, Sub_metering_3
              , type = "l"
              , col = "blue" ## Colour
     )
)
legend("topright"
       , lty = 1
       , text.width = 57000
       , col = c("black", "red", "blue")
       , y.intersp = 0.8
       , x.intersp = 0.8
       , xjust = 1
       , yjust = 1
       , legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"
       )
)
## Export to png-file
dev.copy(png,  width = 480, height = 480, file="plot3.png")
dev.off()