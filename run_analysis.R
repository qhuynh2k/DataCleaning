library(plyr)

# read activity label into data frame

activity_label <- read.table("activity_labels.txt")
colnames(activity_label) <- c("Activity_ID","Activity")

# read features into data frame

feature <- read.table("features.txt")
feature_names <- feature[,2]


# read training data into data frame

training <- read.table("./train/X_train.txt")
training_label <- read.table("./train/Y_train.txt")
training_subject <- read.table("./train/subject_train.txt")

# read test data into data frame

test <- read.table("./test/X_test.txt")
test_label <- read.table("./test/Y_test.txt")
test_subject <- read.table("./test/subject_test.txt")


# assign column name for activity and subject data frame

colnames(training_label) = c("Activity")
colnames(training_subject) = c("Subject")

colnames(test_label) = c("Activity")
colnames(test_subject) = c("Subject")


# add subject and activity to training data set. 
# using cbind instead of merge function so that there is no need to create a common key
# between those data frames

training <-cbind(training_label,training)
training <-cbind(training_subject,training)

test <-cbind(test_label,test)
test <-cbind(test_subject,test)


#Step 1. Merge the training and test set into one dataset

merge_data <- rbind(training, test)


#Step 3. Uses descriptive activity names to name the activities in the data set

merge_data <- merge(activity_label,merge_data,by.x="Activity_ID",by.y="Activity")

# remove the activity id column
merge_data <- merge_data[,c(2:ncol(merge_data))]


#Step 4. Appropriately labels the data set with descriptive variable names.
# Assign descriptive column names. Perform step here so that it can
# be used to identify mean() and std() in Step 2.

feature_names  <- c(c("Activity","Subject"),as.vector.factor(feature_names))
colnames(merge_data) = feature_names 


#Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

mean_std_measurement <- as.vector.factor(feature[grep("mean|std[()]",feature$Activity),2])
measurement <- merge_data[, c(mean_std_measurement)]


#Step 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

measures <- names(merge_data[,grep("Subject|Activity|energy",names(merge_data))])
tiny_data <- merge_data[,measures]
output_data <-aggregate(.~tiny_data$Activity + tiny_data$Subject,tiny_data,mean,na.action=na.omit)

#swap column
output_data <- output_data[,c("tiny_data$Subject","tiny_data$Activity",names(output_data[c(5:ncol(output_data))]))]

#change column name to reflect the content
colnames(output_data) <- c("Subject","Activity",gsub("-energy","-energy-mean",names(output_data[c(3:ncol(output_data))])))

#write to output file
write.csv(output_data, file = "tiny_data.txt")
