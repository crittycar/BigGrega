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
library("zoo")
#
#--------------make project folders and folder paths----------------------------


wd <- getwd()  # working directory

folders <- c("Data Output", "Figures")
# function to create folders below
for(i in 1:length(folders)){
  if(file.exists(folders[i]) == FALSE)
    dir.create(folders[i])
}


# we also need to store the paths to these new folders
data.output.path <- paste(wd, "/", folders[1], sep = "")
figures.path <- paste(wd, "/", folders[2], sep = "")

# our raw data is stored in different folders, lets make the paths
philly.crime.path <- paste(wd, "/", "Philly Raw Crime Data", sep = "")
eagles.seasons.path <- paste(wd, "/", "Eagles Raw Season Data", sep = "")


# now we can access and save stuff to these folders!



#---------------------Below, we upload and clean the philly crime data----------


# time to upload the datas
crime <- read.csv(paste(philly.crime.path, "/", "Philly_Raw_Crime_Data.csv",
                        sep = ""), stringsAsFactors = FALSE)



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


# we also want to put the dates into date format 
#this will make them easier to work with later
crime$dispatch_date <- as.Date(crime$dispatch_date)  


# our data is now much simpler. We still need to clean some more
# every single occurence of a crime represents a single observation in our
# initial data. This is why there are almost three million data points

# we are interested in the total frequency of crimes on a given day
# so we want to make a new data frame that has unique dates and the
# number of crimes that occured on each unique date

# we construct this new data frame below

# this is a helper function that takes any date in the format YYYY-MM-DD
# returns the frequency of crimes on the input day
crime.frequency <- function(n){
  freq <- crime$text_general_code[crime$dispatch_date == n]
  length(freq)
}

# we will use this function to create the frequency column in our cleaned data frame

# below we create a new data.frame 
# we first have to create an empty one that we can fill with values
crime.cleaned <- data.frame(c(rep(NA, length(unique(crime$dispatch_date)))))

# here we can input the unique dates into their own column
crime.cleaned$unique.date <- sort(unique(crime$dispatch_date))


# now we want to add a column that contains the daily crime frequency

# the vector below contains numbers to help us index
row.num <- c(1:length(crime.cleaned$unique.date))  


# this vector contains the sorted unique dates
date.range <- c(crime.cleaned$unique.date[row.num])

# this is the empty column that we will fill with daily crime frequencies
crime.cleaned$crime_frequency <- rep(NA, length(crime.cleaned$unique.date))


# this loop fills up the above empty column with daily crime frequencies
for(i in 1:length(crime.cleaned$crime_frequency)){
   crime.cleaned$crime_frequency[i] <- crime.frequency(date.range[i])  
}


# we remove the NA column that was place-holding
crime.cleaned$c.rep.NA..length.unique.crime.dispatch_date.... <- NULL

# we can look at our cleaned data to confirm that it looks very nice
head(crime.cleaned)





#--------------now we want to load in and clean the eagles data----------------- 

# this is where we use the dplyr library we loaded at the beginning
# for the bind_rows function

# We load in Eagles Football Club data from the timeframe we are examining

# recall that our eagles data can be accessed with the path eagles.seasons.path


# The list.files function identifies all .csv files in the Eagles folder
# then stores the names of the files as strings in a vector
# we will use these as the names of our individual season objects
eagle.data <- list.files(path = eagles.seasons.path ,pattern="*.csv")

# this loop names each data frame and imports it into our environment  
for (i in 1:length(eagle.data)){ 
  assign(eagle.data[i], read.csv(paste(eagles.seasons.path, "/", eagle.data[i], sep = ""),
                                 stringsAsFactors = FALSE))
}


# Below we bind all dataframes into one
binded.data <- mget(eagle.data)  # mget gets multiple variables 

# bind_rows from the dpylr library allows us to bind data from a list of data frames
# the object all.eagles contains the dates of all the seasons
all.eagles <- bind_rows(binded.data)  


# Cleaning functions - removing header rows and changing date format.
cleaned.eagles <- all.eagles[!(all.eagles[,2]=="Day"),]
cleaned.dates <- as.Date(cleaned.eagles[,3], format = "%d-%b-%y")


# We renaming our subset
unique.date <- cleaned.dates

# Creating a column of 1s. A 1 indicates the presence of a game day
# we call this column binary
binary <- c(rep(1,length(cleaned.dates)))

# Creating a dataframe with a column of dates and 1s
completed.eagles <- data.frame(unique.date,binary)


# now we can look at the cleaned data to see it
head(completed.eagles)


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

# we can write this clean data into a csv file for use
# we store it into our data output folder
write.csv(combined.data, paste(data.output.path, "/", "Final_Clean_Data.csv", sep = ""))



#----------------find and store start and end dates of every season-------------

