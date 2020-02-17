# We need to use the dplyr package for the bind_rows function
library(dplyr)

# We load in Eagles Football Club data from the timeframe we are examining
setwd(Eagles)
eagle.data <- list.files(pattern="*.csv")
for (i in 1:length(eagle.data)) assign(eagle.data[i], read.csv(eagle.data[i]))


# Binding all dataframes into one
binded.data <- mget(eagle.data)  # mget gets multiple variables 
all.eagles <- bind_rows(binded.data)  # dpylr allows us to bind data from a list of data frames


# Cleaning functions - removing header rows and changing date format.
cleaned.eagles <- all.eagles[!(all.eagles$X=="Day"),]
cleaned.dates <- as.Date(cleaned.eagles$X.1, format = "%d-%b-%y")

# Renaming our subset
date <- cleaned.dates
# Creating a column of 1s
binary <- c(rep(1,length(cleaned.dates)))
# Creating a dataframe with a column of dates and 1s
completed.eagles <- data.frame(date,binary)



