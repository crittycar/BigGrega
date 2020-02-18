#
# 
#
#----------------------Big Data Challenge project-------------------------------
#
# To reproduce our findings, run all code below line by line!!
#
#--------------any libraries needed are loaded and displayed below--------------
#
library(dplyr)
#
#--------------make project folders and folder paths----------------------------
#
wd <- getwd()  # working directory
#
#
folders <- c("Data Output", "Figures", "Data")
# function to create folders below
for(i in 1:length(folders)){
  if(file.exists(folders[i]) == FALSE)
    dir.create(folders[i])
}
#
# we also need to store the paths to all of these folders
data.output.path <- paste(wd, "/", folders[1], sep = "")
figures.path <- paste(wd, "/", folders[2], sep = "")
data.path <- paste(wd, "/", folders[3], sep = "")
#
#
# now we can save stuff to these folders!



#---------------------Below, we upload and clean the philly crime data----------


# time to upload the datas
crime <- read.csv(paste(data.path, "/", "Philly_Raw_Crime_Data.csv", sep = ""),
                  stringsAsFactors = FALSE)



#
#
# we now need to simplify our data, there are a lot of columns we do not need
# we can make a vector below of all the columns we wish to remove

remove.columns <- c("dispatch_date_time", "dispatch_time", "lat",
                   "the_geom_webmercator", "dc_key", "ucr_general",
                   "point_x", "point_y", "dc_dist", "psa", "lng", "the_geom")

# we write a for loop to remove these columns from the data frame
for(i in remove.columns){
crime <- crime[, !(colnames(crime) %in% i)]
}
# we can confirm that we still have the columns we want below
head(crime)


# we also want to put the dates into date format, this will make them easier to 
# work with later
crime$dispatch_date <- as.Date(crime$dispatch_date)  


# our data is now much simpler. We still need to clean some more
# every single occurence of a crime represents a single observation in our
# initial data. This is why there are almost three million data point

# we are really interested in the total frequency of crimes on a given day
# so we want to make a new data frame that has unique dates and the
# number of crimes that occured on each unique date
# below we will make a function to help us create the new data frame


# function takes any date in the format YYYY-MM-DD
# returns a list of the crime$text_general_code AKA frequency of different crimes
crime.frequency <- function(n){
  freq <- crime$text_general_code[crime$dispatch_date == n]
  length(freq)
}

# we can use this function to create the frequency column in our cleaned data frame


# below we create a new data.frame 
# we first have to create an empty one that we can then fill with values
crime.cleaned <- data.frame(c(rep(NA, length(unique(crime$dispatch_date)))))
crime.cleaned$unique.date <- sort(unique(crime$dispatch_date))


# we want to make a new column in the cleaned data frame
# we want for this column to contain the frequency of crime for every date

# this vector just contains numbers to help us index
row.num <- c(1:length(crime.cleaned$unique.date))  

# this vector contains the sorted unique dates
date.range <- c(crime.cleaned$unique.date[row.num])

# this is the empty column that we will fill with daily crime frequencies
crime.cleaned$crime_frequency <- rep(NA, length(crime.cleaned$unique.date))

# this loop fills up the above empty vector with daily crime frequencies
for(i in 1:length(crime.cleaned$crime_frequency))
   crime.cleaned$crime_frequency[i] <- crime.frequency(date.range[i])  

# we remove the NA column that was place-holding
crime.cleaned$c.rep.NA..length.unique.crime.dispatch_date.... <- NULL

# we can look at our cleaned data to confirm that it looks very nice
head(crime.cleaned)



# for analysis, we may want to sort the data by year, or by year and month
# so we will create three separate columns that contain year, month, day
crime.cleaned$year <- as.numeric(format(crime.cleaned$unique.date, format = "%Y"))
crime.cleaned$month <- as.numeric(format(crime.cleaned$unique.date, format = "%m"))
crime.cleaned$day <- as.numeric(format(crime.cleaned$unique.date, format = "%d"))

