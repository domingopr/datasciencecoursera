## Attaching package: 'dplyr'
library(dplyr)
## Attaching package: 'tidyr'
library(tidyr)

## Dowloads the training and the test sets data from the project using this url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## and unzip it and copy the following files in your default R working directory.

## 'train/X_train.txt': Training set. = I use it to  create a datatable with the name xtrain
## 'train/y_train.txt': Training labels.= I use it to  create a datatable with the nameytrain
## 'test/X_test.txt': Test set. =I use it to  create a datatable with the namextest
## 'test/y_test.txt': Test labels.=I use it to  create a datatable with the nameytest
## 'features.txt': List of all features.= I use it to  create a datatable with the name feature
## 'train/subject_train.txt'= I use it to  create a datatable with the name strain
## 'test/subject_train.txt' = I use it to  create a datatable with the name stest
## 'activity_labels.txt': = I use it to  create a datatable with the name activity_labels

## Now we will going to read.txt fields already downloading and unzipping and moving to the working directory
## Create data for the project 
## Load the data and create the working files

## test data

                      xtest = read.table("./X_test.txt",sep="",header=FALSE)
                      ytest = read.table("./Y_test.txt",sep="",header=FALSE)
                      stest = read.table("./subject_test.txt",sep="",header=FALSE)
                      
## label data          
                      feature = read.table("./features.txt",sep="",header=FALSE)
                      activity_labels = read.table("./activity_labels.txt",sep="",header=FALSE)
                     
                      
## train data
                      xtrain = read.table("./X_train.txt",sep="",header=FALSE)
                      ytrain = read.table("./Y_train.txt",sep="",header=FALSE)
                      strain = read.table("./subject_train.txt",sep="",header=FALSE)
              
                      


                      
## Add additional column  subject and Activity  to  the training and the test sets to create one data set using cbind.                                         
                      test<- cbind(xtest,stest,ytest)
                      
                      train<- cbind(xtrain,strain,ytrain)

## remove the original data frame from your workspace with rm().


        rm("xtest")
        rm("ytest")
        rm("stest")
        rm("xtrain")
        rm("ytrain")
        rm("strain")


# change the last two to avoid duplicate
                                          
                      colnames(test)[c(562,563)] <- c("V562","V563")

                      colnames(train)[c(562,563)] <- c("V562","V563")
                      


## Step 1. Merges the training and the test sets to create one data set.
##Default - merge all common column names

mergedata = merge(train,test,all=TRUE) ##Data Table 10299 rows - 563 columns
rm("test") ## remove the originaldataframe from your workspace with rm().
rm("train") ## remove the originaldataframe from your workspace with rm().

                                             
## Links the class labels with their activity name.
        names(mergedata)<-feature[[2]]
## change the last two column names , was change by  name to "na" , feauture have only
## 561 columns names and my merge data have 563 columns. 
## next time I have to use rbind  to add to feature two rows .
                      ##V1                V2
                      ## 1  1 tBodyAcc-mean()-X
                      ## 2  2 tBodyAcc-mean()-Y
                      ## 562 Subject
                      ## 563 Subject
        
                      colnames(mergedata)[c(562,563)] <- c("Subject","Activity")



                        colNames <-names(mergedata)

                        colNames <- (colNames[(grepl("mean()",colNames)
                       
                       != grepl("meanFreq()", colNames)
                       
                       | grepl("std()",colNames)
                       
                       | grepl("Subject",colNames)
                       
                       | grepl("Activity",colNames)) == TRUE])

                dataset <- mergedata[ ,colNames] ## This is a table with 68 variables and  10299 observations
                rm(mergedata)  ## remove the originaldataframe from your workspace with rm().

## load as data frame tbl to take advantage of the print 
        restData <- tbl_df(dataset) ## This is a table with 68 variables and  10299 observations
        rm(dataset)  ## remove the data frame from your workspace with rm().
## Step 3. Uses descriptive activity names to name the activities in the data set 
#  variable y is coded 1, 2 ,3,4,5, 6  
#  we want to attach value labels  WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING 

                        restData$Activity <- factor(restData$Activity,
                                levels = c(1,2,3,4,5,6),
                                labels = activity_labels[[2]])
                       
## Step 4 .Appropriately labels the data set with descriptive variable names
## To expand all abbreviations using regular expressions to manipulate column names.
## I analyze the name in the features files in excel  and create a table call "descriptive.csv"
## I  modify  the columns using gsub, v1 is the string to look for 
## and v2 is the new string to be updated . Than using a loop I change the columns names.
## I load Using ""descriptive = read.csv("./data/UCIHARDataset/descriptive.csv")"
                      
                      #v1,v2
                      #tB,time_B
                      #tG,time_G
                      #fBody,frequency_Body_
                      #fG,frequency_G
                      #Gyro,_gyroscope_
                      #Acc,_accelerometer_
                      #Jerk,Jerk_signals_
                      #Mag,magnitude_
                      #-X,_X_directions
                      #-Y,_Y_directions
                      #-Z,_Z_directions
                      #-std[:(:][:):],_std
                      #-mean[:(:][:):],_mean
                      
      
## For the project I create a table descritptive for you. 


        descriptive <- matrix(c("tB","time_B","tG,time_G","fBody","frequency_Body_","fG","frequency_G","Gyro","_gyroscope_","Acc","_accelerometer_","Jerk","Jerk_signals_","Mag,magnitude_","-X","_X_directions","-Y","_Y_directions","-Z","_Z_directions","-std[:(:][:):]","_std","-mean[:(:][:):]","_mean"),ncol=2,byrow=TRUE)
 
        descriptive <- as.table(descriptive)
        colnames(descriptive) <- c("v1","v2")


                 colNames <-names(restData) ## create a vector with the column name of the data 
                      y <- colNames
                      
                                            
                      for ( i in 1:length((descriptive[,1])) ) {
                              y<- gsub(descriptive[i,1],descriptive[i,2],y)
                      }
                      
                      
## copy data with the labels with descriptive variable names
                descripData<-restData ## create a new dataframe.
                rm(restData)  ## remove dataframe from your workspace with rm().
                names(descripData)<-y   ##copy data with the labels with descriptive variable names                   



## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
## My descripData is a messy  data, I notice the Column headers are values, not variable names.
                     # To comply with tidy data we need :
                        # 1) Each variable forms a column
                        # 2) Each observation forms a row
                        # 3) Each type of observational unit forms a table
 
## First I goin to use group_by() and summarise_each() to calculate the average 
## of each variable for each activity and each subject.
## Second to convert to tidy data I  use gather() to  takes multiple columns and collapses into key-value pairs,
## duplicating all other columns as needed.
## I use chaining' (or 'piping') to show you the scripts
                      
                      
                      tidyData <-
                              descripData %>%
                              group_by(Subject,Activity) %>%
                              summarise_each(funs(mean))%>%
                              arrange(Subject,Activity)%>%
                              gather(signal_type,Mean,-c(Subject,Activity))%>%
                                                    
                        # Print result to console                      
                        print(tidyData)

