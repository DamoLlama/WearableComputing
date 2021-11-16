     

tidy_wearable_data <- function(){ 
      library(dplyr)
      options(dplyr.summarise.inform = FALSE)
      
      ##load datasets from source files 
      train <- read.table("data/train/X_train.txt")
      train_activity <- readLines("data/train/y_train.txt")
      train_subject <- read.table("data/train/subject_train.txt")
      
      test <- read.table("data/test/X_test.txt")
      test_activity <- readLines("data/test/y_test.txt")
      test_subject <- read.table("data/test/subject_test.txt")
      
      
      activities <- readLines("data/activity_labels.txt")
      label_data <- readLines("data/features.txt")
      
      ##apply meaningful labels to activities
      for (j in 1:length(activities)){
            x <- strsplit(activities[j], split = " ")
            train_activity <- sub(j,x[[1]][2],train_activity)
            test_activity <- sub(j, x[[1]][2], test_activity)
      }
      train_activity <- data.frame(train_activity)
      test_activity <- data.frame(test_activity)
      
      ##make lower case and remove number, space for tidiness
      label_data <- tolower(label_data)
      label_data <- sub("[0-9]+ ", "", label_data)

        ##rename column labels
      colnames(train) <- label_data
      colnames(train_activity) <- "activity"
      colnames(train_subject) <- "participant_number"  
      
      colnames(test) <- label_data
      colnames(test_activity) <- "activity"
      colnames(test_subject) <- "participant_number" 
        
      train_combined <- cbind(train_subject, train_activity, train)
      test_combined <- cbind(test_subject, test_activity, test)
      
      all_combined <- rbind(train_combined, test_combined)
      
      ##Tidy data set of combined data for mean() & std() of each measurement
      ##data_filtered first tidy dataset 
      data_filtered <- select(all_combined, participant_number, activity, contains(c("mean()", "std()")))
      

      ##group data set by subjects and activity
      a <- data_filtered %>% group_by(participant_number, activity)
      
      ##loop through grouped data to summarise each variable with an
      ## average of each variable for each activity and each subject
      for(i in 3:68){
        v <- as.name(v <- as.name(colnames(a[i])))
        m <- paste("average_",colnames(a[i]), sep = "")
        b <- a %>% summarise(!!m := mean(!!v))
        if(i == 3){
          all_avg <- b
         }else{
          all_avg <- cbind(all_avg, b[,3])
        }
      }
      
      ##write tidy dataset to file as output
      write.table(all_avg, file = "wearablecomputing_output.txt")

}
      