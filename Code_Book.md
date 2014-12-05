Variable names, types, and purposes:
        features - data frame - the feature names for the data set
        meancols - logical - list of logicals that is TRUE if the feature names of the data set that have "mean" in the name
        stdcols - logical - list of logicals that is TRUE ifthe feature names of the data set that have "std" in the name
        featmean - data frame - the feature names of the data set that have "mean" in the name
        featstd - data frame - the feature names of the data set that have "std" in the name
        pared - data frame - the sorted feature names of the data set that have both "std" and "mean" in the name 
        test1 - data frame - the raw subject list for each measurement in the test set
        test2 - data frame - the raw measurement data for each feature in the test set
        test3 - data frame - the raw activity list for each measurement in the test set
        train1 - data frame - the raw subject list for each measurement in the train set
        train2 - data frame - the raw measurement data for each feature in the train set
        train3 - data frame - the raw activity list for each measurement in the train set
        paredtest2 - data frame - the raw measurement data for each feature in the test set for only those columns with "mean" or "std"
        paredtrain2 - data frame - the raw measurement data for each feature in the train set for only those columns with "mean" or "std"
        testset - data frame - test1, test3, and paredtest2 combined into one data frame
        trainset - data frame - train1, train3, and paredtrain2 combined into one data frame
        act_labels - data frame - the activity labels and the corresponding number for each
        meanbysubandact - data table - the summarized data - includes the averages for each feature by activity by subject
        sub - data frame - temporary variable used to hold all of the raw data for each subject individually
        sub1 - data table - the same data in sub but coerced into a data table
        mv - data table - temporary variable used to hold each subjects mean by feature by activity

Transforms Performed
        Each transformed is described in detail throughout the run_analysis script via the comments.
        
        To summarize - the data is read into R in its raw form and combined into a single data set. 
        There are three files for the test and train data sets. 
        
        Only the features that measure the mean and stdev are kept - the rest of the features are removed. 
        
        The names for the columns are added - "Subject", "Activity", and each of the feature names through pared$V2.
        
        Finally, the data is averaged by Activity by Subject and outputted into file names "Final_Output.txt"