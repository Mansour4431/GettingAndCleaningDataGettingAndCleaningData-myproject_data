# GettingAndCleaningData-myproject_data

About this repository
This repository was created for the peer-graded assignment of:

Course 3: Getting And Cleaning Data, from Data Science Specialization,

The purpose of the assignment is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The assignment asked to:

You will be required to submit:

a tidy data set as described below
a link to a Github repository with your script for performing the analysis, and
a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

and for the main script, 'run_analysis.R' the requirements was that it should be able to run, as far as the 'UCI HAR Dataset' is present in the working directory and to be able to perform the following 5 steps:

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Details on the files that exist in this repository
README.md
It is the file you read right now and tries to explain the purpose and the contents of the repository.

get_project_data.R
It is the script that was used to download and unzip the files, needed to perform the analysis in the first place. It is recommended to use it but not necessary, as long as the files for the 'Human Activity Recognition Using Smartphones Dataset Version 1.0' are present in a folder with name 'UCI HAR Dataset' in the working directory. A lot of comments explain the code and informative messages are printed in console while it is executed, describing what it tries to do. Also, it creates a file with name 'log.txt' in the current working directory (only if it downloads the zipped data) to store the url and the date of the download. If the a folder with name 'UCI HAR Dataset' already exists in the working directory it just informs the user about it's existence and doesn't download the files.

run_analysis.R
It is the main script of the repository. As it is described in 'CodeBood.md':

In order to produce the 'tidy_data_summary' table, the script 'run_analysis.R' was created and used. It performs the following tasks:

Merges the training and the test sets to create one data set with target variables.
Binds these files,

UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt
from the train set by columns to a table that contains, the human subject, the activity performed and the values of the features.

Binds these files,

UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/y_test.txt
from the test set by columns to a table that contains, the human subject, the activity performed and the values of the features.

Binds the data frames created for test and train set into one large dataset by rows.

Extracts only the measurements on the mean and standard deviation for each measurement.
Finds the target features, which are the features with measurements about mean and standard deviation, and extracts them as well as those that indicate the 'subject' and 'activity' and creates a new data table only with the target variables.
Uses descriptive activity names to name the activities in the data set.
Replace the variable about activity, that contains integers from 1 to 6, with a factor based on levels and labels contained in the 'activity_labels' data file.
Appropriately labels the data set with target variables with descriptive names.
Extracts the target variable names from 'features.txt'.
Corrects a typo that exists in some feature names, that is to replace 'BodyBody' that appears in the names of some features with just 'Body'.
Creates a new tidy dataset with the appropriate labels for the variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Group the tidy data table created in step 4, by 'subject' and 'activity'.

Summarize each variable to find the average for the grouped values.

Ungroup the data table.

Add descriptive names to the variables of the new tidy data table, by adding the prefix 'Avrg-' in the names of the target feature averages.

Write the data in a text file in the present working directory, by the command:

write.table(tidy_data_summary, "tidy_data_summary.txt", row.names = FALSE) 
tidy_data_summary.txt
The tidy dataset that was produced by the script 'run_analysis.txt', which contains the averages of selected features from the original 'Human Activity Recognition Using Smartphones Dataset Version 1.0'. The 'CodeBook.md' contains the details about the 'tidy_data_summary' table.

To read the table back on R correctly, you can use the following command:

tidy_data_summary <- read.table(file = "tidy_data_summary.txt",
                                header = TRUE, check.names = FALSE, dec = ".") 
Or for faster loading some additional arguments can be specified:

tidy_data_summary <- read.table(file  = "tidy_data_summary.txt", 
                                header = TRUE, check.names = FALSE, dec = ".", 
                                colClasses = c("numeric", "factor", rep("numeric", 66)), 
                                nrows = 180, comment.char = "", quote = "") 
CodeBook.md
The code book contains informations on the 'tidy_data_summary' table. It consists of the following:

Table of Contents
Informations on 'tidy_data_summary' data table
Identificators and averages of features
Description for the variables of 'tidy_data_summary'
How to load 'tidy_data_summary' in R
About 'tidy_data_summary' table
The process by which the 'tidy_data_summary' table was produced
Description of the features on which the averages were based
Informations on how the features were produced from the raw data
Informations on the collection of raw data
About the original data set
License
