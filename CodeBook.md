# Data, Analysis and Transformation Description - Course Assignment - Getting and Cleaning Data

This markdown explains the steps involved in analysing the data and putting together the end resutl, a tidy file.

## Data Description

The original data contain two set of three files each. The files are saved in working directory. Each set has following files
Set 1 (Test)
* x_test, the file containing raw data for 30 subjects on 6 activities;
* y_test, the file containing the names 6 activities
* subject_test, a file containing vector of subject identifiers correspnding to the measurements in first file.

Set 2 (Train) - This has the same structure as explained above for test files
* x_train, the file containing raw data for 30 subjects on 6 activities;
* y_train, the file containing the names 6 activities
* subject_train, a file containing vector of subject identifiers correspnding to the measurements in first file.

Data also includes features.txt file which contains the column header names for the 561 measurements in x_test.txt and y.train.txt files.

## Data Analysis
* The total count of rows in test set of files is 2947 and the count in  train set of files is 7352
* There is a total of 561 raw observations for each subject and activity combination.
* There are 33 variables that are average and same number that are standard deviations 
* Hence the output file will have total of 68 columns (1 subject id + 1 Activity Description + 33 Average + 33 Std Deviation)
* The final output dataset will be summarized as average of all 66 observations for each unique combination of subject and activity.

## Transformation Process