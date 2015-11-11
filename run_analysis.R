# Obtaining raw data.
obtainRawData <- function(dataDir) {
  
  if (!dir.exists(dataDir)) {
    
    dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zipFileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
    download.file(dataUrl, zipFileName, mode="wb")
    unzip(zipFileName)
    unlink(zipFileName)
    TRUE
  }
  else {
    
    FALSE
  }
}

# Read raw data.
readRawData <- function(dataDir) {
 
  trainDir <- file.path(dataDir, "train");
  x_train <- read.table(file.path(trainDir, "X_train.txt"))
  y_train <- read.table(file.path(trainDir, "y_train.txt"))
  subject_train <- read.table(file.path(trainDir, "subject_train.txt"))
  
  testDir <- file.path(dataDir, "test");
  x_test <- read.table(file.path(testDir, "X_test.txt"))
  y_test <- read.table(file.path(testDir, "y_test.txt"))
  subject_test <- read.table(file.path(testDir, "subject_test.txt"))
  
  features <- read.table(file.path(dataDir, "features.txt"), stringsAsFactors=FALSE)
  activity_labels <- read.table(file.path(dataDir, "activity_labels.txt"))
  
  rawData <- list(x_train = x_train, y_train = y_train, subject_train = subject_train,
                  x_test = x_test, y_test = y_test, subject_test = subject_test,
                  features = features, activity_labels = activity_labels)
}

# Merge data.
mergeData <- function(rawData) {

  x <- rbind(rawData$x_train, rawData$x_test)
  y <- rbind(rawData$y_train, rawData$y_test)
  subject <- rbind(rawData$subject_train, rawData$subject_test)
  data <- cbind(subject, y, x)
}

# Filter data (select/retain only mean and standard deviation variables).
filterData <- function(data) {
  
  filter_log_vect <- grepl("(mean|std)\\(\\)",names(data))
  filter_log_vect[1:2] <- TRUE
  data_filtered <- data[,filter_log_vect]
}

doTidyData <- function() {
  
  # Set directory with raw data.
  dataDir <- "UCI HAR Dataset"
  
  # Obtaining raw data.
  obtainRawData(dataDir)
  
  # Read raw data.
  rawData <- readRawData(dataDir)
  
  # Merge data.
  data <- mergeData(rawData)

  # Set pretty labels to columns.
  names(data) <- c("Subject", "Activity", rawData$features[,2])
  
  # Filter data (retain only mean and standard deviation variables).
  data_filtered <- filterData(data)
  
  # Reset type of activity column as factor class with pretty labels.
  data_filtered$Activity <- factor(data_filtered$Activity, labels=rawData$activity_labels[,2])
  
  # Calculate average values for groups (separated by Subject & Activity).
  library(plyr)
  data_averages <- ddply(data_filtered, .(Subject, Activity), function(x) colMeans(x[, 3:ncol(data_filtered)]))
  
  # Save tidy data to file.
  write.table(data_averages, "data_averages.txt", row.name=FALSE)
}

doTidyData()