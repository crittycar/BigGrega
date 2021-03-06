









season.range <- function(f){
  testing <- as.Date(f[,3], "%d-%b-%y")
  start <- min(testing, na.rm=T)
  end <- max(testing, na.rm=T)
  print(start)
  print(end)
  yearstart <<- start
  yearend <<- end
}


season.range(Eagles2006.csv)

yearstart












# 
#----------------------Big Data Challenge project-------------------------------
#
# To reproduce our findings, run all code below line by line!!
#
#--------------any libraries needed are loaded and displayed below--------------
#
# none so far
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
#
#
#---------------------lets load in the data-------------------------------------
#
#
# time to upload the datas
crime <- read.csv(paste(data.path, "/", "incidents_part1_part2.csv", sep = ""),
                  stringsAsFactors = FALSE)
#
#
# we now need to simplify our data, there are a lot of columns we do not need
# we can make a vector below of all the columns we wish to remove
#
remove.columns <- c("dispatch_date_time", "dispatch_time", "lat",
                   "the_geom_webmercator", "dc_key", "ucr_general",
                   "point_x", "point_y", "dc_dist", "psa", "lng", "the_geom")

# now we want to remove these columns from the data frame.
#
for(i in remove.columns){
crime <- crime[, !(colnames(crime) %in% i)]
}
# we can confirm that we still have the columns we want below
head(crime)
#
#
# now we want to re-format the dispatch_date_time into a better form
# we want the years, months, days, and times to be sorted as such so we can access
# them efficiently and with no potential errors if ex. month and day are the same 
#
# so we can make three new columns, one for year, one for month, and one for day

# we start by putting the dates in a different format
crime$dispatch_date <- as.Date(crime$dispatch_date)  
#
# for ease of use, we can put the date data into separate columns
# so we will make a year column, a month column, and a day column

crime$dispatch_year <- as.numeric(format(crime$dispatch_date, format = "%Y"))
crime$dispatch_month <- as.numeric(format(crime$dispatch_date, format = "%m"))
crime$dispatch_day <- as.numeric(format(crime$dispatch_date, format = "%d"))

# we can confirm that we did what we wanted to 
head(crime)  


# now our data is in a very useable form

# now we can start to ask some questions from our data
# we want to know if the frequency with which crimes occur on super bowl
# championship days is different than what we would expect on a normal day
# we can make a function that will give us the frequency of crimes on 


# function takes any date in the format YYYY-MM-DD
# returns a list of the crime$text_general_code AKA frequency of different crimes
crime.frequency <- function(n){
  freq <- crime$text_general_code[crime$dispatch_date == n]
  return(freq)
}



# now we can easily determine crime frequencies for any date we want
# 
# test to see if it works
foo <- crime.frequency("2018-02-04")
table(foo)

test.1 <- crime$text_general_code[crime$dispatch_date == "2018-02-04"]
table(test.1)


test.2 <- crime$text_general_code[crime$dispatch_date == "2017-02-04"]

test.3 <- crime$text_general_code[crime$dispatch_date == "2016-02-04"]
table(test.2)
length(test.2)
length(test.1)
length(test.3)
table(test.3)
chisq.test(test.1)
test <- crime$text_general_code[crime$dispatch_year == "2018"]
please <- test[crime$dispatch_month == "1"]
table(please)
table(test)
#
#

# We found that a few of the crimes did not have a corresponding
# text_general_code, so we took these entries as labeled them as All Other Offenses
crime$text_general_code[crime$text_general_code == ""] <- "All Other Offenses"
crime$text_general_code <- droplevels(crime$text_general_code)
table(crime$text_general_code)
# 
#
#
# want to first make a function to create an empty vector for every year
# then the funciton should store the requested info into the vector
#
#
# write function that sorts data into objects by year
for (i in c(2006, 2007))
  vector.name <- i
  vector.name <- crime$text_general_code[grep(i, crime$dispatch_date)]
head(vector.name)
table(vector.name)
qa#
#
# crime$text_general_code will give the name of the crime
test <- crime$text_general_code[grep("2006", crime$dispatch_date)]
head(test)
unclass(head(crime$dispatch_date))
#
#
#
#
#
#
# THIS ONLY DOES INDIVIDUAL
date.sub <- function(year.test,month.test,day.test){
  sub.year <- crime[crime$dispatch_year == year.test,]
  sub.month <- sub.year[sub.year$dispatch_month == month.test,]
  sub.day <- sub.month[sub.month$dispatch_day == day.test,]
print(sub.day)
}
subset.testing <- date.sub(2016,1,2)



# READ ME
# WORK IN PROGRESS
# However this function does work. We can input any of 3 variables
# These variables are date.sub.exper(year.test,month.test,day.test)
# If we want to look at the month of march 2015, we use
# date.sub.exper(2015, 3, day.test=FALSE)
# Subsequently if we want all of 2015
# date.sub.exper(2015, month.test=FALSE, day.test=FALSE)

# Here is just running tests
sub.testing.noday <- date.sub.exper(2015,3, day.test = FALSE)
sub.test.nomonth <- date.sub.exper(2015, month.test = FALSE, day.test = FALSE)
all.data.test <- date.sub.exper(2015,12,1:11)

date.sub.exper <- function(year.test,month.test,day.test){
  sub.year <- combined[combined$year %in% year.test,]
  if(month.test == FALSE){
    subset.result <- sub.year
  }
  if(month.test > 0){
 sub.month <- sub.year[sub.year$month %in% month.test,] 
  sub.day <- sub.month[sub.month$day %in% day.test,] 
 subset.result <- sub.day
 if(day.test == FALSE){
   subset.result <- sub.month
  }
 }
  print(subset.result)
}

sept.dec <- date.sub.exper(2006:2019,(9:12),1:31)
jan <- date.sub.exper(2006:2019,1,1:31)

together <- rbind(sept.dec,jan)
sort(together$unique.date, decreasing=FALSE)
testagain <- sort(together$unique.date, decreasing = FALSE)

boxplot(together$crime_frequency~together$binary)




# RANDOM TESTINS TRYING TO REPRODUCE START END DATES

# takes one of our eagles files and returns the start and end dates of the season


season.range <- function(f){
  testing <- as.Date(f[,3], "%d-%b-%y")
  start <- min(testing, na.rm=T)
  end <- max(testing, na.rm=T)
  print(start)
  print(end)
  yearstart <<- start
  yearend <<- end
}


season.range(Eagles2006.csv)

yearstart







# returns a list of the crime$text_general_code AKA frequency of different crimes
crime.frequency <- function(n){
  freq <- crime$text_general_code[crime$dispatch_date == n]
  return(freq)
}



date.sub.exper2 <- function(year.test,month.test,day.test){
  sub.year <- crime[crime$dispatch_year == year.test,]
  if(month.test == FALSE){
    subset.result <- sub.year
  }
  if(month.test > 0){
    sub.month <- sub.year[sub.year$dispatch_month %in% month.test,] 
    sub.day <- sub.month[sub.month$dispatch_day %in% day.test,] 
    subset.result <- sub.day
    if(day.test == FALSE){
      subset.result <- sub.month
    }
  }
  print(subset.result)
}

table(all.data.test)
date.sub.exper2(2015,3:7,1:30)

frequency(all.data.test)

  freq <- all.data.test$text_general_code
  return(freq)
freq

sub.year <- crime[crime$dispatch_year == 2015,]
foo.test <- sub.year[sub.year$dispatch_month == 11,] 
foo <- foo.test[foo.test$dispatch_day %in% 2:5,]


sort(table(freq),decreasing=TRUE)
str(freq)
head(freq)




