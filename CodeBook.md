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
* Step 1 - Read feature.text files to get variable names 
* Step 2A - Read x_test file and assign col.names from the file read in step1
* Step 2B - Read y_test, add a column with activity description corresponding to activities
	+ 1 - Walking
	+ 2 - Climbing Stairs
	+ 3 - Climbing Downstairs
	+ 4 - Running
	+ 5 - Sitting
+ 6 - Laying
* Step 2C - Read subject_Test file
* Step 2D - Merge (cbind) three files transformed in step 2, 3 and 4
* Step 3 - Repeat step 2A through 2D for training set of files
* Step 4 - Merge (rbind) files created in step 2D and step 3
* Step 5A - Use which command to get the indices of subject id and activity description
* Step 5B - Use sqldf function to find indices of variable names that contain mean or std in the name
* Step 5C - Use select function to select columns corresponding to indices identified in above 2 steps
* Step 6 - Use melt and dcast function to slice and summarize data
* Step 7 - Write the dataset created in step6 into TidyData.txt file using write.table
