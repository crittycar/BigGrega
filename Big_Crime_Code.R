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

crime <- read.csv("C:/Users/user/OneDrive - Quest University Canada/Desktop/Quest 2019-2020/Data Analysis in R/Git/BigGrega/Data/Philly_Raw_Crime_Data.csv.csv")

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
for (i in 1:length(eagle.data)) assign(eagle.data[i], read.csv(eagle.data[i]))


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







