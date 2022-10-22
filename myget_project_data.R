################################################################################
#  'myget_project_data.R'
################################################################################

# DESCRIPTION: This script downloads and extracts the 'UCI HAR Dataset'
#              in the working directory if the folder doesn't exists.

# DOWNLOAD URL:
# "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# PLAN:        Checks if the data files are available.
#              If the data don't exist,
#                  1. downloads the zipped file
#                  2. creates a log file,
#                     with the url used and the date of the download
#                  3. extracts the zipped file
#              else if the data files exist,
#                  1. informs that the files already exist

# NOTES:       When 'get_project_data.R' is executed,
#              informative messages are printed in console,
#              to describe what the script tries to do.




################################################################################
# Downloads and unzips the 'UCI HAR Dataset'
################################################################################

## Checks if the folder 'UCI HAR Dataset' (this is the default name) exists
## in the working directory.
##     * if the folder doesn't exists,
##           1. downloads the zipped files as 'data.zip',
##              in the working directory
##           2. creates a log to store the download url and date,
##              with name 'log.txt' in the working directory
##           3. extracts the zipped files in a folder with
##              the default name 'UCI HAR Dataset', in the working directory


# Checks if the folder 'UCI HAR Dataset' already exists in the working directory
message("Searching for folder 'UCI HAR Dataset' in the working directory...")

if (!dir.exists("UCI HAR Dataset")) {
      # ONE EXTREME COINCIDENCE
      ## It does a simplistic test, yet sufficient on most of the cases,
      ## that is to check if a folder with name 'UCI HAR Dataset' exists
      ## in the working directory to determine if it should download the files.
      ## Obviously if you have, by luck or on purpose, a folder with that name,
      ## it will mistakenly assume that it contains the correct data files.
      message("    ...no folder with name 'UCI HAR Dataset'",
              " exists in the working directory.")
      
      
      # Downloads the needed zipped files
      message("Trying to download the zipped file...")
      data_url = paste0("https://d396qusza40orc.cloudfront.net/",
                        "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
      download.file(data_url, "data.zip")
      message("    ...zipped data was downloaded successfully ",
              " in the working directory as 'data.zip'.")
      
      
      # Creates a log to to store
      # the url used for the download and the date when the download happened
      log_entry_url <- paste0("Data was downloaded from the url: ", data_url)
      log_entry_date <- paste0("Data was downloaded at date: " , date())
      
      log_con <- file("log.txt")
      writeLines(c(log_entry_url, log_entry_date), log_con)
      close(log_con)
      
      message("A file was created as 'log.txt' at the working directory \n",
              "which stores the url and the date, \n",
              "from which zipped data files where downloaded.")
      
      
      # Extracts files from zipped file 'data.zip'
      message("Trying to extract files from the 'data.zip'",
              "in the working directory...")
      unzip("data.zip")
      message("    ...data files extracted successfully, in the folder \n",
              "       with name 'UCI HAR Dataset' in the working directory.")
      
      
} else {
      message("    ...data files are available, in the folder \n",
              "       with name 'UCI HAR Dataset' in the working directory.")
}

# THE END ######################################################################
