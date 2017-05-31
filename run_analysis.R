
# Load activity labels and  features
ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
ActivityLabels[,2] <- as.character(ActivityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
MeasurementsIndex <- grep(".*mean.*|.*std.*", features[,2])
#Get and clean up column names
MeasurementsNames = gsub('[-()]', '', gsub('-std', 'Std', gsub('-mean', 'Mean', features[MeasurementsIndex,2])))

# Load train datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[MeasurementsIndex]
TrainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
TrainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
TrainAll <- cbind(TrainSubjects, TrainActivities, train)

# Load test datasets
test <- read.table("UCI HAR Dataset/test/X_test.txt")[MeasurementsIndex]
TestActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
TestSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
TestAll <- cbind(TestSubjects, TestActivities, test)

# merge datasets and add labels
DataTotal <- rbind(TrainAll, TestAll)
#rename column for DataTotal
colnames(DataTotal) <- c("subject", "activity", MeasurementsNames)

# turn activities & subjects into factors
DataTotal$activity <- factor(DataTotal$activity, levels = ActivityLabels[,1], labels = ActivityLabels[,2])
DataTotal$subject <- as.factor(DataTotal$subject)

#Get dataset with mean for each variable group by subject and activity
DataMean <- aggregate(. ~subject + activity, DataTotal, mean)
DataMean <- DataMean[order(DataMean$subject, DataMean$activity),]

#write to file tidy.txt
write.table(DataMean, "tidy.txt", row.names = FALSE, quote = FALSE)
