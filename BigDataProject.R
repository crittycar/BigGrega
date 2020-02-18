#Name: Michael Lee
#Date: 13/02/20
#Title: Big Data Project
#
#Description: We look at the crimes committed in Philadelphia between 2006 and 
#2020 and compare crime rates between times when the Philadelphia Eagles entered
#the Superbowl Playoffs and times where they did not enter the playoffs.
#
#Index: 
# 1. Installation
# 2. Subsets
# 3. Functions

#--------------------------------- 1. Installation -----------------------------

#******************** Working Path and Directory Creation **********************

#Working directory subfolders pathways
PhillyCrimeRates <- paste(getwd(),"/","Philly Crime Rates","/",sep ="")
Eagles <- paste(getwd(),"/","Eagles","/",sep ="")
Analysis <- paste(getwd(),"/","Analysis","/",sep ="")


#******************* Installing the CSV files **********************************

#This reads the philly crime rates csv file
phillycrime <- read.csv(paste(PhillyCrimeRates, 
                              "incidents_part1_part2", 
                              sep = ""))

#This reads the eagles playoff games csv file
Eagles_Playoffs <- read.csv(paste(Eagles,
                                  "EaglesPlayoffs.csv",
                                  sep = ""))





#We assign the values in unique.date as actual dates
dateframe <- as.Date(combined.data$unique.date)

#We create a new dataframe with the actual dates as a new column
googy <- cbind(combined.data, dateframe )

#This is the line to create a subset of the dates entered
googy[googy$dateframe >= "2006-01-01" & googy$dateframe <= "2006-02-02",]



