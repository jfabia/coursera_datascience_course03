# Code Book
## Part 1: The Raw Data Sets
The data sets are downloaded from the following [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The files available are listed below with relevant data fields.

### 1.1 Primary Data
These are the data sets which appear in the parent data folder.
#### `activity_labels.txt`
This data file contains the labels for the activities that data was tracked.

| Value        |  Activity      |   Description           |
| :---:| :----------------: |   :------------------- |
| 1|  WALKING |  The data was collected while walking normally.|
| 2|  WALKING_UPSTAIRS |  The data was collected while walking upstairs.|
| 3| WALKING_DOWNSTAIRS | The data was collected while walking downstairs.|
| 4| SITTING | The data was collected while sitting down. |
| 5| STANDING | The data was collected while standing up. |
| 6| LAYING | The data was collected while lying down. |
    
#### `features.txt`
This is a list of of quantities that were measured for each activity and the statistics calculated as a result. More information on all these columns are found in `features_info.txt`. For this exercise, we only focused on the Mean and Standard Deviation columns of this data set. We discuss the measured quantities in the tidy data submission.

### 1.2 Train and Test Data
These are the data sets which appear for both the Train and Test Data subfolders. 
#### `subject_test` / `subject_train`
This contains data of the ID of participant in the program. It ranges from 1 to 30.

#### `X_Train` / `X_Test`
This contains 561 columns of data which correspond to the measured quantities discussed in `features.txt` and correspond to a participant and activity.

#### `Y_Train` / `Y_Test`
This contains data of the activity corresponding to the participant in  `subject_test`/`subject_train`. It is an integer and can be identified using `activity_labels.txt` 

## Part 2: The Tidy Data Submission
This data submission contains five (5) columns of data that correspond to Participant, Activity, Quantity, Mean and Standard Deviation.

### Participant
Type: Integer

This identifies the participant in the study. Values range from 1 to 30.

### Activity
Type: Character

This identifies the activity that was logged by the smartphone's accelerometers. It can take on the following values which are described in `activity_labels.txt`:
* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

### Quantity
Type: Character

This identifies the quantity that was measured by the smartphone's accelerometers during the specified activities. 
If the item ends in (.X, .Y, or .Z), it pertains to a measure on that axis.
There are 33 possible values.

1. Frequency.BodyAccelerator.X
2. Frequency.BodyAccelerator.Y
3. Frequency.BodyAccelerator.Z
4. Frequency.BodyAcceleratorJerk.X
5. Frequency.BodyAcceleratorJerk.Y
6. Frequency.BodyAcceleratorJerk.Z
7. Frequency.BodyAcceleratorJerkMagnitude
8. Frequency.BodyAcceleratorMagnitude
9. Frequency.BodyGyroscope.X
10. Frequency.BodyGyroscope.Y
11. Frequency.BodyGyroscope.Z
12. Frequency.BodyGyroscopeJerkMagnitude
13. Frequency.BodyGyroscopeMagnitude
14. Time.BodyAccelerator.X
15. Time.BodyAccelerator.Y
16. Time.BodyAccelerator.Z
17. Time.BodyAcceleratorJerk.X
18. Time.BodyAcceleratorJerk.Y
19. Time.BodyAcceleratorJerk.Z
20. Time.BodyAcceleratorJerkMagnitude
21. Time.BodyAcceleratorMagnitude
22. Time.BodyGyroscope.X
23. Time.BodyGyroscope.Y
24. Time.BodyGyroscope.Z
25. Time.BodyGyroscopeJerk.X
26. Time.BodyGyroscopeJerk.Y
27. Time.BodyGyroscopeJerk.Z
28. Time.BodyGyroscopeJerkMagnitude
29. Time.BodyGyroscopeMagnitude
30. Time.GravityAccelerator.X
31. Time.GravityAccelerator.Y
32. Time.GravityAccelerator.Z
33. Time.GravityAcceleratorMagnitude
 
### Mean
Type: Number

This calculates the average of the mean of the total observations for a particular Participant, Activity and Quantity.

### StandardDeviation
Type: Number

This calculates the average of the standard deviation of the total observations for a particular Participant, Activity and Quantity.