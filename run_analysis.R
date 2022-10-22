################################################################################
# Mansour_haghi
################################################################################
# IMPORTANT: This script, 'run_analysis.R', works under one requirement:
#                 A folder with name 'UCI HAR Dataset' ,
#                 is present in the working directory
#                 that contains the following data files:
#                   - UCI HAR Dataset/activity_labels.txt
#                   - UCI HAR Dataset/features.txt
#                   - UCI HAR Dataset/test/subject_test.txt
#                   - UCI HAR Dataset/test/X_test.txt
#                   - UCI HAR Dataset/test/y_test.txt
#                   - UCI HAR Dataset/train/subject_train.txt
#                   - UCI HAR Dataset/train/X_train.txt
#                   - UCI HAR Dataset/train/y_train.txt
#                 from 'Human Activity Recognition Using
#                       Smartphones Dataset Version 1.0'
#                 which can be downloaded from the following url:
#                 "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#
#            TIP   
#            The script 'get_project_data.R' was created and used,
#            to download and extract the needed files for 'run_analysis.R'.
#            It is recommended to use it, but not necessary.
#            It is available on Git Hub, through this link:
#            "https://github.com/jzstats/Getting-and-Cleaning-Data-Assignment/blob/master/get_project_data.R"
#
#            ABOUT
#            The script was created:
#               - in RStudio Version 1.1.383
#               - with R version 3.4.3
#               - and used dplyr_0.7.4
#               - data was downloaded at date: 'Wed Jan 31 20:09:05 2018'

# DESCRIPTION: The script 'run_analysis.R' follows strictly the instruction
#              given by assignment, in a simple straightforward way.
#                 0. Loads the data in R.
#              Then 5 main steps are executed in order.
#                 1. Merges the training and the test sets
#                    to create one data set.
#                 2. Extracts only the measurements on the mean
#                    and standard deviation for each measurement.
#                 3. Uses descriptive activity names
#                    to name the activities in the data set.
#                 4. Appropriately labels the data set
#                    with descriptive variable names.
#                 5. From the data set in step 4,
#                    creates a second, independent tidy data set
#                    with the average of each variable
#                    for each activity and each subject.

# RESULT:   The result is to create the 'tidy_data_summary' data table
#           with the average values for the target features,
#           which is saved as 'tidy_data_summary.txt' in the working directory.
#          
#           The resulting data table, can be loaded in R,
#           with correct variable names, classes and values by the command:
#
#           tidy_data_summary <- read.table(file = "tidy_data_summary.txt",
#                                           header = TRUE, check.names = FALSE,
#                                           dec = ".") 
#
#           or for faster loading:
#
#           tidy_data_summary <- read.table(file  = "tidy_data_summary.txt",
#                                           header = TRUE, check.names = FALSE,
#                                           dec = ".",
#                                           colClasses = c("numeric", "factor",
#                                                          "rep("numeric", 66)),
#                                           nrows = 180,
#                                           comments.char = "", quote = "") 
#          
#           Details on the 'tidy_data_summary' table can be found,
#           at 'CodeBook.md' that exist in the Git Hub, from the link:
#           "https://github.com/jzstats/Getting-and-Cleaning-Data-Assignment/blob/master/CodeBook.md"
#




################################################################################
# Loads required libraries
################################################################################
# Version: dplyr_0_7_4.
library(dplyr)




################################################################################
# STEP 0: Loads all the data files needed for this analysis in R
################################################################################

## Plan: 1. Create a list with instructions for read.table(),
##          that contains the correct arguments for each file,
##          to be supplied through 'Map()'.
##          The list contains the values for the arguments of 'read.table()':
##              - 'file'
##              - 'colClasses'
##              - 'nrows'
##          for each file we want to load.
##       2. Use 'Map()' to load each files with function 'read.table()',
##          based on the instructions supplied for each file's arguments
##          in the 'read.table_instructions' list
##          as well as some extra, common arguments for all files.

## Some thoughts about the plan:
##    The use of Map() is not necessary when a small number of files is needed,
##    like in this analysis, where it is not obvious if it really saves space..
##    However when a lot of files have to be treated in a similar way
##    it should always be used, not only to save time and effort,
##    but also to avoid one source of common errors in coding,
##    which is the programmer who writes the same commands many times.
##    According to the 'D.R.Y' principle: "Don't Repeat Yourself"


message("Trying to load data files in R...")

## Creates the list with the instructions needed by 'read.table()'
read.table_instructions <- list(
      # The first object is a list with name 'file'
      # that contains values for 'file' argument,
      # which indicates the path of each file.
      file = list(
            activity_labels = "UCI HAR Dataset/activity_labels.txt",
            features = "UCI HAR Dataset/features.txt",
            subject_train = "UCI HAR Dataset/train/subject_train.txt",
            y_train = "UCI HAR Dataset/train/y_train.txt",
            X_train = "UCI HAR Dataset/train/X_train.txt",
            subject_test = "UCI HAR Dataset/test/subject_test.txt",
            y_test = "UCI HAR Dataset/test/y_test.txt",
            X_test = "UCI HAR Dataset/test/X_test.txt"
      ),
      # The second object is a list with name 'colClasses'
      # that contains the values for 'colClasses' argument
      # that indicates the classes of all variables in each file.
      # It is supplied to correctly identify column classes,
      # and as side effect also improves reading speed.
      colClasses = list(
            activity_labels = c("integer", "character"),
            features = c("integer", "character"),
            subject_train = "integer",
            y_train = "integer",
            X_train = rep("numeric", 561),
            subject_test = "integer",
            y_test = "integer",
            X_test = rep("numeric", 561)
      ),
      # The third object is a list with name 'nrows'
      # that contains the values for 'nrows' argument
      # that indicates the number of rows to read in each file.
      # It is supplied for speed.
      nrows = list(
            activity_labels = 6,
            features = 561,
            subject_train = 7352,
            y_train = 7352,
            X_train = 7352,
            subject_test = 2947,
            y_test = 2947,
            X_test = 2947
      )
)

