#clearing the environment and setting the directory
rm(list=ls())
setwd("~/Desktop/UCI HAR Dataset") 
library(dplyr)
library(plyr)

######################
#  Step1
######################

#reading Train Data
c1 <- read.table("./train/subject_train.txt", header=F, stringsAsFactors = F)
c2 <- read.table("./train/y_train.txt", header = F, stringsAsFactors = F)
c3 <- read.table("./train/X_train.txt", header = F, stringsAsFactors = F)
train_data <- cbind(Volunteer_ID = c1$V1, Activity = c2$V1, c3)
rm("c1","c2","c3")

#reading Test Data
d1 <- read.table("./test/subject_test.txt", header=F, stringsAsFactors = F)
d2 <- read.table("./test/y_test.txt", header = F, stringsAsFactors = F)
d3 <- read.table("./test/X_test.txt", header = F, stringsAsFactors = F)
test_data <- cbind(Volunteer_ID = d1$V1, Activity = d2$V1, d3)
rm("d1", "d2", "d3")

# Combining Train and Test Data
data <- rbind(train_data, test_data)
rm("train_data","test_data")

#converting df to table df
data_table <- tbl_df(data)
rm("data")

######################
#  Step2
######################

#reading the selected feature names in a dataframe
feature <- read.table("./features.txt",header=F,stringsAsFactors = F)
feature_names <- feature %>% select(V2) 
selected_activity <- grep(".([mM]ean|[sS]td)",feature_names$V2,value=T)

#extracting only the mean & std for measurement
names(data_table) <- c("Volunteer_ID", "Activity", feature_names$V2)
column_names <- c("Volunteer_ID", "Activity", selected_activity)
data_ans <- data_table[, column_names] 
rm("data_table")

######################
#  Step3
######################

#reading the activity list
activity_list <- read.table("./activity_labels.txt", header = F, stringsAsFactors = F)
data_ans <- mutate(data_ans, Activity = activity_list[Activity,2])

######################
#  Step4
######################

#Variable Names already Assingned in Step 2

######################
#  Step5
######################
data_average <- ddply(data_ans,.(Volunteer_ID, Activity), function(h) colMeans(h[,3:88]))
write.table(data_average, "data_average.txt", row.name=FALSE)
