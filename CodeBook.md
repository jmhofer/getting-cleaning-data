# CodeBook - Getting and Cleaning Data

## Study Design

This analysis is built upon the raw data [described here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
and available for [download here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

For the original study design and variables description, please refer to the description and data above.

Please note that all the feature variables in the source data are normalized, which means that they don't have any useful or 
easily described units. As this analysis builds on those feature variables, the resulting variables don't have any useful units either.
However, the analysis does not change the units or re-/denormalize the variables in any way.

The original data contains *raw signal values* in the `Inertial Signals` folders of the test and training sets. These raw values were *not* used
in this analysis. Instead, the *already preprocessed* variables contained in the `X_train.txt`/`X_test.txt` and `y_train.txt`/`y_test.txt` files were used.
Additionally, from these variables, only the ones containing *means and standard deviations* were used.

No variable values were changed by this analysis. The variable names, however, were adapted in order to make them more descriptive and human-readable.
For example, `tBodyGyroMag` was renamed to the more descriptive `Body Gyroscope Magnitude (Time Domain)`.

The training and test data sets were combined into one single data set in this analysis. Furthermore, the data set was grouped by activity and subject, and 
for each activity and subject, the average over all individual variables was calculated.

## Code Book

The resulting tidy data set contains 68 variables as follows:

### Activity (1)

The activity that was undertaken during the measurements. One of `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING` and `LAYING`.

### Subject ID (2)

The ID of the subject undertaking the measured activities.

### Body Accelerator Mean X/Y/Z (Time Domain) (3, 4, 5)

Mean of the time-domain measurements of the body accelerator (linear acceleration) for each coordinate system axis (`X`/`Y`/`Z`).

### Body Accelerator Standard Deviation X/Y/Z (Time Domain) (6, 7, 8)

Standard deviation of the time-domain measurements of the body accelerator for each coordinate system axis (`X`/`Y`/`Z`).

### Gravity Accelerator Mean X/Y/Z (Time Domain) (9, 10, 11)

Mean of the time-domain measurements of the gravity accelerator for each coordinate system axis (`X`/`Y`/`Z`).

### Gravity Accelerator Standard Deviation X/Y/Z (Time Domain) (12, 13, 14)

Standard deviation of the time-domain measurements of the gravity accelerator for each coordinate system axis (`X`/`Y`/`Z`).

### Body Accelerator Jerk Mean X/Y/Z (Time Domain) (15, 16, 17)

Mean of the time-domain measurements of the body accelerator "jerk" value (linear acceleration derived in time) for each coordinate system axis (`X`/`Y`/`Z`).

### Body Accelerator Jerk Standard Deviation X/Y/Z (Time Domain) (18, 19, 20)

Standard deviation of the time-domain measurements of the body accelerator "jerk" value (linear acceleration derived in time) for each coordinate system axis (`X`/`Y`/`Z`).

### Body Gyroscope Mean X/Y/Z (Time Domain) (21, 22, 23)

Mean of the time-domain measurements of the body gyroscope (angular velocity) for each coordinate system axis (`X`/`Y`/`Z`).

### Body Gyroscope Standard Deviation X/Y/Z (Time Domain) (24, 25, 26)

Standard deviation of the time-domain measurements of the body gyroscope for each coordinate system axis (`X`/`Y`/`Z`).

### Body Gyroscope Jerk Mean X/Y/Z (Time Domain) (27, 28, 29)

Mean of the time-domain measurements of the body gyroscope "jerk" value (angular velocity derived in time) for each coordinate system axis (`X`/`Y`/`Z`).

### Body Gyroscope Jerk Standard Deviation X/Y/Z (Time Domain) (30, 31, 32)

Standard deviation of the time-domain measurements of the body gyroscope "jerk" value for each coordinate system axis (`X`/`Y`/`Z`).

### Body Accelerator Magnitude Mean / Standard Deviation (Time Domain) (33, 34)

Mean / standard deviation of the time-domain measurement of the body accelerator magnitude value (Euclidean norm of the `X`/`Y`/`Z` values).

### Gravity Accelerator Magnitude Mean / Standard Deviation (Time Domain) (35, 36)

Mean / standard deviation of the time-domain measurement of the gravity accelerator magnitude value.

### Body Accelerator Jerk Magnitude Mean / Standard Deviation (Time Domain) (37, 38)

Mean / standard deviation of the time-domain measurement of the body accelerator jerk magnitude value.

### Body Gyroscope Magnitude Mean / Standard Deviation (Time Domain) (39, 40)

Mean / standard deviation of the time-domain measurement of the body gyroscope magnitude value.

### Body Gyroscope Magnitude Jerk Mean / Standard Deviation (Time Domain) (41, 42)

Mean / standard deviation of the time-domain measurement of the body gyroscope jerk magnitude value.

### Body Accelerator Mean X/Y/Z (Frequency Domain) (43, 44, 45)

Mean of the frequency-domain measurement (produced by a Fast Fourier Transform) of the body accelerator value for each coordinate system axis (`X`/`Y`/`Z`).

### Body Accelerator Standard Deviation X/Y/Z (Frequency Domain) (46, 47, 48)

Standard deviation of the frequency-domain measurement of the body accelerator value for each coordinate system axis (`X`/`Y`/`Z`).

### Body Accelerator Jerk Mean X/Y/Z (Frequency Domain) (49, 50, 51)

Mean of the frequency-domain measurement of the body accelerator jerk value for each coordinate system axis (`X`/`Y`/`Z`).

### Body Accelerator Jerk Standard Deviation X/Y/Z (Frequency Domain) (52, 53, 54)

Standard deviation of the frequency-domain measurement of the body accelerator jerk value for each coordinate system axis (`X`/`Y`/`Z`).

### Body Gyroscope Mean X/Y/Z (Frequency Domain) (55, 56, 57)

Mean of the frequency-domain measurement of the body gyroscope value for each coordinate system axis (`X`/`Y`/`Z`).

### Body Gyroscope Standard Deviation X/Y/Z (Frequency Domain) (58, 59, 60)

Standard deviation of the frequency-domain measurement of the body gyroscope value for each coordinate system axis (`X`/`Y`/`Z`).

### Body Accelerator Magnitude Mean / Standard Deviation (Frequency Domain) (61, 62)

Mean / Standard deviation of the frequency-domain measurement of the body accelerator magnitude value.

### Body Accelerator Jerk Magnitude Mean / Standard Deviation (Frequency Domain) (63, 64)

Mean / Standard deviation of the frequency-domain measurement of the body accelerator jerk magnitude value.

### Body Gyroscope Magnitude Mean / Standard Deviation (Frequency Domain) (65, 66)

Mean / Standard deviation of the frequency-domain measurement of the body gyroscope magnitude value.

### Body Gyroscope Jerk Magnitude Mean / Standard Deviation (Frequency Domain) (67, 68)

Mean / Standard deviation of the frequency-domain measurement of the body gyroscope jerk magnitude value.
