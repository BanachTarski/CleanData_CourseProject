setwd("~/Documents/Code/R-Coursera/Clean/CourseProject")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

x <- rbind (x_test,x_train)
y <- rbind (y_test,y_train)
subject <- rbind (subject_test,subject_train)

xy <- cbind(x,y)
data <- cbind(xy,subject)

names(data)[563] <- "subject"

featureNames <- as.character(features$V2)

names(data)[1:561] <- featureNames

extractCols <- c(grep("[-]mean[(][)]|std", featureNames),c(562,563))

data <- data[, extractCols]

data <- merge(data,activity_labels,by="V1")

names(data)[69] <- "activity"

names(data) <- gsub("[(][)]","",names(data))
names(data) <- gsub("[-]","_",names(data))
names(data) <- gsub("std","STD",names(data))
names(data) <- gsub("mean","MEAN",names(data))
names(data) <- gsub("^t","Time",names(data))
names(data) <- gsub("^f","Freq",names(data))
names(data) <- gsub("BodyBody","Body",names(data))

data <- data[,c(c(68,69),2:67)]

data <- data[with(data, order(subject,activity)), ]

write.table(data,file="TidyData.txt",sep=",",row.names=F)

aggData <- aggregate(.~subject+activity, data=data, mean,na.rm=T)

write.table(aggData,file="TidyDataAggregated.txt",sep=",",row.names=F)