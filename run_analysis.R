     

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
      
      #create datatables for grouping and summarising
      train2 <- train
      test2 <- test
      
      ##apply meaningful labels to activities
      for (j in 1:length(activities)){
            x <- strsplit(activities[j], split = " ")
            train_activity <- sub(j,x[[1]][2],train_activity)
            test_activity <- sub(j, x[[1]][2], test_activity)
      }
      train_activity <- data.frame(train_activity)
      test_activity <- data.frame(test_activity)
      
      ##make lower case for tidyness
      label_data <- tolower(label_data)

        ##rename column labels
      names(train) <- label_data
      names(train_activity) <- "activity"
      names(train_subject) <- "subject_code"  
      
      names(test) <- label_data
      names(test_activity) <- "activity"
      names(test_subject) <- "subject_code" 
        
      train_combined <- cbind(train_subject, train_activity, train)
      test_combined <- cbind(test_subject, test_activity, test)
      
      all_combined <- rbind(train_combined, test_combined)
      
      ##Tidy data set of combined data for mean() & std() of each measurement
      data_filtered <- select(all_combined, subject_code, activity, contains(c("mean()", "std()")))
      ##data_filtered first tidy dataset 
      
      ##build combined dataset for summarising
      train_combined2 <- cbind(train_subject, train_activity, train2)
      test_combined2 <- cbind(test_subject, test_activity, test2)
      
      all_combined2 <- rbind(train_combined2, test_combined2)
      ##group data set by subjects and activity
      a <- all_combined2 %>% group_by(subject_code, activity)
      
      ##loop through grouped data to summarise each variable with an
      ## average of each variable for each activity and each subject
      ## column names are changed after summarise as the new names wouldn't 
      ## work with the summarise function
      for(i in 1:561){
        v <- as.name(paste(c("V",i), collapse = ""))
        m <- label_data[i]
        b <- a %>% summarise(!!m := mean(!!v))
        if(i == 1){
          all_avg <- b
         }else{
          all_avg <- cbind(all_avg, b[,3])
        }
      }
      
      ##put tidy datasets into list for function to return
      wearable_datasets <- list(data_filtered, all_avg)
      wearable_datasets        
}
      