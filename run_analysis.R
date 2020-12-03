#Step 1: Merges the training and the test sets to create one data set.

library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="./datafiles.zip")
unzip("./datafiles.zip")

features<-read.table("UCI HAR Dataset/features.txt")
activities<-read.table("UCI HAR Dataset/activity_labels.txt")
subjecttest<-read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "volunteer")
subjecttrain<-read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "volunteer")
xtest<-read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$V2)
xtrain<-read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$V2)
ytest<-read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity") 
ytrain<-read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")

#explore the data
summary(ytest) #min(1)/max(6) matches activity_labels - 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING
summary(ytrain) #min(1)/max(6) matches activity_labels - 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING
unique(subjecttest$V1) #2  4  9 10 12 13 18 20 24
unique(subjecttrain$V1)#1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30 Readme shows 30 volunteers.
tbl_df(xtest) #2947 rows by 561 columns, named columns
tbl_df(xtrain) #7352 rows by 561 columns, named columns 
tbl_df(ytest) #2947 rows by 1 column, column name is activity
tbl_df(ytrain) #7352 rows by 1 column, column name is activity
tbl_df(subjecttest) #2937 rows by 1 column
tbl_df(subjecttrain) #7352 rows by 1 column
tbl_df(features) #561 rows by 2 columns (use for column names)

#merge test and train data
xcombined<-rbind(xtest, xtrain) #combine x's
ycombined<-rbind(ytest, ytrain) #combine y's
subcombined<-rbind(subjecttest, subjecttrain) #combine subjects

#make sure merges work
tbl_df(xcombined) #10299 rows by 561 columns
tbl_df(ycombined) #10299 rows by 1 column
tbl_df(subcombined) #10299 rows by 1 column columns

allcombined<-cbind(subcombined,ycombined,xcombined) #combine all
tbl_df(allcombined)  #entire data set is combined with column names. Data columns: volunteer, activity, tBodyAcc.mean...
dim(allcombined) #Dimension of allcombined is 10299x563
#step 1 complete

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
msdfeaturescolnum<-grep("mean\\(|std\\(", features[,2]) #use features.txt to return a vector of column (col) numbers (num) that include with mean( or std(
msdxcombined<-xcombined[,msdfeaturescolnum] #creates a data frame that selects only the column numbers from msdfeaturescolnum
vamsdcombined<-cbind(subcombined,ycombined,msdxcombined) #Volunteer/activity/mean/standard deviation/combined. Adds ycombined and subcombined to the data frame
#explore the new data frame:
str(vamsdcombined) #shows columns for volunteer, activity, and columns for mean( and std(
dim(vamsdcombined) #10299 rows, 68 columns
#step 2 complete

#Step 3: Uses descriptive activity names to name the activities in the data set
#from activity_labels file: 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING
namedactivities <- activities[vamsdcombined$activity, 2] #takes activity number and matches it to the activity description in the activity column of vamsdcombined
activitynames<-cbind(namedactivities,vamsdcombined) #adds data frame from step 3 to neamedactivitiesand 
neworder<-activitynames[, c(2,1,3,4:69)] #reordered data to keep volunteer in first column.
#anotherway<-sub("1", "walking",vamsdcombined$activity) # could pipe (%>%) this for all activity labels but it would take more code.
#Step 3 complete

#Step 4: Appropriately labels the data set with descriptive variable names.
str(neworder) #examine the column names of neworder
names(neworder)<-gsub("^t","time", names(neworder)) #change t to time @beginning of name
names(neworder)<-gsub("^f","frequency", names(neworder)) #change f to frequency @beginning of name
names(neworder)<-gsub("Acc","Acceleration", names(neworder)) #change Acc to Acceleration
names(neworder)<-gsub("mean","Mean", names(neworder)) #change mean to Mean
names(neworder)<-gsub("std","StandardDeviation", names(neworder)) #change std to StandardDeviation
names(neworder)<-gsub("\\.","",names(neworder)) #removes all underscores from each variable name
str(neworder) #examine the new column names of neworder
#Step 4 complete

#Step 5: From the data set in step 4, create[s] a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
indtidydata <- neworder[,c(1,3:69)] %>% group_by(activity, volunteer) %>% summarize_all(mean) #remove namedactivities C(1,3:69), group, summarize using piping
write.table(indtidydata, "meanColumnsGroupedByActivityAndVolunteer.txt", row.name=FALSE) #writes the table to working directory
#Sstep 5 complete
