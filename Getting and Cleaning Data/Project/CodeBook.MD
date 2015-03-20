### CodeBook
This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

### The original data source

- Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Original Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### The original data
The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

### Tidy data
The file 'tidy_data.txt' contains the mean of all mean and standard deviation variables from the original data set group by activity and subject.
30 subjects performing 6 activity produces 180 mean observation of 79 variable (mean or std features)

### Transformation Steps
1. Read activity data from `activity_labels.txt` into `activities_labels`
2. Read features data from `features.txt` into `features`
3. Using grepl to extract the logical vector `mean_and_std_features` indicating features that have "mean" and "std" in them
3. Read observation data from `X_test.txt`, `Y_test.txt`, `X_train.txt`, `Y_train.txt` into `X_test_data`, `Y_test_data`, `X_train_data`, `Y_train_data` respectively
4. Read subject reference id from `subject_test.txt`, `subject_train` into `subject_test_data`, `subject_train_data` and naming the columns
4. subset `X_test_data` and `X_train_data` by column  using `mean_and_std_features` logical vector
5. Denormalise `Y_test_data` and `Y_train_data` respectively using `inner_join` to `activities_labels` and naming the columns
5. Combine ,`Y_test_data`, `subject_test_data`, `X_test_data` using cbind into `test_data`
6. Combine ,`Y_train_data`, `subject_train_data`, `X_train_data` using cbind into `train_data`
7. combine `test_data` and `train_data` using rbind into `data`
8. Using `dplyr` to tidy and compute the mean of each grouping of `data` by activity and subject
9. Write output to `tidy_data.txt` 
