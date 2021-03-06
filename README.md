# Getting and Cleaning Data - Course Project

## Summary
This is a repository created for the Peer-graded Assignment: Getting and Cleaning Data Course Project. The purpose of this project is to demonstrate my ability to collect, work with and clean a data set.

## Objectives
The objectives of this project are as follows:
* Submit a tidy data set based on the instructions provided.
* Provide a link to a Githb repository containing the script performing the analysis
* Submit a codebook that describes the variables, data, and any transformations or work that were performed to clean up the data called "CodeBook.MD".
* Provide a README.md in the repository that explains how all the files are connected (which this file does).

## The Data
The data that was used for this project represents human activity recognition data collected from the accelerometers from the Samsung Galaxy S smartphone. You can find more information of this data in at [this link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

## The Repository
This repository contains three (3) files for the user to generate the file 'Tidy_Data_Submission.txt':
* A ReadMe, README.md: You are here
* An R Script, ```run_analysis.R```: This script generates Tidy_Data_Submission.txt
* A Code Book, CodeBook.MD: This is the codebook describing the variables, data and transformations used in ```run_analysis.R```

### `run_analysis.R`
This script will generate a tidy data set for the data provided by the assignment. The script can be run at any working directory. The script will:
* Check if the required data sets are in the working directory. If the files aren't available, the code will extract the zip file. If the zip file does not exist, the code will download it.
* Extract the contents of the zip file in the data folder. The subfolder created is `./UCI HAR Dataset`.
* Read the following data files as dataframes.
    * `activity_labels.txt`
    * `features.txt`
    * `train/subject_test.txt`
    * `train/X_test.txt`
    * `train/Y_test.txt`
    * `test/subject_test.txt`
    * `test/X_test.txt`
    * `test/Y_test.txt`
* Combine the train and test data sets into one data set, but extracting only the mean and standard deviation statistics for each quantity measured.
* Re-label the measured quantities to make them more descriptive
* Create an independent tidy data set with the average of each quantity and statistic.

There are comments in the ```run_analysis.R``` script that describe how the code works in detail.

## The CodeBook
The codebook provides details of the variables and summaries for both the raw data sets and the tidy data set.
