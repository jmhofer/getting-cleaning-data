library(dplyr)

# Retrieve the source data from the internet and unpack it locally.
# This doesn't have to be done all the time...

if (!file.exists("data")) dir.create("data")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="data/Dataset.zip", mode="wb")unzip("data/Dataset.zip", exdir = "data")
dateDownloaded <- date() # downloaded on Sun Oct 18 13:51:36 2015

byMode <- lapply(c("test", "train"), function(mode) {
    # Compute the respective file paths
    basePath <- paste("data", "UCI HAR Dataset", mode, sep = "/")
    signalsPath <- paste(basePath, "Inertial Signals", sep = "/")
    
    subjectId <- readLines(paste(basePath, paste("subject_", mode, ".txt", sep = ""), sep = "/"))
    labelId   <- readLines(paste(basePath, paste("y_",       mode, ".txt", sep = ""), sep = "/"))
    
    measurement <- lapply(list.files(signalsPath, full.names = TRUE), function(file) {
        measurementName <- gsub(paste(".*/(.*)_", mode, ".txt", sep = ""), "\\1", file) # extract name of measured variable from filename

        valuesPerFile <- data.frame(t(sapply(readLines(file), function(line) {
            values <- sapply(strsplit(line, '(?<=.{16})', perl = TRUE)[[1]], as.double) # split line into 16 character long chunks
            c(mean(values), sd(values)) # only use mean and standard deviation of each measurement - this is *Step 2*
        })), row.names = NULL)
        
        # adapt column names
        names(valuesPerFile) <- sapply(c("mean", "sd"), function(s) paste(measurementName, s, sep = "_"))
        
        valuesPerFile # returns mean and standard deviation per measurement
    })

    measurements <- do.call(cbind, measurement) # combine all measurement mean and sd colums together
    data.frame(subjectId, labelId, measurements) # combine ids and measurements
})

data <- rbind_all(byMode) # merge test and training data - this is *Step 1*

## TODO read activity names and join with them (Step 3)
## TODO more descriptive column names (?) (Step 4)
## TODO average each variable in a second tidy data set (Step 5)
