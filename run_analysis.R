# read the test data

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# read the training data

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# read features and activity labels

features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# combine test data and training data into one data set

x <- rbind (x_test,x_train)
y <- rbind (y_test,y_train)
subject <- rbind (subject_test,subject_train)

# combine numerical data with subject and activity labels

xy <- cbind(x,y)
data <- cbind(xy,subject)

# give the data set descriptive names

names(data)[563] <- "subject"

featureNames <- as.character(features$V2)

names(data)[1:561] <- featureNames

# reduce data set so that it only contains measurments on the
# mean and standard deviation for each measurement

extractCols <- c(grep("[-]mean[(][)]|std", featureNames),c(562,563))

data <- data[, extractCols]

# merge in activity labels

data <- merge(data,activity_labels,by="V1")

names(data)[69] <- "activity"

# clean up and make more descriptive column names

names(data) <- gsub("[(][)]","",names(data))
names(data) <- gsub("[-]","_",names(data))
names(data) <- gsub("std","STD",names(data))
names(data) <- gsub("mean","MEAN",names(data))
names(data) <- gsub("^t","Time",names(data))
names(data) <- gsub("^f","Freq",names(data))
names(data) <- gsub("BodyBody","Body",names(data))

# rearrange columns so subject and activity come first

data <- data[,c(c(68,69),2:67)]

# order the data set based on subject and activity

data <- data[with(data, order(subject,activity)), ]

# write the tidy data to TidyData.txt

write.table(data,file="TidyData.txt",sep=",",row.names=F)

# calculate average values for each measurement per subject per activity

aggData <- aggregate(.~subject+activity, data=data, mean,na.rm=T)

# write the aggregated data to TidyDataAggregated.txt

write.table(aggData,file="TidyDataAggregated.txt",sep=",",row.names=F)