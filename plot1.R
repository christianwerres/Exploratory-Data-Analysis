

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
## Check date's
table(tmp$Date)
# ok.


## Transform the date column to a proper parsed date:
tmp$Date_parsed <- as.Date(tmp$Date, format = "%d/%m/%Y")
## check date's:
table(tmp$Date_parsed)
# ok.

## Create new feature containing parsed and combined date & time
tmp$Date_Time_Parsed <- strptime(paste(tmp$Date,tmp$Time), "%d/%m/%Y %H:%M:%S")
tmp$Date_Time_Parsed <- as.POSIXct(tmp$Date_Time_Parsed)


## save default parameters for graphics:
.pardefault <- par() 
# par(.pardefault)


#############################
## 3. create plot 1
#############################
## Output the plot:
with(tmp
     , hist(Global_active_power
            ,col = "red"
            , xlab = "Global Active Power (kilowatts)"  ## Label x-axis
            , ylab = "Frequency"  ## Label y-axis
            , main = "Global Active Power"
     )
)
## Export to png-file
dev.copy(png,  width = 480, height = 480, file="plot1.png")
dev.off()
