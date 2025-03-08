## Create tidy data set for Human Activity Recognition Using Smartphones Dataset

## 1. Merges the training and the test sets to create one data set.

## First download and locate the data from the server
library(data.table)
FileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(FileUrl, destfile = "mydata.zip", method = "curl")
unzip("mydata.zip")

## Second load the data into R (assuming run_analysis.R is in the same folder as the downloaded data set and set directory to this folder)

## load feature names stored in features.txt
featurenames <- read.table("UCI HAR Dataset/features.txt")

## load test related data and give variable names
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE, na.strings = "NA")
names(subject_test) <- "subjectID"
X_test <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE, na.strings = "NA") # load feature
names(X_test) <- featurenames$V2 # name feature
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE, na.strings = "NA") # load test subject activities
names(y_test) <- "Activity" # name test subject activities

## load training related data and give variable names
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE, na.strings = "NA")
names(subject_train) <- "subjectID"
X_train <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE, na.strings = "NA") # load feature
names(X_train) <- featurenames$V2 # name feature
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE, na.strings = "NA") # load test subject activities
names(y_train) <- "Activity" # name test subject activities

## Third and finally, merge the training and the testing data sets
test <- cbind(subject_test,y_test,X_test)
train <- cbind(subject_train,y_train,X_train)
totaldata <- rbind(test,train)

## 2. Extracts only the measurements on the mean and standard deviation for each 
## measurement. 

## extract subject ID and activity label columns
id_act_label <- totaldata[,(1:2)]
## extract mean columns
mean_data <- totaldata[,grep('mean()',names(totaldata),fixed=TRUE)]
## extract std columns
std_data <- totaldata[,grep('std()',names(totaldata),fixed=TRUE)]
## merge all 3 above
totaldata_meanstd <- cbind(id_act_label,mean_data,std_data)

## 3. Uses descriptive activity names to name the activities in the data set

## for the questions below, not sure if it wants to use totaldata or 
## totaldata_meanstd so I'm going to assume we use totaldata for the following 
## questions

## load the activity labels
act_label <- read.table("UCI HAR Dataset/activity_labels.txt")
## switch numerical activity labels with descriptive activity names
totaldata$Activity <- factor(totaldata$Activity,labels=act_label$V2)

## 4. Appropriately labels the data set with descriptive variable names. 

names(totaldata) <- gsub("tBody","TimeDomainBody",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("fBody","FrequencyDomainBody",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("tGravity","TimeDomainGravity",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("Acc","Acceleration",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("Gyro", "Angularvelocity",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-XYZ","-3AxialSignals",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-X","-XAxis",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-Y","-YAxis",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-Z","-ZAxis",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("Mag","MagnitudeSignals",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-mean()","-MeanValue",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-std()","-StandardDeviation",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-mad()","-MedianAbsoluteDeviation ",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-max()","-LargestValueInArray",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-min()","-SmallestValueInArray",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-sma()","-SignalMagnitudeArea",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-energy()","-EnergyMeasure",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-iqr()","-InterquartileRange ",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-entropy()","-SignalEntropy",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-arCoeff()","-AutoRegresionCoefficients",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-correlation()","-CorrelationCoefficient",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-maxInds()", "-IndexOfFrequencyLargestMagnitude",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-meanFreq()","-WeightedAverageOfFrequencyComponentsForMeanFrequency",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-skewness()","-Skewness",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-kurtosis()","-Kurtosis",names(totaldata), fixed=TRUE)
names(totaldata) <- gsub("-bandsEnergy()","-EnergyOfFrequencyInterval.",names(totaldata), fixed=TRUE)

## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

## create a copy of totaldata
td <- data.table(totaldata)
tidy_mean <- td[,lapply(.SD,mean),by="subjectID,Activity"]
write.table(tidy_mean,file="TidyMeanData.txt",col.names = TRUE,row.names = FALSE)
