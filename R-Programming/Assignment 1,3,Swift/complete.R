Programming Assignment 1: Air Pollution Part 2

complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  #Construct file list with padding
  filelist<-sprintf("%s\\%03d.csv",directory,id)
  
  #Loop and construct df with moniter ID and count of completed cases
  df<-data.frame()
  for(i in 1:length(id)) {
    data<-read.csv(filelist[i])
    df<-rbind(df,c(id[i],sum(complete.cases(data))))
  }
  
  #Set column name
  colnames(df) <- c("id", "nobs")
  
  #Return df
  return(df)
}
