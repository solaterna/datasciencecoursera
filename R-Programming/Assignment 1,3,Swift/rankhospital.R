R Programming Assignment 3: Hospital Quality-rankhospital.R 

rankhospital <- function(state, outcome, num = "best") {
  ## Test Data
  ## state<-"TX"
  ## outcome<-"heart attack"
  ## num<-"best"

  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Shrink data set
  df<-data[,c(7,2,11,17,23)]
  names(df)[3:5]<-c("heart attack","heart failure","pneumonia")
  
  ## Check that state and outcome are valid
  if (!any(state==unique(df[,1])))     stop("invalid state")
  if (!any(outcome==names(df[,3:5])))  stop("invalid outcome")
  if (is.numeric(num)==TRUE && num > length((df[,2]))) return(NA)
  
  ## filter data by state
  df<-df[df[[1]]==state,]
  
  # Convert outcome data to numeric and clean data
  suppressWarnings(df[,outcome]<-as.numeric(df[,outcome]))
  df<-na.omit(df)
    
  # Sort outcome
  df<-df[order(df[outcome],df["Hospital.Name"]),]
  
  # List of top 5 not required, reuse later
  # df<-data.frame(c(df[2], df[outcome]),Ranked=1:nrow(df),stringsAsFactors = FALSE)

  ## Return hospital name in that state with the given rank
  ## 30-day death rate

  if (num=="best") {
    df[1,2]
  }
  else if (num=="worst") {
    df[nrow(df),2]
  }
  else df[num,2]
}


