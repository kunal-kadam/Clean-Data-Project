#Download the zip folder and unzip it the working repository

#readind the text file into the directory
features <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", col.names = "code")


# Joining the data of train and test row wise as per the variables
x_full <- rbind(x_train, x_test) 
y_full <- rbind(y_train, y_test) 
subject_full <- rbind(subject_train,subject_test)


#1.Merging both train and test data into a final data that contains all variables and 
#elements
data_full <- cbind(subject_full,x_full,y_full) 



library(dplyr)  

#Selecting only the variables containing mean and std measurements along with the subject and
#code variable
#mean_std_data contains the variables related to only mean and std measurement
mean_std_data <- data_full %>% select(subject, code, contains("mean"), contains("std"))


mean_std_data$code <- activities[mean_std_data$code, 2] # It converts elements in the  
#code variable present in the mean_std_data with the activities assigned to it in activities 
#dataset


#Change the name of variable code with the activity as there no more code in the dataset
names(mean_std_data)[2] = "activity"

#changing the variables name with the help of features_info in folder
names(mean_std_data)<-gsub("^t", "time.", names(mean_std_data))

names(mean_std_data)<-gsub("^f", "frequency.", names(mean_std_data))


names(mean_std_data)<-gsub("Acc", "accelerometer", names(mean_std_data))

names(mean_std_data)<-gsub("Gyro", "gyroscope", names(mean_std_data))

names(mean_std_data)<-gsub("BodyBody", "body", names(mean_std_data))

names(mean_std_data)<-gsub("Mag", "magnitude", names(mean_std_data))

names(mean_std_data)<-gsub("tBody", "timeBody", names(mean_std_data))



names(mean_std_data)<-gsub("mean()", "mean", names(mean_std_data), ignore.case = TRUE)

names(mean_std_data)<-gsub("std()", "standardDeviation", names(mean_std_data), ignore.case = TRUE)



names(mean_std_data)<-gsub("freq()", "Frequency", names(mean_std_data), ignore.case = TRUE)

names(mean_std_data)<-gsub("angle", "Angle", names(mean_std_data))

names(mean_std_data)<-gsub("gravity", "Gravity", names(mean_std_data))


#created a new clean data that contains the average of each variables of each subject and 
#activity  
Cleandata <- mean_std_data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

write.table(Cleandata, "Cleandata1.txt", row.name=FALSE)

str(Cleandata)
Cleandata


