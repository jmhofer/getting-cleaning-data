library(dplyr)

# Retrieve the source data from the internet and unpack it locally.
# This doesn't have to be done all the time...

if (!file.exists("data")) dir.create("data")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="data/Dataset.zip", mode="wb")unzip("data/Dataset.zip", exdir = "data")
dateDownloaded <- date() # downloaded on Sun Oct 18 13:51:36 2015

basePath <- "data/UCI HAR Dataset"

# read activities (names and ids) from file
activities <- read.csv(paste(basePath, "activity_labels.txt", sep = "/"), header = FALSE, sep = " ")
names(activities) = c("activityId", "Activity")

# read feature info (useful as column headers later on)
featureInfo <- read.csv(paste(basePath, "features.txt", sep = "/"), header = FALSE, sep = " ")
names(featureInfo) = c("featureId", "Feature")

byMode <- lapply(c("test", "train"), function(mode) {
    
    # Compute the respective file paths.
    modePath <- paste(basePath, mode, sep = "/")

    subjectId  <- readLines(paste(modePath, paste("subject_", mode, ".txt", sep = ""), sep = "/"))
    activityId <- sapply(readLines(paste(modePath, paste("y_", mode, ".txt", sep = ""), sep = "/")), as.numeric)

    # Compute features we're interested in (mean and standard deviations).
    meansAndStds <- which(grepl("\\-mean\\(\\)", featureInfo$Feature) | grepl("\\-std\\(\\)", featureInfo$Feature))
    
    # Read features as a fixed-width file, where each feature has a width of exactly 16 characters.
    # Name features according to the feature info from above.
    featureFile <- paste(modePath, paste("X_", mode, ".txt", sep = ""), sep = "/")
    features <- 
        read.fwf(featureFile, rep(16, nrow(featureInfo)), col.names = featureInfo$Feature) %>%
        select(meansAndStds) # select only columns containing means and standard deviations (this is *Step 2*)
    
    data.frame(subjectId, activityId, features) # data frame per set (one for test, one for training)
})

data <- 
    rbind_all(byMode) %>%                          # merge test and training data - this is *Step 1*
    left_join(activities, by = "activityId") %>%   # join with activity names - this is *Step 3*
    select(-activityId) %>%                        # remove the now superfluous activity id
    print

## TODO more descriptive column names (?) (Step 4)
## TODO average each variable in a second tidy data set (Step 5)
