CookBook
========================================================

This cookbook describes the variables, the data, transformation and other work that create a tidy data set wtih the average of each mean and standard deviation for each activitiy and subject in Human Activity Recognition Using Smartphones Dataset
This data set can downlowded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 



### Data

The experiments have been carried out with a group of 30 volunteers, collected and archived in the above zip file. Each person performed six
activities described in one of the zipped files. The cleanning of Inertial sigals regarding time and frequency domain data inside the
test/Inertial and train/Inertial folders are NOT the scope of this assigment.

Only the following data from the above unzipped files  will be used

* Activity data from activity_labels.txt
  * The activity_labels containts activitiy ids and names

* Features data from features.txt
  * This contains the training and test measurement types ids and names
  

* Training Data
  * This train/X_train.txt contains all data from training subjects
  
* Test Data
  * This test/X_test.txt contains all data from test subjects
  
* Test Subject data from test/subject_train.txt  
  * This contains all subjects associated with the each row archived in train/X_train.txt

* Training Subject data from train/subject_test.txt  
  * This contains all subjects associated with the each  record archived in test/X_test.txt
  
* Test activity data from test/y_test.txt  
  * This contains all activities associated with the each  record archived in test/y_test.txt


* Training activity data from train/y_train.txt  
  * This contains all activities associated with the each  record archived in train/y_train.txt

### Variables and libraries
The following variables are used and extracted from various files

* Any Std() and Mean() measurements from train/X_train.txt and test/X_test.txt. See features_info.txt for detail description of all measurements collected in the archives
* Activity names from activity_labels.txt
* Subject IDs from test/subject_train.txt  and train/subject_test.txt  
* activity IDs from train/y_test.txt and test/y_test.txt   

"datasets" and "data.table" libraries are expected to installed and loaded.
result.completecase.dataset dataset contains the final output for the average of each mean and standard deviation for each activitiy and subject. This dataset is written out to [thebasedatasetdir]/SecondIndependentTidyData.txt

There is an intermedidate dataset that contains merged data from Test,Training, Activity and Std() and mean() Features data.
This datadata is written out to [thebasedatasetdir]/FirstExtractMeanStdData.txt

The following transformation section describes how these individual dataset being merged.

### Transformation
The following steps are executed in order to generate average of each mean and standard deviation for each activitiy and subject 

#### 1 Merges the training and the test sets to create one data set.

*     Perform cbind (column combine) on the following data subject_train, y_train, X_train.txt
*     Perform cbind (column combine) on the following data subject_test, y_text, X_text.txt
*     Perform rbind (row combine) on the above two result data set

####  2 Extracts only the measurements on the mean and standard deviation for each measurement.  

*     Perform subset of the above data with raw.dataset[,grepl(glob2rx('*std()*'), colnames(raw.dataset))]
       and raw.dataset[,grepl(glob2rx('*mean()*'), colnames(raw.dataset))]

####  3 Uses descriptive activity names to name the activities in the data set

*    Perform merge with activity_labels and step 2 dataset. This becomes the first dataset and being written out as FirstExtractMeanStdData.txt

####  4. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

*     Perform split on step 3 dataset to group the data by subject and activity.
*     Perform lapply on the splitted (groupby) dataset to calculate the mean for each std and mean feature columns. This becomes the final dataset and being written out as SecondIndependentTidyData.txt



