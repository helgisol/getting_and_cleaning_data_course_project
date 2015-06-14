#Getting and Cleaning Data Course Project

This repository hosts the R code and documentation files for the Data Science's track course ["Getting and Cleaning data"] (https://class.coursera.org/getdata-015) project.

Input raw data set is taken from [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). It's described in [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Files

`run_analysis.R` is an R script that does the following:
- 1. Merges the training and the test sets to create one data set.
- 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- 3. Uses descriptive activity names to name the activities in the data set
- 4. Appropriately labels the data set with descriptive variable names. 
- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

`data_averages.txt` contains output tidy data set.

`CodeBook.md` describes the variables, the data, and any transformations or work that was performed to clean up the data.
