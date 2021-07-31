na_count1 <-sapply(timesData, function(y) sum(length(which(is.na(y)))))
na_count1 <- data.frame(na_count1)
na_count1

str(timesData)

timesData$world_rank<-as.numeric(timesData$world_rank)
timesData$total_score<-as.numeric(timesData$total_score)

#timesData<-na.omit(timesData)
timesData$year<-factor(timesData$year)

