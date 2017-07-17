
# Load the libraries needed for the script
library(plyr)
library(dplyr) 
library(data.table) # for fread
library(reshape2) # for melt

# Remove the variables in the global environment.
rm(list=ls())

# Set the working directory to the default Workspace.
# The variable defaultWorkspace should be edited by the user of this script.

defaultWorkspace <- "./"
setwd(defaultWorkspace)

# Ensure that all the necessary data is in place
# If any of the data is not available, then extract from the zip file
# If the zip file doesn't exist, download it first.

# Initialize the required data and dne_counter
dne_counter <- 0
file1 <- "./UCI HAR Dataset/activity_labels.txt"
file2 <- "./UCI HAR Dataset/features.txt"
file3 <- "./UCI HAR Dataset/test/subject_test.txt"
file4 <- "./UCI HAR Dataset/test/X_test.txt"
file5 <- "./UCI HAR Dataset/test/Y_test.txt"
file6 <- "./UCI HAR Dataset/train/subject_train.txt"
file7 <- "./UCI HAR Dataset/train/X_train.txt"
file8 <- "./UCI HAR Dataset/train/Y_train.txt"

# Create a data frame consisting of the strings above.
datafiles <- rbind(file1, file2, file3, file4, file5, file6, file7, file8)

# Loop across the datafile dataframe. If any of the files do not exist, the dne_counter will add up.
for(i in 1:8){
        if(!file.exists(datafiles[i,1])){
                dne_counter <- dne_counter + 1
        }
}

# A dne_counter greater than 0 signals the code to extract the files. 
if(dne_counter > 0){
# Check to see if the zip file exists; if it does not, then download the file first.
        if(!file.exists("./dataset.zip")){
                fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(fileURL, destfile = "./dataset.zip")
                }
        unzip("dataset.zip")
}

# Set the filepaths of the different data in separate variables
path_main <- paste(defaultWorkspace, "UCI HAR Dataset", sep ="/" )
path_train <- paste(defaultWorkspace,"UCI HAR Dataset", "train", sep ="/" )
path_test <- paste(defaultWorkspace, "UCI HAR Dataset", "test", sep ="/" )

# read the data and store them in different dataframes.

data_activityLabels <- read.table( paste(path_main, "activity_labels.txt", sep = "/"))
data_features <- read.table( paste(path_main, "features.txt", sep = "/"))

data_test_x <- read.table( paste(path_test, "X_test.txt", sep = "/"))
data_test_y <- read.table( paste(path_test, "y_test.txt", sep = "/"))
data_test_subject <- read.table( paste(path_test, "subject_test.txt", sep = "/"))

data_train_x <- read.table( paste(path_train, "X_train.txt", sep = "/"))
data_train_y <- read.table( paste(path_train, "y_train.txt", sep = "/"))
data_train_subject <- read.table( paste(path_train, "subject_train.txt", sep = "/"))

# We combine the train and test datasets for subject, x and y.

data_subject <- rbind(data_train_subject, data_test_subject)
data_x <- rbind(data_train_x, data_test_x)
data_y <- rbind(data_train_y, data_test_y)

# Add column names to data_subject, data_x and data_y

# Transform the data as a list.
column_labels <- data.frame(lapply(data_features, as.character), stringsAsFactors = FALSE)

# Apply the new list as column names to data_train_x and data_test_x
colnames(data_x) <- column_labels$V2

# Next, we rename the column names for the subject data and activity data.

# Rename the column names for subject data to "Participant"
colnames(data_subject) <- c("Participant")

# Rename the column name for data_y as "activity"
colnames(data_y) <- c("activity_id")

# Task 1: Merge the training and the test sets to create one data set.
# The training set is data_test
# The test set is data_train

# Use cbind to merge the datasets into a new dataframe, data_merge

data_merge <- cbind(data_subject, data_y, data_x)

# Task 2: Extract only the measurements on the mean and standard deviation for each measurement.
# The data is in data_x.


# We need to collect the column names which include "mean()' or 'sd()'.
# Use the grep function on column_labels 2nd column and ensure it is a character vector.
selected_labels <- as.character(column_labels$V2[grep("mean\\(\\)|std\\(\\)", column_labels$V2)])

# Now we get a subset of data_x by passing selected_labels as an argument. We name this table as data_x_select
data_x_select <- subset(data_x, select = selected_labels)

# Use cbind to merge the datasets into a new dataframe, data_merge_select
data_merge_select <- cbind(data_subject, data_y, data_x_select)

