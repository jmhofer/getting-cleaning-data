library(dplyr)

# Retrieve the source data from the internet and unpack it locally.
# This doesn't have to be done all the time, so you can comment this out after your initial download.

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="Dataset.zip", mode="wb")
dateDownloaded <- date() # downloaded on Fri Oct 23 10:30:50 2015

unzip("Dataset.zip", exdir = ".")
basePath <- "UCI HAR Dataset"

# read activities (names and ids) from file
activities <- read.csv(paste(basePath, "activity_labels.txt", sep = "/"), header = FALSE, sep = " ")
names(activities) = c("activityId", "Activity")

# read feature info (useful as column headers later on)
featureInfo <- read.csv(paste(basePath, "features.txt", sep = "/"), header = FALSE, sep = " ")
names(featureInfo) = c("featureId", "Feature")

# collect the data we are interested in for each the test and training sets
byMode <- lapply(c("test", "train"), function(mode) {
    
    # Compute the respective file paths.
    modePath <- paste(basePath, mode, sep = "/")

    subjectId  <- sapply(readLines(paste(modePath, paste("subject_", mode, ".txt", sep = ""), sep = "/")), as.numeric)
    activityId <- sapply(readLines(paste(modePath, paste("y_", mode, ".txt", sep = ""), sep = "/")), as.numeric)

    # Retrieve only the features we are interested in (mean and standard deviations).
    meansAndStds <- which(grepl("\\-mean\\(\\)", featureInfo$Feature) | grepl("\\-std\\(\\)", featureInfo$Feature))
    
    # Read features as a fixed-width file, where each feature has a width of exactly 16 characters.
    # Name features according to the feature info from above.
    featureFile <- paste(modePath, paste("X_", mode, ".txt", sep = ""), sep = "/")
    features <- 
        read.fwf(featureFile, rep(16, nrow(featureInfo)), col.names = featureInfo$Feature) %>%
        select(meansAndStds) # select only columns containing means and standard deviations (this is *Step 2*)
    
    data.frame(subjectId, activityId, features) # data frame per set (one for test, one for training)
})

renameVariables <- function(data) {
    names <- names(data)
    
    names <- gsub("\\.+", " ", names)                        # convert dots to spaces
    names <- gsub("(.*?) *$", "\\1", names)                  # remove trailing spaces
    names <- gsub("(.*)BodyBody(.*)", "\\1Body\\2", names)   # remove duplicate "Body" labels
    names <- gsub("^t(.*)", "\\1 (Time Domain)", names)      # label variables as time domain based
    names <- gsub("^f(.*)", "\\1 (Frequency Domain)", names) # label variables as frequency domain based
    names <- gsub("subjectId", "Subject ID", names)          # improve subject id labeling
    names <- gsub("Acc", " Accelerator", names)              # remove abbreviations and insert spaces for clarity
    names <- gsub("Gyro", " Gyroscope", names)
    names <- gsub("Jerk", " Jerk", names)
    names <- gsub("Mag", " Magnitude", names)
    names <- gsub("mean", "Mean", names)
    names <- gsub("std", "Standard Deviation", names)
    
    names(data) <- names
    data
}

data <- 
    rbind_all(byMode) %>%                          # merge test and training data - this is *Step 1*
    left_join(activities, by = "activityId") %>%   # join with activity names - this is *Step 3*
    select(-activityId) %>%                        # remove the now superfluous activity id
    renameVariables                                # rename variables so that they are more descriptive - this is *Step 4*

write.table(data, file = "cleaned_up_1.txt", row.names = FALSE) # save data

# Next up, create an independent second tidy data set, grouped by activity and subject. - this is *Step 5*

averaged <- data %>% 
            rename(subjectId = `Subject ID`) %>% # for some reason, summarizing fails for backticked column names with spaces
            group_by(Activity, subjectId) %>%    # group by activity and subject id 
            summarize_each(funs(mean)) %>%       # average all other columns
            rename(`Subject ID` = subjectId)     # rename column back to the nicer one

write.table(averaged, file = "cleaned_up_2.txt", row.names = FALSE) # save tidy data, too
