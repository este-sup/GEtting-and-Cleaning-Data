Code Book
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.
The data was obtained from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for the project is located here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

1 Question 1: Variables and transformations
* activityLabels - The label of the activity performed when the corresponding measurements were taken
The values are:
WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* featureNames – The names of all the features
The values contain 561 entries e.g. tBodyAcc-mean()-X, tBodyAcc-mean()-Y, …
* subjectTestData – Contains the data from the subject_test.txt file
* activityTestData – Contains the data from the y_test.txt file
* featuresTestData – Contains the data from the X_test.txt file
* subjectTrainData – Contains the data from the subject_train.txt file
* featuresTrainData – Contains the data from the X_train.txt file
* activityTrainData – Contains the data from the y_train.txt file
* mergedSubjectData – Contains the merged train data which was created using the rbind function
* mergedActivityData - Contains the merged activity data which was created using the rbind function
* mergedFeaturesData- Contains the merged features data which was created using the rbind function
* completeMergedData – Contains the merged data from mergedSubjectData, mergedActivityData, mergedFeaturesData


2 Question 2: Variables and transformations
* columnsWithMeanAndSTD – contains only the columns that have “Mean” and “Std” text
* requiredColumns – contains the columns that contain the mean and std
* extractedData – contains the merged data with mean and std column

  3. Question 3: Variables and transformations
* extractedData$Activity – clean the activity column in the extractedData set to use descriptive activity names 

  4. Question 4: Variables and transformations
* extractedData - We clean the column names of the subset. The () is removed from mean() and std() as wel;l as “-“.  We also capitalize the M and S in mean and std.

  5. Question 5: Variables and transformations
   tidyData – contains the tidy data set that is then stored in the Tidy.txt file with the average of     	each variable for each activity and each subject
