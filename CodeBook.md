# Getting and cleaning data course project

## Description
The project's objective is to merge 2 data sets taken from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
A full description is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Data set information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained data set has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Data transformation
1. Read the following files into R:
  * activity_labels.txt
  * features.txt
  * train/X_train.txt
  * train/y_train.txt
  * train/subject_train.txt
  * test/X_test.txt
  * test/y_test.txt
  * test/subject_test.txt
2. Merge the train and the test set to create one unified data set
 * First merge each set with its corresponding subject and activity IDs using cbind.
 * Merge the 2 resulting sets by using rbind.
3. Extract only the measurements on the mean and standard deviation for each measurement.
 * Use grep to find all measurements with mean and std.
 * Use dplyr's select to select only these variables in the full data set.
4. Use descriptive activity names to name the activities in the data set.
 * Merge the activity labels and full data set using merge()
5. Appropriately label the data set with descriptive variable names.
 * Use gsub to replace ambiguous text with descriptive equivalents.
6. Create an independent tidy data set with the average of each variable for each activity and each subject.
 * Use the reshape2 package's melt and dcast to create such data set.
7. Write the final data into a text file as instructed.
