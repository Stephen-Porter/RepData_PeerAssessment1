library(dplyr)
library(lubridate)
library(ggplot2)

## Download the data file from the internet and unzip it
zipfile <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(url,zipfile)
unzip(zipfile)
unlink(zipfile)

## Read in Csv file
act <- read.csv("activity.csv")

## Examine the contents to the file with head
head(act)
## Convert data frame to dplyr format
act <- tbl_df(act)
## Convert the date column to an actual date
act <- mutate(act, date = ymd(date))

daily_steps <- act %>%
                    filter(!is.na(steps)) %>%
                    group_by(date) %>%
                    summarise(totalsteps= sum(steps))

hist(daily_steps$totalsteps, 
     xlab = "Total Steps per Day", main="Frequency of Steps")

mean(daily_steps$totalsteps)
median(daily_steps$totalsteps)
