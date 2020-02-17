<<<<<<< HEAD
# years of playoff data we have
years <- c(2006:2019)

# empty vector that will contain the file names of the data
file.name <- c(rep(NA, length(years)))

# below we create a vector that contains all the file names we want to read
for(i in 1:length(years))
  file.name[i] <- paste("Eagles", years[i], ".", "csv", sep = "")





# We load in Eagles Football Club data from the timeframe we are examining
Eagles2006 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2006.csv", sep = ""),
                  stringsAsFactors = FALSE)
Eagles2007 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2007.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2008 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2008.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2009 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2009.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2010 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2010.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2011 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2011.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2012 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2012.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2013 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2013.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2014 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2014.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2015 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2015.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2016 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2016.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2017 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2017.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2018 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2018.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2019 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2019.csv", sep = ""),
                       stringsAsFactors = FALSE)

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
CompletedEagles <- data.frame(Date,Binary)



=======
# We load in Eagles Football Club data from the timeframe we are examining
Eagles2006 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2006.csv", sep = ""),
                  stringsAsFactors = FALSE)
Eagles2007 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2007.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2008 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2008.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2009 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2009.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2010 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2010.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2011 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2011.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2012 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2012.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2013 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2013.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2014 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2014.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2015 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2015.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2016 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2016.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2017 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2017.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2018 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2018.csv", sep = ""),
                       stringsAsFactors = FALSE)
Eagles2019 <- read.csv(paste(data.path, "/", "Eagles", "/", "Eagles2019.csv", sep = ""),
                       stringsAsFactors = FALSE)

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
CompletedEagles <- data.frame(Date,Binary)


# Writing subset function
PlayoffFunction <- function(id){
  df[df[["Week"]] == id,]
}
f1(11)
getwd()

# Loading data
setwd(("C:/Users/Jack Dewey/Documents/GitHub/BigGrega/Eagles"))
temp <- list.files(pattern="*.csv")
for (i in 1:length(temp)) assign(temp[i], read.csv(temp[i]))


>>>>>>> 4bf0bdd334a30e245707bbb2db7b8ef8446494ec
