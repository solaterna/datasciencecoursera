# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Check and install dplyr if not installed
if(!require("dplyr")) {
  install.packages("dplyr")
}

# Load dplyr
require(dplyr) 

# Download if file not exist
if(!file.exists("UCI HAR Dataset")) {
  
  cat("cannot locate HCI HAR Dataset, proceed to download...\n")
  # Download from source
  download.file(method = "curl",
    url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
    destfile=paste(getwd(),"/test.zip",sep = "")
  ) 
  
  # Unzip file
  unzip("test.zip")
  
  # Remove zip file
  file.remove("test.zip")
}

# Preparing Activity Labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Preparing Feature for variable names
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Using grepl to identify only variable which contains the text mean or std in the variable name
mean_and_std_features <- grepl("mean|std", features)

# Processing x_test data from X_test.txt and y_test data from Y_test.txt
cat("reading test and train data...\n")
x_test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test_data <- read.table("./UCI HAR Dataset/test/Y_test.txt")
# Processing x_train data from X_train.txt and y_train data from Y_train.txt
x_train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train_data <- read.table("./UCI HAR Dataset/train/Y_train.txt")

# Processing subject_test data from subject_test.txt
subject_test_data <- read.table("./UCI HAR Dataset/test/subject_test.txt")
# Processing subject_train data from subject_train.txt
subject_train_data <- read.table("./UCI HAR Dataset/train/subject_train.txt")
cat("test and train data loaded...\n")

# Naming subject_test data
names(subject_test_data) = "subject_id"
# Naming subject_train data
names(subject_train_data) = "subject_id"

# Naming x_test_data variables with all features
names(x_test_data) = features
# Naming x_train_data variables with all features
names(x_train_data) = features

# using the mean_and_std_features logical vector to select variables from X_test
x_test_data = x_test_data[, mean_and_std_features]
# using the mean_and_std_features logical vector to select variables from X_train
x_train_data = x_train_data[, mean_and_std_features]

# Adding activity labels to y_test_data activity reference 
# y_test_data2 <- merge(y_test_data, activity_labels, by="V1", sort = 0)
y_test_data2 <- inner_join(y_test_data, activity_labels, by="V1")
# Adding activity labels to y_train_data activity reference
# y_train_data2 <- merge(y_train_data, activity_labels, all=1, sort = 0)
y_train_data2 <- inner_join(y_train_data, activity_labels, by="V1")

# Naming y_test_data
names(y_test_data2) <- c("activity_id","activity_label")
# Naming y_train_data
names(y_train_data2) <- c("activity_id","activity_label")

# Combine all test data
test_data <- cbind(y_test_data2, subject_test_data, x_test_data)
# Combine all train data
train_data <- cbind( y_train_data2, subject_train_data, x_train_data)

# Combine test and train data
data <- rbind(test_data, train_data)

# Last task to get average of all variable by subject, activity using dplyr
data %>% group_by(activity_id, activity_label, subject_id) %>%
  summarise_each(funs(mean)) %>%
  write.table(file = "./tidy_data.txt", row.names = FALSE)

cat("tidy_data.txt generated!!!")