# we can look at the data to see that we accomplished what we wanted
head(crime.cleaned)



#--------------now we want to load in and clean the eagles data----------------- 

# this is where we use the dplyr library we loaded at the beginning
# for the bind_rows function

# We load in Eagles Football Club data from the timeframe we are examining

# set the working directory to the file containing the Eagles data
# which is located in our primary R file
setwd("Eagles")

# The list.files function identifies all .csv files in the Eagles folder
eagle.data <- list.files(pattern="*.csv")
for (i in 1:length(eagle.data)) 
  assign(eagle.data[i], read.csv(eagle.data[i]))


# Binding all dataframes into one
binded.data <- mget(eagle.data)  # mget gets multiple variables 
all.eagles <- bind_rows(binded.data)  # dpylr allows us to bind data from a list of data frames


# Cleaning functions - removing header rows and changing date format.
cleaned.eagles <- all.eagles[!(all.eagles$X.1=="Day"),]
cleaned.dates <- as.Date(cleaned.eagles$X.2, format = "%d-%b-%y")

# Renaming our subset
unique.date <- cleaned.dates
# Creating a column of 1s
binary <- c(rep(1,length(cleaned.dates)))
# Creating a dataframe with a column of dates and 1s
completed.eagles <- data.frame(unique.date,binary)


first(completed.eagles$unique.date)
last(completed.eagles$unique.date)

#------------------------combining our two datasets-----------------------------

# we now want to merge our two cleaned data sets into a single data.frame
# recall that the cleaned datas are stored in 
# completed.eagles and crime.cleaned

# we will use the merge function to merge by date and combine them into one dataset
combined.data <- merge(crime.cleaned, completed.eagles, all.x = TRUE)

# the only problem now is that we have NA values where there is not a game
# we want for there to be a zero instead of an NA value

# we can use the function below to change all the NA's to 0
combined.data[is.na(combined.data)] <- 0

write.csv(combined.data, file = "combined.data.csv")



#------------------------subset data by season----------------------------------
# the function below outputs two vectors
# year.start is a vector that contains the starting date of the given season
# year.end is a vector that contains the ending date of the given season
season.range <- function(f){
  testing <- as.Date(f[,3], "%d-%b-%y")
  start <- min(testing, na.rm=T)
  end <- max(testing, na.rm=T)
  print(start)
  print(end)
  season.start <<- start
  season.end <<- end
}


# we want to iterate this vector over all of the seasons that we have
# so that we can get the start and end dates for every season
# since our function above takes an object rather than a string,
# iteration has proven to be nearly impossible, at least for us

# ideally, we would make a for loop that would take a list of the names of the 
# eagles data (Eagles2006.csv, Eagles2007.csv, etc.)
# since our function does not take strings, however, this does not work

# we are going to use the function to do these by hand and
# store them into two vectors
season.start <- c("2006-09-10", "2007-09-09", "2008-09-07", "2009-09-13", "2010-09-12",
                  "2011-09-11", "2012-09-09", "2013-09-09", "2014-09-07", "2015-09-14",
                  "2016-09-11", "2017-09-10", "2018-09-06", "2019-09-08")

season.end <- c("2007-01-13", "2007-12-30", "2009-01-18", "2010-01-09", "2011-01-09",
                "2012-01-01", "2012-12-30", "2014-01-04", "2014-12-28", "2016-01-03",
                "2017-01-01", "2018-02-04", "2019-01-13", "2020-01-05")

season.range(Eagles2006.csv)
season.range(Eagles2007.csv)
season.range(Eagles2008.csv)
season.range(Eagles2009.csv)
season.range(Eagles2010.csv)
season.range(Eagles2011.csv)
season.range(Eagles2012.csv)
season.range(Eagles2013.csv)
season.range(Eagles2014.csv)
season.range(Eagles2015.csv)
season.range(Eagles2016.csv)
season.range(Eagles2017.csv)
season.range(Eagles2018.csv)
season.range(Eagles2019.csv)