# the function below outputs two vectors
# year.start is a vector that contains the starting date of the given season
# year.end is a vector that contains the ending date of the given season
season.range.start <- function(f){
  testing <- as.Date(f[,3], "%d-%b-%y")
  start <- min(testing, na.rm=T)
  return(start)
}


season.range.end <- function(f){
  testing <- as.Date(f[,3], "%d-%b-%y")
  end <- max(testing, na.rm=T)
  return(end)
}

# empty vectors to fill up
season.start <- rep(NA, length(eagle.data))
season.end <- rep(NA, length(eagle.data))

# fill up season.start vector with start dates. note that they come out
# in numeric format, we will convert them back after
for (i in 1:length(eagle.data)){ 
 season.start[i] <- season.range.start(
    read.csv(paste(eagles.seasons.path, "/", eagle.data[i], sep = ""),
                                 stringsAsFactors = FALSE))
}


for (i in 1:length(eagle.data)){ 
  season.end[i] <- season.range.end(
    read.csv(paste(eagles.seasons.path, "/", eagle.data[i], sep = ""),
             stringsAsFactors = FALSE))
}

# our for loop spits out dates as.numeric so we need to convert back to date form
# the zoo library we imported at the beginning allows us to do this using
# the function as.Date
season.start <- as.Date(season.start)
season.end <- as.Date(season.end)







#We assign the values in unique.date as actual dates
as.Date(combined.data$unique.date)


# subset.season function takes a start date and an end date
# returns the section of our data frame bounded by the given start and end date inclusive
subset.season <- function(s, e){
  combined.data[combined.data$unique.date >= s & combined.data$unique.date <= e,]
}





#----------------------automated t-test for every season------------------------

# We need to ensure that the dates in our combined.data are in a good format
as.Date(combined.data$unique.date)

# try to make the subsetting and t-test fully general and done on a loop


# so that we can store the outputs of our t-test, each with a name
# we create an empty vector then use a loop to fill it with names
t.test.names <- rep(NA, length(2006:2019))
years <- c(2006:2019)

# loop to make names
for(i in 1:length(2006:2019)){
  t.test.names[i] <- c(paste("t.test", ".", years[i], sep = ""))
}


# function subsets the crime_frequency of the dataframe df by the binary value n
binary.subset <- function(df, n){
  df$crime_frequency[df$binary == n]
}


# this loop stores the t.test values for every season into an object 
# whose name is drawn in order from the vector t.test.names
for(i in 1:length(2006:2019)){
  assign(t.test.names[i], t.test(binary.subset(subset.season(season.start[i], season.end[i]), 0),
       binary.subset(subset.season(season.start[i], season.end[i]), 1)))
}



# We can capture all of these results from the above loop into a .csv file 
# and store them in the data.output.path folder
T.test.results <- capture.output(t.test.2006, t.test.2007, t.test.2008, t.test.2009,
                                 t.test.2010, t.test.2011, t.test.2012, t.test.2013,
                                 t.test.2014, t.test.2015, t.test.2016, t.test.2017,
                                 t.test.2018, t.test.2019, 
                                 file = paste(data.output.path, "/", 
                                              "Seasonal_T_Test.Results.csv", sep = ""))



# we also want to make figures to visualize the crime rates every season
# recall that a 0 indicates no game and a 1 indicates the presence of a game


# similarly to the t-test, we need to use subset.season function inside
# of boxplot in order to iterate the creation of boxplots over multiple seasons

# we make the names of the boxplots below
box.plot.names <- rep(NA, length(2006:2019))

# loop to make names
for(i in 1:length(2006:2019)){
  box.plot.names[i] <- c(paste("box.plot", ".", years[i], sep = ""))
}



# loop that assigns the plots to names and stores them in the figures folder
for(i in 1:length(2006:2019)){
  png(filename = paste(figures.path, "/", box.plot.names[i], ".png", sep = ""))
  boxplot((subset.season(season.start[i], season.end[i]))$crime_frequency ~
            ((subset.season(season.start[i], season.end[i]))$binary),
          xlab = "Game Day Presence or Absence", ylab = "Frequency of Crimes")
  dev.off()
}


#-------------------t-test and boxplot for all seasons compiled-----------------


# we can use the subset.seasons to subset combined.data by season
# then we will bind all of these dataframes together
# the resulting dataframe will contain the crime frequencies for 
# all the seasons we have


# we will make a vector of what we want these to be named below
#seasons.names <- rep(NA, length(2006:2019))

# fills the vector seasons.names with the names of the seasons
#for(i in 1:length(2006:2019))
# seasons.names[i] <- c(paste("season", ".", years[i], sep = ""))


# creates subset data frames of all of the data by season!!!!!!
#for(i in 1:length(season.start))
#  assign(seasons.names[i], subset.season(season.start[i], season.end[i]))














