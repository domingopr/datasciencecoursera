Description the raw data and the transformations that I use to get the final data.



I  Dowload the the training and the test sets data form the project using this url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR
and unziip. 

I use the following files 

train/X_train.txt: Training set. = I use it to  create a datatable with the name xtrain
train/y_train.txt: Training labels.= I use it to  create a datatable with the nameytrain
test/X_test.txt: Test set. =I use it to  create a datatable with the namextest
test/y_test.txt: Test labels.=I use it to  create a datatable with the nameytest
train/subject_train.txt= I use it to  create a datatable with the name strain
test/subject_train.txt = I use it to  create a datatable with the name stest

activity_labels.txt: = I use it to  create a datatable with the name activity_labels

features.txt: List of all features.= I use it to  create a datatable with the name feature


To create the data set I merges the training and the test sets and add the activity files . Created a  Data with  10299 rows - 563 columns

Next I update the labels of the files using the files features

I createt a data set using  only variables that include the measurements mean or standard deviation. (meanFreq is not included. )
This created  66 measurements + subject id + activity I'd 
This is a new table with 68 variables and  10299 observations.

In this new table I use  descriptive activity names to name the activities in the data set . Example of desctritive actibity "WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING"

I analize the name in the features files in excel  and create a table call "descriptive.csv"  with the change I want to aplicate to the columns using gsub, v1 is the string to look for  and v2 is the new string to be updated . Than using a loop I change the columns names. I load Using ""descriptive = read.csv("./data/UCIHARDataset/descriptive.csv")"
                      


Description of the final data. In order to describe the final data well

From the data set I  creates a second, independent tidy data set 
with the average of each variable for each activity and each subject.
My descripData is a messy  data, I notice the Column headers are values, not variable names.
                     # To comply with tidy data we need :
                        # 1) Each variable forms a column
                        # 2) Each observation forms a row
                        # 3) Each type of observational unit forms a table
 
First I use group_by() and summarise_each() to calculate the average 
of each variable for each activity and each subject.
Second to convert to tidy data I  use gather() to  takes multiple columns and collapses into key-value pairs,duplicating all other columns as needed.
I use chaining' (or 'piping') to show you the scripts
