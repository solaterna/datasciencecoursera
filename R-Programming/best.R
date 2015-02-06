Programming Assignment 3: Hospital Quality-best.R

best <- function(state, outcome) {
  ## Test Data
  ##state<-"TX"
  ##outcome<-"heart attack"
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures2.csv", colClasses = "character")
  
  ## Shrink data set
  df<-data[,c(7,2,11,17,23)]
  names(df)<-c("state","hospital","heart attack","heart failure","pneumonia")
  
  ## Check that state and outcome are valid
  if (!any(state==unique(df[,1])))     stop("invalid state")
  if (!any(outcome==names(df[,3:5])))  stop("invalid outcome")
  
  ## filter data by state
  df<-df[df[[1]]==state,]
  
  # Convert outcome data to numeric and clean data
  suppressWarnings(df[,outcome]<-as.numeric(df[,outcome]))
  df<-na.omit(df)
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  ## Added sort and return first item if multiple hospital are listed
  return(sort(df[df[outcome]==min(df[[outcome]],na.rm=1),2])[1])
}