## Uses the instructions created above to load all needed data with 'Map()'.
## For each file the correct arguments are supplied to function 'read.table()',
## as well as some extra, common arguments for all files.
## Function 'with()' is used for clearer code.
data_files <- with(read.table_instructions,
                   Map(read.table,
                       file = file, colClasses = colClasses, nrows = nrows,
                       quote = "", comment.char = "",
                       stringsAsFactors = FALSE))

message("    ...data files were successfully loaded into R, \n",
        "       in the list with name 'data_files'.")




################################################################################
# STEP 1: Merges the training and the test sets to create one data set.
################################################################################

## Plan: 1. Bind the files of the train set together by columns.
##       2. Bind the files of the test set together by columns.
##       3. Bind the data frames created for test and train set
##          into one large dataset by rows.

## Merges the train and test sets
merged_data <- with(data_files,
                    rbind(cbind(subject_train, y_train, X_train),
                          cbind(subject_test,  y_test,  X_test)))




################################################################################
# STEP 2: Extracts only the measurements on the mean and standard deviation
#         for each measurement.
################################################################################

## Plan: 1. Find the target feature indexes which are the features
##          with names that contain either the string 'mean()' or 'std()',
##          from the data frame 'features'.
##       2. Add 2 to each index to adjust for the two extra column
##          in the beginning of the merged data frame, 'subject' and 'activity',
##          to create a vector with all target variables indexes.
##       3. Extract only the target variables from the merged data frame.

## Finds the target features indexes from the 'features' data frame,
## by searching for matches with pattens 'mean()' or 'std()'
target_features_indexes <- grep("mean\\(\\)|std\\(\\)",
                                data_files$features[[2]])

## Add 2 to each index to adjust for the first 2 column we have bind
## that should also be included
target_variables_indexes <- c(1, 2, # the first two columns that refer to
                              # 'subject' and 'activity'
                              # should be included
                              # adds 2 to correct the indexes
                              # of target features indexes because of
                              # the 2 extra columns we have included
                              target_features_indexes + 2)

## Extracts the target variables to create the target data frame
target_data <- merged_data[ , target_variables_indexes]




################################################################################
# STEP 3: Uses descriptive activity names to name the activities in the data set
################################################################################

## Replace activity values with a factor based on levels and labels
## contained in the activity_labels data file.
target_data[[2]] <- factor(target_data[[2]],
                           levels = data_files$activity_labels[[1]],
                           labels = data_files$activity_labels[[2]])




################################################################################
# STEP 4: Appropriately labels the data set with descriptive variable names.
################################################################################

## Plan: 1. Extracts the target variable names from 'features',
##          with the use of the target features indexes created in STEP 2
##       2. Corrects a typo that exists in some feature names
##       3. Create a new tidy dataset with the appropriate labels
##          for the variable names

## Extract the target variables names
descriptive_variable_names <- data_files$features[[2]][target_features_indexes]

## Correct a typo
descriptive_variable_names <- gsub(pattern = "BodyBody", replacement = "Body",
                                   descriptive_variable_names)

## Create a tidy data set with appropriate labels for the variable names
tidy_data <- target_data
names(tidy_data) <- c("subject", "activity", descriptive_variable_names)




################################################################################
# STEP 5: From the data set in step 4, creates a second, independent
#         tidy data set with the average of each variable
#         for each activity and each subject.
################################################################################

## Plan: 1. Group the tidy data table created in step 4,
##          by 'subject' and 'activity'
##       2. Summarize each variable to find the mean for the grouped values
##       3. Ungroup the data table
##       4. Add descriptive names to the variables of the new tidy data table
##       5. Write the data in a text file in the present working directory

## Create a dataset with the mean of each column for 'subject' and 'activity'
tidy_data_summary <- tidy_data %>%
      group_by(subject, activity) %>%
      summarise_all(funs(mean)) %>%
      ungroup()

## Replace the variable names of 'tidy_data_summary' with new descriptive ones.
## Just the prefix "Avrg-" will be added in all variable names,
## except the first two, 'subject' and 'activity'.
new_names_for_summary <- c(names(tidy_data_summary[c(1,2)]),
                           paste0("Avrg-", names(tidy_data_summary[-c(1, 2)])))
names(tidy_data_summary) <- new_names_for_summary

## Save the data frame created as a text file in working directory
write.table(tidy_data_summary, "tidy_data_summary.txt", row.names = FALSE)

message("The script 'run_analysis.R was executed successfully. \n",
        "As a result, a new tidy data set was created with name \n", 
        "'tidy_data_summary.txt' in the working directory.")

# THE END ######################################################################
