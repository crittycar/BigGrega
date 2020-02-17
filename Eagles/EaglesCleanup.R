# We load in Eagles Football Club data from the timeframe we are examining
Eagles2006 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2006.csv")
Eagles2007 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2007.csv")
Eagles2008 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2008.csv")
Eagles2009 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2009.csv")
Eagles2010 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2010.csv")
Eagles2011 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2011.csv")
Eagles2012 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2012.csv")
Eagles2013 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2013.csv")
Eagles2014 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2014.csv")
Eagles2015 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2015.csv")
Eagles2016 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2016.csv")
Eagles2017 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2017.csv")
Eagles2018 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2018.csv")
Eagles2019 <- read.csv("C:/Users/Jack Dewey/Downloads/Eagles2019.csv")

# Binding all dataframes into one
AllEagles <- rbind.data.frame(Eagles2006, Eagles2007, Eagles2008, Eagles2009,
                              Eagles2010, Eagles2011, Eagles2012, Eagles2013,
                              Eagles2014, Eagles2015, Eagles2016, Eagles2017,
                              Eagles2018, Eagles2019)

# Cleaning functions - removing header rows and changing date format.
AllEagles<-AllEagles[!(AllEagles$X=="Day"),]
AllEagles <- as.Date(AllEagles$X.1, format = "%d-%b-%y")
# Renaming our subset
Date <- AllEagles
# Creating a column of 1s
Binary <- c(rep(1,length(AllEagles)))
# Creating a dataframe with a column of dates and 1s
EmptyEagles <- data.frame(Date,Binary)



