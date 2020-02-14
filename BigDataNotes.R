EaglesPlayoffs <- read.csv("C:/Users/Jack Dewey/Downloads/EaglesPlayoffs.csv")
philly <- read.csv("C:/Users/Jack Dewey/Downloads/incidents_part1_part2.csv")


##  THIS WORKS TO CHANGE DATE
EaglesPlayoffs <- read.csv("C:/Users/Jack Dewey/Downloads/EaglesPlayoffs.csv")
Test.eag <- EaglesPlayoffs
sorta.work.date <- Test.eag
sorta.work.date2 <- as.Date(Test.eag$X.1, format = "%d-%b-%y")
print(sorta.work.date2)


sorta.work.date$X.1 <- sorta.work.date2 
## REST IS GARBAGE USE THIS ^^


# Now trying to subset
datetxt <- crime$dispatch_date
datetxt <- as.Date(datetxt)
df2 <- data.frame(date = datetxt,
                 year = as.numeric(format(datetxt, format = "%Y")),
                 month = as.numeric(format(datetxt, format = "%m")),
                 day = as.numeric(format(datetxt, format = "%d")))

philly.date <- cbind.data.frame(crime,df2)

# Working on subsetting by month THIS DOESNT WORK YET


test.group <- factor(format(combined.sorta$timestamp, "%m"),
                        levels = month)
month.bot <- for(month in unique(combined.sorta$month)){
  month.sub <- combined.sorta$month == 1
}


# SUbsetting Our Big Philly set THIS WORKS
datetxt <- philly$X.1
datetxt <- as.Date(datetxt)
df <- data.frame(date = datetxt,
                 year = as.numeric(format(datetxt, format = "%Y")),
                 month = as.numeric(format(datetxt, format = "%m")),
                 day = as.numeric(format(datetxt, format = "%d")))









# THIS IS ALL GARBAGE


tst <- EaglesPlayoffs$X.1(c("Jan","Feb"))
match(tst,month.abb)
EaglesPlayoffs <- c("Jan","Feb")
 match(EaglesPlayoffs,month.abb)

 df <- data.frame(X.1 = "")
 
Test.eag <- EaglesPlayoffs
 

Test.eag <- Test.eag$X.1(c("Jan","Feb")
  match(tst,month.abb))


strptime(Test.eag$X.1,format="%Y-%m-%d")


mm <- c("Jan","Dec","jan","Mar","Apr")

sapply(mm,function(x) grep(paste("(?i)",x,sep=""),month.abb))


date <- strptime(Test.eag$X.1, "%Y-%m-%d")

ugh <- c("2018-Feb-05", "2017-Jan-03")


Test.eag3 <- format(Test.eag2$X.1, format = "%Y %m, %d")
