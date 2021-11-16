# WearableComputing
# script - run_analysis.R

Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

See 'data/README.txt'for information on the original data. All data for this project is sourced from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and is located in the data folder of this R Project 'WearableComputing'

See 'CodeBook.md' for description of data transformation in this project.

One R script called run_analysis.R that does the following: 

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
This second dataset is written to a file named 'wearablecomputing_output.txt' on the same working directory