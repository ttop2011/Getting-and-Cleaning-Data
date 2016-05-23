##necessary packages

library(data.table) 
library(dplyr)

trainx<-read.table("./train/X_train.txt")
    ##read in train x values
trainy<-read.table("./train/y_train.txt")
    ##read in train y values
trainsubject<-read.table("./train/subject_train.txt")
    ##read in train subject values
testx<-read.table("./test/X_test.txt")
    ##read in test x values
testy<-read.table("./test/y_test.txt")
    ##read in test y values
testsubject<-read.table("./test/subject_test.txt")
    ##read in test subject data
features<-read.table("./features.txt")
    ##read in features
    ##add column names
colnames(trainx) <- t(features[2])
colnames(testx) <- t(features[2])

trainx$activities <- trainy[, 1]
trainx$participants <- trainsubject[, 1]
testx$activities <- testy[, 1]
testx$participants <- testsubject[, 1]

    ##merge data together
Master <- rbind(trainx, testx)
duplicated(colnames(Master))
Master <- Master[, !duplicated(colnames(Master))]
    ##finds only the means
Mean <- grep("mean()", names(Master), value = FALSE, fixed = TRUE)
Mean <- append(Mean, 471:477)
InstrumentMeanMatrix <- Master[Mean]
    ## and stdevs
Stdev <- grep("std()", names(Master), value = FALSE)
InstrumentStdevMatrix <- Master[Stdev]
##add descriptions of activities done
Master$activities <- as.character(Master$activities)
Master$activities[Master$activities == 1] <- "Walking"
Master$activities[Master$activities == 2] <- "Walking Upstairs"
Master$activities[Master$activities == 3] <- "Walking Downstairs"
Master$activities[Master$activities == 4] <- "Sitting"
Master$activities[Master$activities == 5] <- "Standing"
Master$activities[Master$activities == 6] <- "Laying"
Master$activities <- as.factor(Master$activities)
## change headings to be descriptive
names(Master) <- gsub("Acc", "Accelerator", names(Master))
names(Master) <- gsub("Mag", "Magnitude", names(Master))
names(Master) <- gsub("Gyro", "Gyroscope", names(Master))
names(Master) <- gsub("^t", "time", names(Master))
names(Master) <- gsub("^f", "frequency", names(Master))
## next we want to change participant names to something meaningful
Master$participants <- as.character(Master$participants)
Master$participants[Master$participants == 1] <- "Participant 1"
Master$participants[Master$participants == 2] <- "Participant 2"
Master$participants[Master$participants == 3] <- "Participant 3"
Master$participants[Master$participants == 4] <- "Participant 4"
Master$participants[Master$participants == 5] <- "Participant 5"
Master$participants[Master$participants == 6] <- "Participant 6"
Master$participants[Master$participants == 7] <- "Participant 7"
Master$participants[Master$participants == 8] <- "Participant 8"
Master$participants[Master$participants == 9] <- "Participant 9"
Master$participants[Master$participants == 10] <- "Participant 10"
Master$participants[Master$participants == 11] <- "Participant 11"
Master$participants[Master$participants == 12] <- "Participant 12"
Master$participants[Master$participants == 13] <- "Participant 13"
Master$participants[Master$participants == 14] <- "Participant 14"
Master$participants[Master$participants == 15] <- "Participant 15"
Master$participants[Master$participants == 16] <- "Participant 16"
Master$participants[Master$participants == 17] <- "Participant 17"
Master$participants[Master$participants == 18] <- "Participant 18"
Master$participants[Master$participants == 19] <- "Participant 19"
Master$participants[Master$participants == 20] <- "Participant 20"
Master$participants[Master$participants == 21] <- "Participant 21"
Master$participants[Master$participants == 22] <- "Participant 22"
Master$participants[Master$participants == 23] <- "Participant 23"
Master$participants[Master$participants == 24] <- "Participant 24"
Master$participants[Master$participants == 25] <- "Participant 25"
Master$participants[Master$participants == 26] <- "Participant 26"
Master$participants[Master$participants == 27] <- "Participant 27"
Master$participants[Master$participants == 28] <- "Participant 28"
Master$participants[Master$participants == 29] <- "Participant 29"
Master$participants[Master$participants == 30] <- "Participant 30"
Master$participants <- as.factor(Master$participants)
##finally we clean up the data so that it is legible
Master.dt <- data.table(Master)
#mean of each column in master
TidyData <- Master.dt[, lapply(.SD, mean), by = 'participants,activities']
write.table(TidyData, file = "Tidy.txt", row.names = FALSE)