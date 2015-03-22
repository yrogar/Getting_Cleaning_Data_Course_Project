#Reading all files
Subject1 <- read.table("./test/subject_test.txt", sep = "", header=FALSE, col.names = "Subject_id")
Activity1 <- read.table("./test/y_test.txt", sep = "", header=FALSE, col.names = "Activity_id")
Features_names <- read.table("features.txt", sep = "", header=FALSE)
Features1 <- read.table("./test/X_test.txt", sep = "", header=FALSE, col.names = Features_names$V2)
accx1 <- read.table("./test/Inertial Signals/body_acc_x_test.txt", sep = "", header=FALSE)
accy1 <- read.table("./test/Inertial Signals/body_acc_y_test.txt", sep = "", header=FALSE)
accz1 <- read.table("./test/Inertial Signals/body_acc_z_test.txt", sep = "", header=FALSE)
gyrox1 <- read.table("./test/Inertial Signals/body_gyro_x_test.txt", sep = "", header=FALSE)
gyroy1 <- read.table("./test/Inertial Signals/body_gyro_y_test.txt", sep = "", header=FALSE)
gyroz1 <- read.table("./test/Inertial Signals/body_gyro_z_test.txt", sep = "", header=FALSE)
totalx1 <- read.table("./test/Inertial Signals/total_acc_x_test.txt", sep = "", header=FALSE)
totaly1 <- read.table("./test/Inertial Signals/total_acc_y_test.txt", sep = "", header=FALSE)
totalz1 <- read.table("./test/Inertial Signals/total_acc_z_test.txt", sep = "", header=FALSE)
Subject2 <- read.table("./train/subject_train.txt", sep = "", header=FALSE, col.names = "Subject_id")
Activity2 <- read.table("./train/y_train.txt", sep = "", header=FALSE, col.names = "Activity_id")
Features2 <- read.table("./train/X_train.txt", sep = "", header=FALSE, col.names = Features_names$V2)
accx2 <- read.table("./train/Inertial Signals/body_acc_x_train.txt", sep = "", header=FALSE)
accy2 <- read.table("./train/Inertial Signals/body_acc_y_train.txt", sep = "", header=FALSE)
accz2 <- read.table("./train/Inertial Signals/body_acc_z_train.txt", sep = "", header=FALSE)
gyrox2 <- read.table("./train/Inertial Signals/body_gyro_x_train.txt", sep = "", header=FALSE)
gyroy2 <- read.table("./train/Inertial Signals/body_gyro_y_train.txt", sep = "", header=FALSE)
gyroz2 <- read.table("./train/Inertial Signals/body_gyro_z_train.txt", sep = "", header=FALSE)
totalx2 <- read.table("./train/Inertial Signals/total_acc_x_train.txt", sep = "", header=FALSE)
totaly2 <- read.table("./train/Inertial Signals/total_acc_y_train.txt", sep = "", header=FALSE)
totalz2 <- read.table("./train/Inertial Signals/total_acc_z_train.txt", sep = "", header=FALSE)
Activity_names <- read.table("activity_labels.txt", sep = "", header = FALSE, col.names = c("Activity_id", "Activity_name"))

#Joining all files in one data set
test <- cbind(Subject1, Activity1, Features1, accx1, accy1, accz1, gyrox1, gyroy1, gyroz1, totalx1, totaly1, totalz1)
train <- cbind(Subject2, Activity2, Features2, accx2, accy2, accz2, gyrox2, gyroy2, gyroz2, totalx2, totaly2, totalz2)
Data <- rbind(test, train)

#Selecting mean and std columns
Features_good1 <- grep("mean()", as.character(Features_names$V2), fixed = TRUE)
Features_good2 <- grep("std()", as.character(Features_names$V2), fixed = TRUE)
Features_good <- c(Features_good1, Features_good2)
Features_good <- sort(Features_good)+2
Data_Select <- Data[, c(1, 2, as.integer(Features_good))]

#Activity names
library(plyr)
Data_Select_act_name <- join(Data_Select, Activity_names)
Data_Select_act_name <- Data_Select_act_name[-2]

#Reordering columns
Final_Data <- Data_Select_act_name[c(1, 68, 2:67)]

#Making groups
Data_by_groups <- group_by(Final_Data, Activity_name, Subject_id, add = TRUE)

#Calculating average
library(dplyr)
Tidy_Data_Set <- summarise_each(Data_by_groups, funs(mean))

#Tidy Data file
write.table(Tidy_Data_Set, file = "Tidy_Data.txt", row.names = FALSE)
