R Programming Assignment 3: Hospital Quality-rankall.R 

rankall <- function(outcome, num = "best") {

  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Shrink data set
  df<-data[,c(7,2,11,17,23)]
  names(df)[3:5]<-c("heart attack","heart failure","pneumonia")
  
  ## Check outcome are valid
  if (!any(outcome==names(df[,3:5])))  stop("invalid outcome")
  if (is.numeric(num)==TRUE && num > length((df[,2]))) return(NA)
  
  # Convert outcome data to numeric and clean data
  suppressWarnings(df[,outcome]<-as.numeric(df[,outcome]))
  df<-na.omit(df)

  # Sort outcome by state,outcome and hospital name
  df<-df[order(df["State"],df[outcome],df["Hospital.Name"]),]
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  finaldf<-data.frame()
  statelist<-unique(df[[1]])
  
  #Loop and extract item by num for each state
  for (i in 1:length(statelist)) {
    state<-statelist[i]
    currentset<-df[df[[1]]==state,]
    
    if (num=="best") {
      item <- 1
    } else if (num=="worst") {
      item<-nrow(currentset)
    } else {
      item<-num
    }
    finaldf<-rbind(finaldf,cbind(hospital=currentset[item,2],state))
  }
  rownames(finaldf)<-statelist
  return (finaldf)
}