# unfortunately, doing this by hand is absolutely appalling
# the reason we were unable to iterate this is that we could not find a way 
# to store the objects in a vector. We tried A LOT of ways to get around this
# the difficulty is that the function season.range takes a data frame not a string
# If we had figured this out, it would be very simple for us to automate the above
# we would just make the start and end vectors full of NA's and fill them up with dates

# we will write a for loop that takes every value in eagle.data
# and runs it through the function season.range
# this will output two vectors. 
# season.start will contain the start dates of every season in our dataset
# season.end will contain the end dates of every season in our dataset




#We assign the values in unique.date as actual dates
as.Date(combined.data$unique.date)


# subset.season function takes a start date and an end date
# returns the section of our data frame bounded by the given start and end date inclusive
subset.season <- function(s, e){
  combined.data[combined.data$unique.date >= s & combined.data$unique.date <= e,]
}


# now we can use this function to make new data frames that are divided by season
# we will make a vector of what we want these to be named below
seasons.names <- rep(NA, length(2006:2019))
years <- c(2006:2019)

# fills the vector seasons.names with the names of the seasons
for(i in 1:length(2006:2019))
  seasons.names[i] <- c(paste("season", ".", years[i], sep = ""))


# creates subset data frames of all of the data by season!!!!!!
for(i in 1:length(season.start))
  assign(seasons.names[i], subset.season(season.start[i], season.end[i]))



#----------------------automated t-test for every season------------------------

# try to make the subsetting and t-test fully general and done on a loop

# so that we can store the outputs of our t-test, each with a name
# we create an empty vector then use a loop to fill it with names
t.test.names <- rep(NA, length(2006:2019))

# loop to make names
for(i in 1:length(2006:2019))
  t.test.names[i] <- c(paste("t.test", ".", years[i], sep = ""))



# function subsets the crime_frequency of the dataframe df by the binary value n
binary.subset <- function(df, n){
  df$crime_frequency[df$binary == n]
}


# this loop stores the t.test values for every season into an object 
# whose name is drawn in order from the vector t.test.names
for(i in 1:length(2006:2019))
assign(t.test.names[i], t.test(binary.subset(subset.season(season.start[i], season.end[i]), 0),
       binary.subset(subset.season(season.start[i], season.end[i]), 1)))


# we can put these into 
T.test.results <- capture.output(t.test.2006, t.test.2007, t.test.2008, t.test.2009,
                                 t.test.2010, t.test.2011, t.test.2012, t.test.2013,
                                 t.test.2014, t.test.2015, t.test.2016, t.test.2017,
                                 t.test.2018, t.test.2019, file = "Seasonal_T_Test.Results.csv")


# this function can create a boxplot for any of our data frames
box.plot <- function(df){
  boxplot(df$crime_frequency ~ df$binary, xlab = "Game Day Presence or Absence",
          ylab = "Frequency of Crimes")
}

# subset.season makes the data subsets. Takes a start date and end date as arguments
# we need to use this inside of boxplot in order to be able to iterate the 
# creation of boxplots

box.plot.names <- rep(NA, length(2006:2019))

# loop to make names
for(i in 1:length(2006:2019))
  box.plot.names[i] <- c(paste("box.plot", ".", years[i], sep = ""))


# loop that assigns the plots to names and stores them in the working directory
for(i in 1:length(2006:2019)){
  png(filename = paste("boxplot.", seasons.names[i], ".png", sep = "" ))
  boxplot((subset.season(season.start[i], season.end[i]))$crime_frequency ~
            ((subset.season(season.start[i], season.end[i]))$binary),
          xlab = "Game Day Presence or Absence", ylab = "Frequency of Crimes")
  dev.off()
}

















