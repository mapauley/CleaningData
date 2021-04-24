# Load packages
library(tidyverse) 
library(lubridate)
library(data.table)

# Read features, the second column in features.txt; unlist() converts the data
# frame returned by fread() to a vector
features <-
  fread("./features.txt",
        select = c(2),
        header = FALSE,
        col.names = c("features")) %>%
  unlist()

# Read subject data, naming the (one) column "Subject" and adding a column that
# specifies the role the subject had, either training or testing
trainSubjects <-
  fread("./subject_train.txt",
        header = FALSE,
        col.names = c("Subject")) %>%
  mutate(Role = "Train")
testSubjects <-
    fread("./subject_test.txt",
          header = FALSE,
          col.names = c("Subject")) %>%
  mutate(Role = "Test")

# Read X files, setting the column names to the strings in features and
# selecting only the columns with "mean()" and "std()" in their names 
trainX <-
  fread("./X_train.txt",
        header = FALSE,
        col.names = features) %>%
  select(contains("mean()") | contains("std()"))
testX <-
  fread("./X_test.txt",
        header = FALSE,
        col.names = features) %>%
  select(contains("mean()") | contains("std()"))

# Read the Y files, specifying the name of the (one) column and replacing the
# activity number with the activity name 
trainY <-
  fread("./Y_train.txt",
        header = FALSE,
        col.names = c("Activity")) %>%
  mutate(Activity = case_when(Activity == 1 ~ "Walking",
                              Activity == 2 ~ "Walking upstairs",
                              Activity == 3 ~ "Walking downstairs",
                              Activity == 4 ~ "Sitting",
                              Activity == 5 ~ "Standing",
                              Activity == 6 ~ "Laying"))
testY <-
    fread("./Y_test.txt",
          header = FALSE,
          col.names = c("Activity")) %>%
    mutate(Activity = case_when(Activity == 1 ~ "Walking",
                                Activity == 2 ~ "Walking upstairs",
                                Activity == 3 ~ "Walking downstairs",
                                Activity == 4 ~ "Sitting",
                                Activity == 5 ~ "Standing",
                                Activity == 6 ~ "Laying"))

# Bind the subject, Y, and X data into single data frames
trainData <- cbind(trainSubjects, trainY, trainX)
testData <- cbind(testSubjects, testY, testX)

# Join the data frames. Since a subject was not used to both train and test, 
# the result is a merged data set. suppressMessages() turns off the message
# about how the frames were joined.
data <- suppressMessages(full_join(trainData, testData))

# Group the data by subject, activity, and role and then calculate the mean of
# the mean() and std() columns of the resulting groups.  
dataSummary <-
  data %>%
  group_by(Subject, Activity, Role) %>%
  summarize(across(contains("mean()") | contains("std()"), mean), .groups = "keep")

# Write the results to a file without storing row names
write.csv(dataSummary, file = "./dataSummary.csv", row.names = FALSE)