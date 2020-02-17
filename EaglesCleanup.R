

# We load in Eagles Football Club data from the timeframe we are examining
setwd(Eagles)
eagle.data <- list.files(pattern="*.csv")
for (i in 1:length(eagle.data)) assign(eagle.data[i], read.csv(eagle.data[i]))

# Binding all dataframes into one
all.eagles <- rbind.data.frame(Eagles2006.csv, Eagles2007.csv, Eagles2008.csv,
                              Eagles2009.csv, Eagles2010.csv, Eagles2011.csv,
                              Eagles2012.csv, Eagles2013.csv, Eagles2014.csv,
                              Eagles2015.csv, Eagles2016.csv, Eagles2017.csv,
                              Eagles2018.csv, Eagles2019.csv)


# Cleaning functions - removing header rows and changing date format.
cleaned.eagles <- all.eagles[!(all.eagles$X=="Day"),]
cleaned.dates <- as.Date(cleaned.eagles$X.1, format = "%d-%b-%y")
# Renaming our subset
date <- cleaned.dates
# Creating a column of 1s
binary <- c(rep(1,length(cleaned.dates)))
# Creating a dataframe with a column of dates and 1s
completed.eagles <- data.frame(date,binary)



