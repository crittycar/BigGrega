#
# 
# Big Data Challenge project
#
#
# Libraries below
#
#
#
#
# lets upload the datas!
crime <- read.csv("incidents_part1_part2.csv", stringsAsFactors = FALSE)
#
#
# we want to ultimately separate the data into separate data frames by year
# we have some decisions to make. We notice that for the time and date, we have
# a total of three columns: date, time, and date time
#
# we are interested in the daily occurence of crimes, so time is too fine grained
# for us at this point. We will therefore remove the date-time and time collumns
# in the interest of speeding up our computations
#
#
# We can use a fairly simple command to do this
#
crime$dispatch_date_time <- crime$dispatch_time <- NULL
head(crime$dispatch_time)  # we can confirm that the command worked as we hoped
#
# we can also remove other columns that we do not need from this dataset
#
#
# now we want to re-format the dispatch_date_time into a better form
unclass(crime$dispatch_date)  
# when we use the unclass command, we see that the data is just stored as numbers 
# we want the years, months, days, and times to be sorted as such so we can access
# them efficiently and with no potential errors if ex. month and day are the same 
#
# so we can make three new columns, one for year, one for month, and one for day
#
# need to make this more readable
crime$dispatch_date <- as.Date(crime$dispatch_date)  # put in a different date format
#
# for ease of use, we can put the date data into separate columns
# so we now have a year column, a month column, and a day column

crime$dispatch_year <- (year = as.numeric(format(crime$dispatch_date, format = "%Y")))
crime$dispatch_month <- (month = as.numeric(format(crime$dispatch_date, format = "%m")))
crime$dispatch_day <- (day = as.numeric(format(crime$dispatch_date, format = "%d")))

head(crime)  # to confirm we did what we wanted to do 
#
# now we want to take out more data from the dataset to make computations faster
#
crime$objectid <- crime$the_geom <- crime$lng <- crime$dc_dist <- crime$psa <- NULL
crime$lat <- crime$the_geom_webmercator <- crime$dc_key <- crime$ucr_general <- NULL
crime$point_x <- crime$point_y <- NULL
#
# farmer style, we removed all the data that we did not want, about 11 columns
# 
# now we can start to ask some questions from our data
# we want to know if the frequency with which crimes occur on super bowl
# championship days is different than what we would expect on a normal day
# we can make a function that will give us the frequency of crimes on 


# function takes any date in the format YYYY-MM-DD
# outputs a list of the crime$text_general_code
crime.frequency <- function(n){
  freq <- crime$text_general_code[crime$dispatch_date == n]
  return(freq)
}


# now we can easily crime frequencies for any date

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
# try to make an empty data frame with 5 columns and nrow(crime) rows
nrow(crime)
names <- c("test", "testing", "testtest")
empties <- rep(NA, length(names))
cleaned.data <- data.frame(rbind(names, empties))
?data.frame


# we will convert our data into POSIXlt form for ease of use
crime$dispatch_date_time <- as.POSIXlt(crime$dispatch_date_time)

head(crime$dispatch_date_time)



years <- crime$dispatch_date[grep("2005", crime$dispatch_date)]
head(years)
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
