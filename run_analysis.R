# Read raw data.
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# Merge data.
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
data <- cbind(subject, y, x)

# Set pretty labels to columns.
names(data) <- c("Subject", "Activity", features[,2])

# Filter data (retain only mean and standard deviation variables).
filter_log_vect <- grepl("(mean|std)\\(\\)",names(data))
filter_log_vect[1:2] <- TRUE
data_filtered <- data[,filter_log_vect]

# Reset type of activity column as factor class with pretty labels.
data_filtered$Activity <- factor(data_filtered$Activity, labels=activity_labels[,2])

# Calculate average values for groups.
library(plyr)
data_averages <- ddply(data_filtered, .(Subject, Activity), function(x) colMeans(x[, 3:ncol(data_filtered)]))

# Save tidy data to file.
write.table(data_averages, "data_averages.txt", row.name=FALSE)