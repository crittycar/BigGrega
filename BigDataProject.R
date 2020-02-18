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


###2006 Season
Season2006<- googy[googy$dateframe >= "2006-09-10" & googy$dateframe <= "2007-01-07",]

y2006= Season2006$crime_frequency[Season2006$binary == 1]

#non game days
x2006= Season2006$crime_frequency[Season2006$binary == 0]

p06 <- t.test(x2006,y2006)

###2007
Season2007<- googy[googy$dateframe >= "2007-09-09" & googy$dateframe <= "2007-12-30",]

y2007= Season2007$crime_frequency[Season2007$binary == 1]

#non game days
x2007= Season2007$crime_frequency[Season2007$binary == 0]

p07 <- t.test(x2007,y2007)

###2008
Season2008<- googy[googy$dateframe >= "2008-09-07" & googy$dateframe <= "2009-01-18",]

y2008= Season2008$crime_frequency[Season2008$binary == 1]

#non game days
x2008= Season2008$crime_frequency[Season2008$binary == 0]

p08 <- t.test(x2008,y2008)

###2009
Season2009<- googy[googy$dateframe >= "2009-09-13" & googy$dateframe <= "2010-01-09",]

y2009= Season2009$crime_frequency[Season2009$binary == 1]

#non game days
x2009= Season2009$crime_frequency[Season2009$binary == 0]

p09 <- t.test(x2009,y2009)

###2010
Season2010<- googy[googy$dateframe >= "2010-09-12" & googy$dateframe <= "2011-01-09",]

y2010= Season2010$crime_frequency[Season2010$binary == 1]

#non game days
x2010= Season2010$crime_frequency[Season2010$binary == 0]

p10 <- t.test(x2010,y2010)

###2011
Season2011<- googy[googy$dateframe >= "2011-09-11" & googy$dateframe <= "2012-01-01",]

y2011= Season2011$crime_frequency[Season2011$binary == 1]

#non game days
x2011= Season2011$crime_frequency[Season2011$binary == 0]

p11 <- t.test(x2011,y2011)

###2012
Season2012<- googy[googy$dateframe >= "2012-09-09" & googy$dateframe <= "2012-12-30",]

y2012= Season2012$crime_frequency[Season2012$binary == 1]

#non game days
x2012= Season2012$crime_frequency[Season2012$binary == 0]

p12 <- t.test(x2012,y2012)

###2013
Season2013<- googy[googy$dateframe >= "2013-09-09" & googy$dateframe <= "2014-01-04",]

y2013= Season2013$crime_frequency[Season2013$binary == 1]

#non game days
x2013= Season2013$crime_frequency[Season2013$binary == 0]

p13 <- t.test(x2013,y2013)

###2014
Season2014<- googy[googy$dateframe >= "2014-09-07" & googy$dateframe <= "2014-12-28",]

y2014= Season2014$crime_frequency[Season2014$binary == 1]

#non game days
x2014= Season2014$crime_frequency[Season2014$binary == 0]

p14 <- t.test(x2014,y2014)

###2015
Season2015<- googy[googy$dateframe >= "2015-09-14" & googy$dateframe <= "2016-01-03",]

y2015= Season2015$crime_frequency[Season2015$binary == 1]

#non game days
x2015= Season2015$crime_frequency[Season2015$binary == 0]

p15 <- t.test(x2015,y2015)

###2016
Season2016<- googy[googy$dateframe >= "2016-09-11" & googy$dateframe <= "2017-01-01",]

y2016= Season2016$crime_frequency[Season2016$binary == 1]

#non game days
x2016= Season2016$crime_frequency[Season2016$binary == 0]

p16 <- t.test(x2016,y2016)

###2017
Season2017<- googy[googy$dateframe >= "2017-09-10" & googy$dateframe <= "2018-02-04",]

y2017= Season2017$crime_frequency[Season2017$binary == 1]

#non game days
x2017= Season2017$crime_frequency[Season2017$binary == 0]

p17 <- t.test(x2017,y2017)

###2018
Season2018<- googy[googy$dateframe >= "2018-09-06" & googy$dateframe <= "2019-01-13",]

y2018= Season2018$crime_frequency[Season2018$binary == 1]

#non game days
x2018= Season2018$crime_frequency[Season2018$binary == 0]

p18 <-t.test(x2018,y2018)

###2019
Season2019<- googy[googy$dateframe >= "2019-09-08" & googy$dateframe <= "2020-01-05",]

y2019= Season2019$crime_frequency[Season2019$binary == 1]

#non game days
x2019= Season2019$crime_frequency[Season2019$binary == 0]

p19 <- t.test(x2019,y2019)


T.test.results <- capture.output(p06,p07,p08,p09,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19, file = "Results.csv")



