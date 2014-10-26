Description the raw data and the transformations that I use to get the final data.



I download the training and the test sets data from the project using this url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR
And unzip. 

I use the following files 

Train/X_train.txt: Training set. = I use it to create a data table with the name xtrain
Train/y_train.txt: Training labels. = I use it to create a data table with the name ytrain
Test/X_test.txt: Test set. =I use it to create a data table with the name xtest
Test/y_test.txt: Test labels. =I use it to create a data table with the name ytest
Train/subject_train.txt= I use it to create a data table with the name strain
Test/subject_train.txt = I use it to create a data table with the name stest

activity_labels.txt: = I use it to create a data table with the name activity_labels

features.txt: List of all features. = I use it to create a data table with the name feature


To create the data set I merge the training and the test sets and add the activity files. Created a Data with 10299 rows - 563 columns

Next I update the labels of the files using the files features


I created a data set using only variables that include the measurements mean or standard deviation. (MeanFreq is not included.)
This created 66 measurements + subject id + activity I'd 
This is a new table with 68 variables and 10299 observations.

In this new table I use descriptive activity names to name the activities in the data set. Example of descriptive activity "WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING"

I analyze the name in the features files in excel  and create a table call "descriptive.csv"  with the change I want to modified  the columns using gsub, v1 is the string to look for  and v2 is the new string to be updated . Than using a loop I change the columns names. I load Using ""descriptive = read.csv("./data/ descriptive.csv")"
                      


Description of the final data. In order to describe the final data well

From the data set I  create a second, independent tidy data set 
With the average of each variable for each activity and each subject.
My descripData is a messy  data, I notice the Column headers are values, not variable names.
                     
                        # 1) each variable forms a column
                        # 2) Each observation forms a row
                        # 3) Each type of observational unit forms a table
 
First I use group_by() and summarise_each() to calculate the average 
Of each variable for each activity and each subject.
Second to convert to tidy data I  use gather() to  takes multiple columns and collapses into key-value pairs, duplicating all other columns as needed.
I use chaining' (or 'piping') to show you the scripts
