library(data.table)
library(dplyr)

dataActivityTest  <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
dataActivityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)

dataSubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
dataSubjectTest  <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

dataFeaturesTest  <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
dataFeaturesTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)


str(dataActivityTest)
str(dataActivityTrain)
str(dataSubjectTrain)
str(dataSubjectTest)
str(dataFeaturesTest)
str(dataFeaturesTrain)


#1 MERGE
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table("UCI HAR Dataset/features.txt")
names(dataFeatures)<- dataFeaturesNames$V2

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)


#2 EXTRACT
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

str(Data)


#3 DESCRIPTIVE NAMES
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
head(Data$activity,30)


#4 NAME LABELS
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)

#5 INDEPENDENT DATA

library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, "UCI HAR Dataset/tidydata.txt",row.name=FALSE)


