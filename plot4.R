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
str(EletricPower)

EletricPower$Date<-as.Date(EletricPower$Date,"%d/%m/%Y")
head(EletricPower$Date)

EletricPower$Time<-strptime(paste(EletricPower$Date,EletricPower$Time),
                            "%Y-%m-%d %H:%M:%S") 
EletricPower$Time<-format(EletricPower$Time,usetz = FALSE)
head(EletricPower$Time)
class(EletricPower$Time)
EletricPower$Time<-as.POSIXlt(EletricPower$Time)

# PLOT 4
#Change the language to English
Sys.setlocale("LC_TIME", "English")

png(file="plot4.png")

par(mfcol=c(2,2))
with(EletricPower,{
  #GRAPH 1
  plot(Time,Global_active_power,type="l", xlab="",
       ylab="Global Active Power")
  #GRAPH 2
  par(mar=c(4,4,2,2))
  with(EletricPower,plot(Time,Sub_metering_1,type="l",ylab="Energy sub metering",
                         xlab=""))
  with(EletricPower,points(Time,Sub_metering_2,type="l",col="red"))
  with(EletricPower,points(Time,Sub_metering_3,type="l",col="blue"))
  legend("topright",lty="solid",col=c("black","red","blue"),bty="n",
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  #GRAPH 3
  plot(Time,Voltage,type="l",ylab="Voltage",xlab="datetime")
  #GRAPH 4
  plot(Time,Global_reactive_power,type="l",xlab="datetime")
})

dev.off()
