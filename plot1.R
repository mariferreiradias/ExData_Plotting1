#Reading the data
household_power<-read.table("household_power_consumption.txt",header=TRUE,
                            sep=";",as.is=TRUE)
head(household_power)
str(household_power)

#Subsetting for dates 1/2/2007 and 2/2/2007
EletricPower<-household_power[(household_power$Date=='1/2/2007' | 
                                 household_power$Date=='2/2/2007'),]
table(EletricPower$Date)
head(EletricPower)

#Converting the Date and Time variables
EletricPower$Date<-as.Date(EletricPower$Date,"%d/%m/%Y")
head(EletricPower$Date)

EletricPower$Time<-strptime(paste(EletricPower$Date,EletricPower$Time),
                            "%Y-%m-%d %H:%M:%S") 
EletricPower$Time<-format(EletricPower$Time,usetz = FALSE)
head(EletricPower$Time)
class(EletricPower$Time)
EletricPower$Time<-as.POSIXlt(EletricPower$Time)

#Converting the variable to numeric
EletricPower$Global_active_power<-as.numeric(EletricPower$Global_active_power)

# PLOT 1
hist(EletricPower$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.copy(png,file="plot1.png")
dev.off()
