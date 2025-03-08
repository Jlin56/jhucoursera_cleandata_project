# jhucoursera_cleandata_project

This project prepares tidy data

Dataset of interest: Human Activity Recognition Using Smartphones Dataset

Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data full description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Files:

CodeBook.md - describes the variables, the data, and any transformations or work that I performed to clean up the data

run_analysis.R - performs transformation to clean up the data in the following manner:

1. Merges the training and the test sets to create one data set. The data are stored in "UCI HAR Dataset" and under "train" and "test" folder. I first merge all data for test and train seperately and then merge all together as "totaldata".

2. Extracts only the measurements on the mean and standard deviation for each measurement. From "totaldata", extract only columns for mean and std, and also the first 2 columns, which contains subject ID and activity labels.

3. Uses descriptive activity names to name the activities in the data set. Load the activity labels switch numerical activity labels with descriptive activity names

4. Appropriately labels the data set with descriptive variable names. Use gsub function and information from the features_info.txt.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

All original data can be found in the "UCI HAR Dataset"" directory, for memory storage purpose, the raw data is not uploaded in this repo.