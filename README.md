# Getting and Cleaning Data

Repo for the respective Coursera course project.

## Files in this project

* `README.md`: this file
* `CodeBook.md`:  the code book describing the variables of the raw and transformed data sets
* `run_analysis.R`: the R script used to download and transform the data

## Prerequisites

In order to run the analysis script, you need an installation of `R`, specifically with the `dplyr` package installed.

## How to run the analysis

Just switch to a reasonably clean working directory and execute `run_analysis.R` in `R`. 

## Script description

The script will 
* download the source data set from the internet into the working directory, 
* unzip it (creating a `UCI HAR Dataset` subdirectory),
* read the activities (`activity_labels.txt` from the source data) and features information (`features.txt` from the source data),
* for both training and test sets,
  * collect the subject id and activity id data (`train/subject_train.txt` / `test/subject_test.txt` and `train/y_train.txt` / `test/y_test.txt`),
  * collect the feature data itself (`train/X_train.txt` / `test/X_test.txt`), leaving out any features that are not means or standard deviations,
* combine the data from training and test sets into one,
* join the data with the activity labels, so that the activity column gets more descriptive, and leave out the now superfluous activity id variable,
* rename all the variables into more descriptive ones (mostly by removing abbreviations and formatting them nicely).

The resulting data set of these transformations will be stored into a first (intermediate) file `cleaned_up_1.txt`.

Next, the script will create a tidy data set from the intermediate one by
* grouping the data by activity and subject id,
* summarizing for each group by computing the averages of all non-grouped columns.

The resulting tidy data set will be stored into the file `cleaned_up_2.txt`.

After the initial data download and unzipping, you may comment out the lines for downloading and unzipping the data in the script. The download date 
will be stored in the `dateDownloaded` variable by the script for your further perusal.

See the comments in the analysis script itself for further information.
