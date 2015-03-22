The "run_analysis.R" file works in the following way:

1. Scripts 2 through 26 load all the neccessary txt files to create the whole data frame in R. Also, they label every column with descriptive variables names by the col.name argument of read.table.
2. Script 29 binds all the columns corresponding to test measurements.
3. Script 30 binds all the columns corresponding to train measurements.
4. Script 31 binds the rows of test and train measurements so we have now a data frame containing the test and the training sets.
5. Scripts 34 through 37 give us a vector containing the indices of the columns that we are interested in (only mean and standard deviation for each measurement).
6. Script 38 extracts only the columns that concern to us according to the previous vector.
7. Scripts 42 through 44 replace activity identifiers with activity names.
8. Script 47 reorders columns in the data frame.
9. Script 50 makes groups in the data frame, according to subject and activity variables.
10. Scripts 53 and 54 give us a new data frame containig the average of each variable for each activity and each subject.
11. Script 57 save the new data set as a txt file named "Tidy_Data.txt".