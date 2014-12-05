run_analysis <- function() {
        library(data.table)
        
        ##This first chunk of code will get the data from the different data sources
        ##and then turn into a single, tidy, data set
        
        features <- read.table("./UCI HAR Dataset/features.txt") ##Getting all of the feature names
        
        meancols <- grepl("Mean", features$V2, ignore.case = TRUE) ##Identifying the mean columns
        stdcols <- grepl("std", features$V2, ignore.case = TRUE) ##Identifying the std columns
        
        featmean <- features[meancols, ] ##Subsetting the features for only mean
        featstd <- features[stdcols, ] ##Subsetting the features for only std
        
        pared <- rbind(featmean, featstd) ##Binding the two sets (mean and std) above together
        pared <- pared[order(pared$V1), ] ##and then sorting them to keep them in order
        
        ##Getting the test and train data sets read into R
        test1 <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        test3 <- read.table("./UCI HAR Dataset/test/y_test.txt")
        test2 <- read.table("./UCI HAR Dataset/test/x_test.txt")
        train1 <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        train3 <- read.table("./UCI HAR Dataset/train/y_train.txt")
        train2 <- read.table("./UCI HAR Dataset/train/x_train.txt")
        
        paredtest2 <- test2[, pared$V1] ##Paring down the x-test data to only include the mean and std columns
        paredtrain2 <- train2[, pared$V1] ##Paring down the x-train data to only include the mean and std columns
        
        ##Giving the datasets meaningful column names
        names(test1) <- "Subject"
        names(paredtest2) <- pared$V2
        names(test3) <- "Activity"
        names(train1) <- "Subject"
        names(paredtrain2) <- pared$V2
        names(train3) <- "Activity"
        
        ##creating data frames that include all three test and train data sets in one data set
        testset <- data.frame(test1, test3, paredtest2)        
        trainset <- data.frame(train1, train3, paredtrain2)
        
        totalset <- rbind(testset, trainset) ##binding the test and training set together into one data set
        
        ##Rename the activity labels from numeric to meaningful factor
        act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        
        for (i in act_labels$V1) {
                totalset$Activity <- sub(i, act_labels$V2[i], totalset$Activity)
        }
        
        ##Now that I have a tidy data set from all of the different inputs
        ##I will average the data for each activity for each participant
        
        meanbysubandact <- data.table() ##Creates an empty data frame to hold all results
        
        ##Runs through the 30 subjects one at a time -- averages each column by activity -- binds it to the total data table
        for(i in 1:30) {
                sub <- totalset[totalset$Subject == i, ]
                sub1 <- as.data.table(sub)
                
                mv <- sub1[, lapply(.SD, mean), by = Activity]
                
                meanbysubandact <- rbind(meanbysubandact, mv)
        }
        
        write.table(meanbysubandact, "Final_Output.txt", row.name = FALSE)
}