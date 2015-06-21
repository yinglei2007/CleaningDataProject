install.packages("dplyr")
library(dplyr)
install.packages("data.table")
library(data.table)
## Now set up data frames for each data file
testData <- data.frame
trainData <- data.frame
test_trainData <- data.frame
subject_test <- c()
subject_train <- c()
testFeature <- c()
trainFeature <- c()
activity_labels <- data.frame
features <- data.frame
## read txt files to corresponding data frames
testData <- read.table("x_test.txt")
trainData <- read.table("x_train.txt")
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
testFeature <- read.table("y_test.txt")
trainFeature <- read.table("y_train.txt")
activity_labels <- read.table("activity_labels.txt", header=FALSE)
feature <- read.table("features.txt")
## add features from table "feature" to testData and trainData table 
## column name
dataCol <- feature[,2]
## make unique column name
dataCol <- as.character(dataCol)
dataCol <- make.unique(dataCol)

## subject information
subject_total <- rbind(subject_test, subject_train)
## activity information
activity_total <- rbind(testFeature, trainFeature)


## step 1: merge testData and trainData
## new data set is named "test_trainData"

test_trainData <- rbind(testData, trainData)
## add column name to test_trainData
colnames(test_trainData) <- dataCol
## add "Subject" column to test_trainData
test_trainData$Subject <- subject_total[,1]
## add "Activity" column to test_trainData
test_trainData$Activity <- activity_total[,1]
## write test_trainData to test_trainData.txt
write.table(test_trainData, "test_trainData.txt")

## Step2: Extracts only the measurements on the mean and SD for each measurements
## New data set name is measure_data
measure_data <- data.frame()
measure_data <- test_trainData[grep("mean()|std()", names(test_trainData))]
## get rid of columns with "Freq"
measure_data <- measure_data[-grep("Freq()", names(measure_data))]
write.table(measure_data, "measure_data.txt")

## Step3: use descriptive names to name activity in the data set
## add subject information to measure_data
measure_data$Subject <- subject_total[,1]
## add activity information to measure_data
measure_data$Activity <- activity_total[,1]
## get value from activity_labels
measure_data$Activity[measure_data$Activity==1] <- "WALKING"
measure_data$Activity[measure_data$Activity==2] <- "WALKING_UPSTAIRS"
measure_data$Activity[measure_data$Activity==3] <- "WALKING_DOWNSTAIRS"
measure_data$Activity[measure_data$Activity==4] <- "SITTING"
measure_data$Activity[measure_data$Activity==5] <- "STANDING"
measure_data$Activity[measure_data$Activity==6] <- "LAYING"
write.table(measure_data, "measure_data.txt")

## Step4: Appropriately labels the data set with descriptive variable names. 
## Column names were already added to the data set in step1 with feature.txt
colnames(measure_data)

## Step5: From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
by_activity_subject <- group_by(measure_data, Subject, Activity)
meanValue <- summarise_each(by_activity_subject, funs(mean))
write.table(meanValue, "meanValue.txt", row.name=FALSE)
