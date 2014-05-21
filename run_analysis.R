
library(data.table)


## This function takes two argumets to extract all *mean()* and *std()* measurements
## from specified dataset; append subject and activity to be returned 
## arugment datasetBaseDir: The base directory of the UCIHAR Data.
## argument datatype: specified dataset (test or train)
extractMeanStd <- function(datasetBaseDir,datatype){
  
 
  feature.dataSet <- read.table(paste(datasetBaseDir, "features.txt", sep=''))
                               
  raw.dataset <- read.table(paste(datasetBaseDir, datatype, "/X_",datatype,".txt", sep=''));
  feature.vector <- as.vector(feature.dataSet[,2])

  
  colnames(raw.dataset) <- feature.vector
  mean.dataset <- raw.dataset[,grepl(glob2rx('*mean()*'), colnames(raw.dataset))]
  
  
  std.dataset <- raw.dataset[,grepl(glob2rx('*std()*'), colnames(raw.dataset))]
  
  
  subject.dataset <- read.table(paste(datasetBaseDir, datatype, "/subject_",datatype,".txt", sep=''));
  colnames(subject.dataset) <- c("subject")
  
  activity.dataset <- read.table(paste(datasetBaseDir, datatype, "/y_",datatype,".txt", sep=''));
  activitylable.dataset <- read.table(paste(datasetBaseDir, "activity_labels.txt", sep=''))
  colnames(activity.dataset) <- c("activityid")
  colnames(activitylable.dataset) <- c("activityid","activity")
  activitymerged.dataset <- merge(activity.dataset,activitylable.dataset,by=c("activityid"))
  
  meanstd.dataset <-  cbind(subject.dataset,activitymerged.dataset,mean.dataset,std.dataset)
}



## This function takes two arguments to calculate the of specified column in the datatable
## It is returns a data table with subject, activityid, activity and all the mean() and std() columns
## arugment groupTbl: This table contains all values for specified subject and activity
## argument colVector: This specifies the columns that needs to have mean calculated.
calculateColMeans <- function(groupTbl, colVector){
  meanCols<-colMeans(groupTbl[, colVector])
  df <-as.data.frame(rbind(meanCols))
  dt <- data.table(df)
  dt.merged <-cbind(groupTbl[1,1:3],dt)  
}

## This function takes one argument to check number of rows with unqiue subject and activity combinations
## This is used mainly for troubleshoot and validation
getUniqueActivityPerSubject<- function(dataset){
  dataset.unqiue<-dataset[!duplicated(dataset[1:2]),]
  dataset.unqiue.sorted <- dataset.unqiue[ order(dataset.unqiue[,1], dataset.unqiue[,2]), ]
  #print(dataset.unqiue.sorted)
  
}

## This main program takes one argument where it specifies the data directory.
## It assumes the data directory follows the unzipped data source.
## $yourdatasouce
##               - test\X_text.txt
##               - test\y_text.txt
##               - test\subject_text.txt
##               - train\X_text.txt
##               - train\y_text.txt
##               - train\subject_train.txt
##               - activity_lables.txt
##               - features.txt
## This main program first extract all the mean() and std() from train and test dataset
## The merged dataset will be written out to $yourdatasouce/FirstExtractMeanStdData.txt
## The FirstExtractMeanStdData.txt will be used to calculate the average of 
## each variable for each activity and each subject.
## The result dataset will be written out to $yourdatasouce/SecondIndependentTidyData.txt
mainprogram <-function(UCIHARDatasetBaseDir){

  test.DataSet <- extractMeanStd(UCIHARDatasetBaseDir,"test")
  getUniqueActivityPerSubject(test.DataSet[,1:2])
  train.DataSet <- extractMeanStd(UCIHARDatasetBaseDir,"train")
  getUniqueActivityPerSubject(train.DataSet[,1:2])
  merged.Dataset <- rbind(test.DataSet,train.DataSet)
  write.table(merged.Dataset, file=paste(UCIHARDatasetBaseDir, "FirstExtractMeanStdData.txt", sep='')
              ,append=FALSE,sep=" ",row.names=FALSE)
  getUniqueActivityPerSubject(merged.Dataset[,1:2])
  
  print(paste("Number of rows in the Merged Dataset: ",nrow(merged.Dataset),sep=" "))
  
  numofCol <- ncol(merged.Dataset)
  print(paste("Number columns in the Merged Dataset: ",numofCol,sep=" "))
  
  
  col.vector <-c(4:numofCol)
  groupBy <-list(merged.Dataset$subject,merged.Dataset$activityid)
  splited.list <- split(merged.Dataset, groupBy)
  print(paste("Number of splitted list ", length(splited.list)))
  
  l<-lapply(splited.list, function(x)  calculateColMeans(x,col.vector)  )

  result<-as.data.frame(do.call(rbind, l))
  result.dataset<-data.table(result, keeprowname=FALSE)
  result.completecase.dataset <- result.dataset[complete.cases(result.dataset),]
  write.table(result.completecase.dataset, file=paste(UCIHARDatasetBaseDir, "SecondIndependentTidyData.txt", sep='')
              ,append=FALSE,sep=" ",row.names=FALSE)

}