# Task 3: Use descriptive activity names to name the activities in the data set.

# Replace the activity_id with the corresponding activity found in data_activityLabels
data_merge_select$activity_id <- data_activityLabels[match(data_merge_select$activity_id, data_activityLabels[,1]),2]

# Rename the columnname to 'activity'
names(data_merge_select)[2] <- c("Activity")

# Task 4: Appropriately label the data with descriptive variable names.
# Column names are derived from features_info as follows:
# t means data came from TimeDomain
# f means data came from FrequencyDomain
# Acc stands for a measurement from the Accelerator
# Gyro stands for a measurement from the Gyroscope
# Mag stands for Magnitude
# mean stands for Mean
# std stands for StdDev
# We will use these descriptions to revise the column headers in data_merge_select
# We will use gsub to make the replacements.

names(data_merge_select) <- gsub('^t', 'Time.', names(data_merge_select))
names(data_merge_select) <- gsub('^f', 'Frequency.', names(data_merge_select))
names(data_merge_select) <- gsub('Acc', 'Accelerator', names(data_merge_select))
names(data_merge_select) <- gsub('Gyro', 'Gyroscope', names(data_merge_select))
names(data_merge_select) <- gsub('Mag', 'Magnitude', names(data_merge_select))
names(data_merge_select) <- gsub('X$', '.X', names(data_merge_select))
names(data_merge_select) <- gsub('Y$', '.Y', names(data_merge_select))
names(data_merge_select) <- gsub('Z$', '.Z', names(data_merge_select))

# Also, get rid of "BodyBody" fields
names(data_merge_select) <- gsub('BodyBody', 'Body', names(data_merge_select))


# Task 5: Create an independent tidy data set with the average of each variable for each activity and subject

# We start off by tidying up data_merge_select.
# We need to melt the data so that we stack means by standard deviations.

data_merge_melt <- melt(data_merge_select, id = c("Participant", "Activity"), measure.vars = names(data_merge_select[3:68]))

# Now that we have our melted data, we need to extract the means and standard deviations from this dataset.
# First, transform the 'variable' to a character
data_merge_melt$variable <- as.character(data_merge_melt$variable)

# Next we extract the Statistic calculated in each row.
# This code exxtracts the name of the statistic from the $variable.
data_merge_melt$Statistic <- sapply(strsplit(data_merge_melt$variable, "-"),"[",2)
# This code removes the \\( from the $Statistic
data_merge_melt$Statistic <- sapply(strsplit(data_merge_melt$Statistic, "\\("),"[",1)

# Create a new dataframe, call it t1. This will contain the name of the item being measured
t1 <- as.data.frame(data_merge_melt$variable)
names(t1) = c("V1")
t1$V1 <- sapply(strsplit(data_merge_melt$variable, "-"),"[",1)
t1$V2 <- sapply(strsplit(data_merge_melt$variable, "-"),"[",3)

# Now, we add in the column "Quantity" to our data frame
data_merge_melt$Quantity <- t1$V1
data_merge_melt$Quantity <- paste(data_merge_melt$Quantity, ifelse(is.na(t1$V2),"",t1$V2), sep="")

# Split the data set between mean and standard deviation
data_tidying <- select(data_merge_melt, Participant, Activity, Quantity, Statistic, value)
data_tidying <- arrange(data_tidying, Statistic, Participant, Activity, Quantity)
data_tidying_mean <- arrange(filter(data_tidying, Statistic == "mean"), Participant, Activity, Quantity)
data_tidying_std <- arrange(filter(data_tidying, Statistic == "std"), Participant, Activity, Quantity)

# Combine the mean and standard deviation columns into one dataset.
data_tidy_phase <- select(data_tidying_mean, Participant, Activity, Quantity, value)
data_tidy_phase <- cbind(data_tidy_phase, data_tidying_std$value)
colnames(data_tidy_phase) <- c("Participant", "Activity", "Quantity", "Mean","StandardDeviation")

# Aggregate the dataset; calculate the mean.
data_aggregate <- aggregate(data_tidy_phase[,4:5], by=list(Participant = data_tidy_phase$Participant, Activity=data_tidy_phase$Activity, Quantity=data_tidy_phase$Quantity), mean)
data_aggregate <- arrange(data_aggregate, Activity, Participant, Quantity)

 
# Write the table to Tidy_Data_Submission.txt
write.table(data_aggregate, "./Tidy_Data_Submission.txt", row.names = FALSE, sep = '\t')
sprintf("The file 'Tidy_Data_Submission.txt' was generated in %s", getwd())
