---
title: "CodeBook"
author: "DamoLlama"
date: "07/11/2021"
output: html_document
---

This 'CodeBook' file describes transformation performed on the "Human Activity Recognition Using Smartphones Dataset Version 1.0".

Output of the transfomation is a text file tidy data set that:
1. Merged the training and the test sets, including only the mean and standard deviation for each measurement.
2. Grouped the data by activity and subject (participant) then summarised the 
mean and standard deviation observations.

The following files are included in both tidy data sets
(location provided relative to working directory)

- 'data/features.txt': List of all features.
- 'data/activity_labels.txt': Links the class labels with their activity name.
- 'data/train/X_train.txt': Training set.
- 'data/train/y_train.txt': Training labels.
- 'data/test/X_test.txt': Test set.
- 'data/test/y_test.txt': Test labels.

Dataset output - 'wearablecomputing_output.txt'
Variables  
'participant_number': number assigned for each participant used to mask names values 1:30  
'activity': six activities that participants were measured performing  
columns 3-68: all measurements as described in 'data/features_info.txt' 

Transformations  
train and test data sets both have additional columns added for subjects code and activity of each measurement and then combined into one data set.  
Meaningful labels are added for all columns, 3:68 labelled using descriptions in 'data/features.txt'  
Values of activity column are substituted from 'data/activity_labels.txt' to text descriptions rather than numbers 1 to 6.  
Subjects codes are left as numbers as it's not appropriate to use real names for privacy.  
The data set is grouped by subject_code and activity, then each column 3:68 is summarised as a mean() on the grouping. the text "average_" is added to the start of each column name as the column is an average of the original data. 
