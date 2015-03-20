# Getting and Cleaning Data Course Project

#### How to use `run_analysis.R`
1. Ensure that `UCI HAR Dataset` content is available in your working directory
2. Ensure that `run_analysis.R` in your working directory
3. Run `source("run_analysis.R")`, then it will generate a new file tiny_data.txt in your working directory.

#### Dependencies
1. `run_analysis.R` downloads and unzip `UCI HAR Dataset` to your working directory if you have not done so to ensure repeatable results
2. `run_analysis.R` file requires `dplyr` and will install the dependencies automatically if not installed

#### Transformation Steps
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
