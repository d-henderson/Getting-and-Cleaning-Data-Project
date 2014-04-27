setwd("C:\\Users\\David\\Dropbox\\Coursera\\Getting and Cleaning Data\\Getting and Cleaning Data Project")

# Read in raw training text files for and save as data frames
X_train<- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
y_train<- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
subject_train<- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")

# Combine Subject ID's and Activities together in one data frame
train_combined<- cbind(subject_train,y_train)
names(train_combined)[1:2]<- c("Subject","Activity_Code")

# Read in raw test text files for and save as data frames
X_test<- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
y_test<- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
subject_test<- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")

# Combine Subject ID's and Activities together in one data frame
test_combined<- cbind(subject_test,y_test)
names(test_combined)[1:2]<- c("Subject","Activity_Code")

activity_labels<- read.table(".\\UCI HAR Dataset\\activity_labels.txt")

# Combine together y data frames for both test and training
y_combined<- rbind(train_combined,test_combined)
y_combined<- merge(y_combined,activity_labels,by.x="Activity_Code",by.y="V1")
colnames(y_combined)[3]<- c("Activity")

# Combine together X data frames for both test and training. Give descriptive names to columns.
X_combined<- rbind(X_train, X_test)
names(X_combined)<- read.table(".\\UCI HAR Dataset\\features.txt")[,2]

# Filter out columnns that don't have mean or std in their names
X_combined_mean_std<- X_combined[, grep("mean|std",colnames(X_combined))]
final_combined<- cbind(y_combined,X_combined_mean_std)

# Create aggregated data frame that calculates mean column values per unique subject and activity
final_combined_means<- t(sapply(split(final_combined[,4:ncol(final_combined)],list(final_combined$Subject,final_combined$Activity_Code)),colMeans))

write.csv(final_combined_means,file="./final_combined_means.csv")
