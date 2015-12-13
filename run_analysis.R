## Getting and cleaning data course project

## Set up
library(dplyr)
library(reshape2)

## Download the dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "Dataset.zip")

## Unzip the dataset
unzip("Dataset.zip")

## Read files into the workspace
activity_table <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activityType"))
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("featureId", "feature"))
train.set <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.labels <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activityId")
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subjectId")
test.set <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.labels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activityId")
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subjectId")

## 1. Merge the training and the test sets to create one data set.
train <- cbind(train.subject, train.labels, train.set)
test <- cbind(test.subject, test.labels, test.set)
full.set <- rbind(train, test)

## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
match <- grep(".*mean.*|.*std.*", features$feature)
colNames <- as.character(features$feature[match])
full.set <- select(full.set, c(1,2, match + 2))

## 3. Use descriptive activity names to name the activities in the data set.
full.set <- merge(activity_table, full.set, by = "activityId")
full.set <- arrange(full.set, subjectId)

## 4. Appropriately label the data set with descriptive variable names.
colNames <- gsub("\\()", "", colNames)
colNames <- gsub("-", "", colNames)
colNames <- gsub("mean", "Mean", colNames)
colNames <- gsub("meanFreq", "MeanFrequency", colNames)
colNames <- gsub("std", "StdDev", colNames)
colNames <- gsub("^t", "time", colNames)
colNames <- gsub("^f", "freq", colNames)
colnames(full.set)[-c(1:3)] <- colNames

## 5.From the data set in step 4, create a second, independent tidy data set with 
## the average of each variable for each activity and each subject.
full.set <- full.set[,-1]
full.set.melted <- melt(full.set, id = c("activityType", "subjectId"))
full.set.mean <- dcast(full.set.melted, subjectId + activityType ~ variable, mean)

## Write final data
write.table(full.set.mean, "finalData.txt", row.names = FALSE, quote = FALSE)