
## Please ensure following packages are installed
## sqldf; dplyr; plyr 

#################################################################################################################
## 1. Read the variable name file
#################################################################################################################
FeatureNames <- read.table("features.txt", col.names=c("SeqNo","VarName" ))

#################################################################################################################
## 2. Read all three test files, define meaningful variable names and activity codes, cbind files
#################################################################################################################
## Step 2A. Read Test Data. Assign Variable names to the columns
TestData <- read.table("./test/X_test.txt", col.names = FeatureNames$VarName) 

## Step 2B. Read Test Lables, name the column as "Activity Code" and add a meaningful activity description
TestLables <- read.table("./test/Y_test.txt", col.name = "ActivityCode")
TestLables$ActivityDesc[TestLables$ActivityCode==1] <- "Walking"
TestLables$ActivityDesc[TestLables$ActivityCode==2] <- "Climbing Stairs"
TestLables$ActivityDesc[TestLables$ActivityCode==3] <- "Climbing Downstairs"
TestLables$ActivityDesc[TestLables$ActivityCode==4] <- "Sitting"
TestLables$ActivityDesc[TestLables$ActivityCode==5] <- "Standing"
TestLables$ActivityDesc[TestLables$ActivityCode==6] <- "Laying"

## Step 2C. Read Test Subjects, name the column as "Subject ID"
TestSubjects <- read.table("./test/subject_test.txt", col.name="SubjectID")

## Step 2D. Merge three test files (Subject, Activity and Measurement Data file)
CompleteTestData <- cbind(TestSubjects, TestLables, TestData)


#################################################################################################################
## 3. Read and merge all three training files. Define activity descriptions and meaningful variable names
#################################################################################################################
## Step 2A. Read Train Data, assign variable names to the columns from the feature file
TrainData <- read.table("./train/X_train.txt", col.names=FeatureNames$VarName) 

## Step 3B. Read Train Lables, name the column as "Activity Code" and give meaning ful name to activities
TrainLables <- read.table("./train/Y_train.txt", col.name="ActivityCode")
TrainLables$ActivityDesc[TrainLables$ActivityCode==1] <- "Walking"
TrainLables$ActivityDesc[TrainLables$ActivityCode==2] <- "Climbing Stairs"
TrainLables$ActivityDesc[TrainLables$ActivityCode==3] <- "Climbing Downstairs"
TrainLables$ActivityDesc[TrainLables$ActivityCode==4] <- "Sitting"
TrainLables$ActivityDesc[TrainLables$ActivityCode==5] <- "Standing"
TrainLables$ActivityDesc[TrainLables$ActivityCode==6] <- "Laying"

## Step 3C. Read Train Subjects, name the column as "Subject ID"
TrainSubjects <- read.table("./train/subject_train.txt", col.name="SubjectID")

## Step 3D. Merge three train files (Subject, Activity and Measurement Data file)
CompleteTrainData <- cbind(TrainSubjects, TrainLables, TrainData)


#################################################################################################################
## Step 4 Merge two datasets (rbind) created in above in steps 1D and 2D
#################################################################################################################
CompleteExperimentData <- rbind(CompleteTestData, CompleteTrainData)


#################################################################################################################
## Step 5. Get following columns in a vector
## 1. SubjectID (Subject Identifier)
## 2. ActivityDesc (Activity Description)
## 3. All variable names containing text 'std()'
## 4. All variable names containing text 'mean()'
#################################################################################################################

AllColNames <- names(CompleteExperimentData)
SubID <- which(AllColNames== "SubjectID")
ActDesc <- which(AllColNames== "ActivityDesc")
StdVars <- sqldf("Select VarName from FeatureNames where VarName like '%std()%'")
MeanVars <- sqldf("Select VarName from FeatureNames where VarName like '%mean()%'")

ColumnsNeeded <- c(SubID, ActDesc, StdVars$VarName, MeanVars$VarName)

## Extract all columns corresponding to above indices
PreTidyDataSet <- select(CompleteExperimentData, ColumnsNeeded)


#################################################################################################################
##  Step 6. Use melt and dcast function to summarize data based on Subject, Activity and Mean of all std and mean variables chosen before
#################################################################################################################
MeltedData <- melt(PreTidyDataSet, id=c(1,2),measure.vars=c(3:68))
FinalTidyData <- dcast(MeltedData, SubjectID + ActivityDesc ~ variable, mean)


#################################################################################################################
## Step 7. Write file to a text file
#################################################################################################################
write.table(FinalTidyData, "TidyData.txt", row.name=FALSE)


