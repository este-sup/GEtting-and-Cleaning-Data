
run_analysis <- function() {
    # Set the working directory to the course  
  setwd("C:/WorkSpace/RProject/Getting and Cleaning Data")
  
  library(data.table)
  library(dplyr)
  
  print("Final Project Getting and Cleaning Data")
  
  if(!file.exists("./data")){dir.create("./data")}
  
  print("Reading data files")
  #Read names an labels
  featureNames <- read.table("./data/UCI HAR Dataset/features.txt")
  activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE)
  View(featureNames)
  View(activityLabels)
  
  #Read the test data
  subjectTestData <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
  activityTestData <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
  featuresTestData <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
 
   #Read the training data
  subjectTrainData <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  featuresTrainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
  activityTrainData <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
  
  #1.	Merges the training and the test sets to create one data set.
  print("1. Merging the training and test data sets to create one data set")
  mergedSubjectData <- rbind(subjectTrainData, subjectTestData)
  mergedActivityData <- rbind(activityTrainData, activityTestData)
  mergedFeaturesData <- rbind(featuresTrainData, featuresTestData)

  colnames(mergedFeaturesData) <- t(featureNames[2])
  colnames(mergedActivityData) <- "Activity"
  colnames(mergedSubjectData) <- "Subject"
  completeMergedData <- cbind(mergedFeaturesData,mergedActivityData,mergedSubjectData) 
  View(completeMergedData)   
  
  #2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
  print("2. Extracting the measurements on the mean and standard devication for each measurement")
  columnsWithMeanAndSTD <- grep(".*Mean.*|.*Std.*", names(completeMergedData), ignore.case=TRUE)
  View(columnsWithMeanAndSTD)
  requiredColumns <- c(columnsWithMeanAndSTD, 562, 563)
  View(requiredColumns)
  dim(completeMergedData)
  extractedData <- completeMergedData[,requiredColumns]
  View(extractedData)
  dim(extractedData)
  
  
  
  #3.	Uses descriptive activity names to name the activities in the data set
  print ("3. Using descriptive activity names to name the activities in the data set")
  extractedData$Activity <- as.character(extractedData$Activity)
  for (i in 1:6)
    {
    extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
    }
  extractedData$Activity <- as.factor(extractedData$Activity)
  
  #4.	Appropriately labels the data set with descriptive variable names. 
  print("4. Labeling data set with descriptive variable names")
  names(extractedData)
  names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
  names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
  names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
  names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
  names(extractedData)<-gsub("^t", "Time", names(extractedData))
  names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
  names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
  names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
  names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
  names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
  names(extractedData)<-gsub("angle", "Angle", names(extractedData))
  names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))
  names(extractedData)
  
 #5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  print("5. creating a second, independent tidy data set with the average of each variable for each activity and each subject.")
  extractedData$Subject <- as.factor(extractedData$Subject)
  extractedData <- data.table(extractedData)
  tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
  tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
  write.table(tidyData, file = "./data/UCI HAR Dataset/Tidy.txt", row.names = FALSE)
   
  }



