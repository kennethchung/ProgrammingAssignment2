### Introduction

This programming assignment will make use of data from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
to 
- 1) Merges the training and the test sets to create one data set.
- 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
- 3) Uses descriptive activity names to name the activities in the data set
- 4) Appropriately labels the data set with descriptive activity names. 
- 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


There are three deliverables in this assignment
- 1) a tidy data set as described as above
- 2) CodeBook.md describes the variables, the data, and any transformations or any works
- 3) run_analysis.R program

### Running
- 1) Source the run_analysis.R such as source("c:/mytestdirector/run_analysis.R")
- 2) Set your current working directory to c:/mytestdirector
- 3) Unzip the getdata_projectfiles_UCI HAR Dataset.zip to  current working directory. The unzip data where the root the data directory should have the following directory hierarchy
* your data source base directory has the followings:

*         test\X_text.txt
   
*         test\y_text.txt

*         test\subject_text.txt

*         train\X_text.txt
   
*         train\y_text.txt
 
*         train\subject_train.txt
   
*         activity_lables.txt
   
*         features.txt

- 4) Run mainprogram("./$yourdatasouce")
 
* Expected outcome
- [1] "Number of rows in the Merged Dataset:  10299"
- [1] "Number columns in the Merged Dataset:  69"
- [1] "Number of splitted list  180"
- The following two files will be generated
- $yourdatasouce/SecondIndependentTidyData.txt (~51KB)
- $yourdatasouce/FirstExtractMeanStdData.txt (~7.9MB)
 
 
               
   
