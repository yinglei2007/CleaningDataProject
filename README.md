# CleaningDataProject
In this project, data sets provided information about
1, measurements (x_test, x_train)
2, name of measurements (features)
3, subject information (subject_test, subject_train)
4, activity information (y_test, y_train, activity_label)

For Step1:
To merge test and train measurements, I used rbind() to combine x_test and x_train data sets and created test_trainData. 
Then, I extracted name of measurements from features and applied as column names to test_trainData.
To add subject information, I used rbind() to combine subject_test and subject_train and created subject_total.
Then, I added subject_total as a new column named "Subject" to test_trainData to add subject information.
To add activity information, I used rbind() to combine y_test and y_train and created activity_total.
Then, I added activity_total as a new column named "Activity" to test_trainData to add subject information. The dimension of test_trainData is 10299 rows (observations), 563 columns (varivables)

For Step2:
To extract only the measurements on the mean and standard deviation for each measurement, I used 
grep() to get all column names contains "mean()" and "std()", then used -grep() to get rid of "meanFreq()".
Data is stored in measure_data with 66 variables.

For Step3:
To substitute activity code for readable names, I relaced code with descriptive name according to activity_labels.
Data is stored in measure_data


For Step4:
To label the dataset with descriptive variable names, I already applied "features" as column names for test_trainData.
Column names are inhereted by measure_data.

For Step5:
From the data set in step 4, to create a second, independent tidy data set with the average of each variable for each activity and each subject, I grouped measure_data with group_by for "Subject" and "Activity" and created a new dataset named "by_activity_subject"; then I used "summarise_each" for "by_activity_subject" to get mean of each variable and created a new dataset called "meanValue" and exported as "meanValue.txt" which contains 180 rows (30 subjects with 6 activities) and 68 columns (68 variables, 66 mean value of measurements, plus Subject and Activity columns)
