##If the package 'forestplot' is not installed then Rstudio should prompt 
##you to install it. If not then remove the hashtag from the line below
##before running the script and it will be installed.

#install.packages('forestplot')

#####################

## Define how the plot is to look.

# Define the colours for the forest plot boxes, lines, and summary prisms.
boxColour="#009999"
lineColour="#009999"
summaryColour="#009999"

# Define the size of the plot boxes.
boxsize=0.5

# Define the dimensions of the plot.
plotWidth=1000
plotHeight=330

# Define the upper and lower bounds of the x-axis.
lowerBound=0.2
upperBound=1.5

# Define the x-axis tick marks: the lower bound, upper bound, and interval
lowerTicks=0.5
upperTicks=1.4
ticksInterval=0.1
ticksSize=1

# Define the x-axis label and text size.
xlab="Hazard Ratio"
xlabSize=1

# Define what paper details to include in addition to the source.
include_year=FALSE
include_numberInSample=TRUE
include_measure=TRUE
include_value=TRUE












#############################################################################################
library(forestplot)



##Read in CSV data
HRdata=read.csv("ForestPlot_data.csv")
source<-c("Source",as.character(HRdata$Source))
modelNumber<-c("Model",as.character(HRdata$ModelNumber))
year<-c("Year",as.character(HRdata$Year))
numberInSample<-c("n",as.character(HRdata$numberInSample))
measure<-c("Measure",as.character(HRdata$measure))
value<-c("Value",as.numeric(HRdata$value))
isSummary<-c(TRUE,as.logical(HRdata$isSummary))
lowerCI<-c(NA,as.numeric(HRdata$lowerCI))
upperCI<-c(NA,as.numeric(HRdata$upperCI))


##Create data for plot.
tableText<-c(source)

if (include_year==TRUE){
        tableText<-cbind(tableText,year)
}
if (include_numberInSample==TRUE){
        tableText<-cbind(tableText,numberInSample)
}
if (include_measure==TRUE){
        tableText<-cbind(tableText,measure)
}
if (include_value==TRUE){
        tableText<-cbind(tableText,value)
}

tableData<-structure(list(value,lowerCI,upperCI),class="data.frame")



##Plot the forest plot
xClip=c(lowerBound,upperBound)
own<-fpTxtGp()
own$ticks$cex<-ticksSize
own$xlab$cex<-xlabSize

png("ForestPlot_output.png",width=plotWidth, height=plotHeight,unit="px")
forestplot(tableText,
           mean=value,
           lower=lowerCI,
           upper=upperCI,
           #title="Medication - ACE Inhibitor",
           is.summary=isSummary,
           grid=1,
           col=fpColors(box=boxColour,line=lineColour,summary=summaryColour),
           zero=NA,
           txt_gp=own,
           clip=xClip,
           xlab=xlab,
           xticks = seq(from=lowerTicks, to = upperTicks, by = ticksInterval),
           hrzl_lines=TRUE,
           vertices=TRUE,
           boxsize=boxsize
           #graph.pos=5
           )
dev.off()

