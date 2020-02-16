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

#This reads the philly crime rates csv file
phillycrime <- read.csv(paste(PhillyCrimeRates, 
                              "Philly Crime Rates.csv", 
                              sep = ""))

#This reads the eagles playoff games csv file
Eagles_Playoffs <- read.csv(paste(Eagles,
                                  "EaglesPlayoffs.csv",
                                  sep = ""))


head(phillycrime$dispatch_date)
tail(phillycrime$dispatch_date)
levels(phillycrime$dispatch_date)







