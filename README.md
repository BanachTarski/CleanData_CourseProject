==================================================================
Getting and Cleaning Data - Course Project
==================================================================
Isaac Lawrence
==================================================================

The goal of this project was to produce tidy data from the UCI HAR Dataset, according to the principles [laid out by Hadley Wickham.](http://vita.had.co.nz/papers/tidy-data.pdf)

More information on the UCI HAR Dataset can be found in the README.txt file contained within the "UCI HAR Dataset"" directory.

==================================================================

Data processing for this assignment is all done in the script run_analysis.R.  This script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The training data is contained in 3 files within the "UCI HAR Dataset/train" directory:

* **X_train.txt** - numerical data from the wearable smartphone, the columns corresponding to features in features.txt, which is contained in the "UCI HAR Dataset" directory
* **y_train.txt** - numerical values corresponding to activities in activity_labels.txt, which is contained in the "UCI HAR Dataset" directory
* **subject_train.txt** - contains a number 1-30 indicating which subject the corresponding records in the other two files show data for

There are analogous files for the test data set.

All of the data processing is done in the R script run_analysis.R.  This script contains comments which indicate what is being done at each step.  Note that the script does not follow the exact order as the list above.

The script produces two .txt files:

* **TidyData.txt** contains data for 10299 observations for 6 activities and 30 subjects.  The columns in the file are explained in CodeBook.md.  For each subject/activity combination, there are 66 columns, giving us a total of 68 columns in the data set.  The 66 observation columns correspond to the features with names containing "mean()" or "std".  Note that this excludes the meanFreq() fields, which we are not interested in.  This topic is discussed in the [course forums](https://class.coursera.org/getdata-004/forum/thread?thread_id=311).

* **TidyDataAggregated.txt** contains data for 180 subject/activity combinations (30 subjects and 6 activities).  This file shows the average value for each of the 66 observation columns from TidyData.txt, for each subject/activity combination.

The data in these files is considered clean in that there is a single variable per column, and each observation is in a different row.
