Programming Assignment 1: Air Pollution Part 3

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  ## Return a numeric vector of correlations
  
  #Construst list of files listed in directory
  filelist<-sprintf("%s\\%s",directory,list.files(directory))
  
  #Loop and check for complete cases of each monitor
  #if higher and threshold, write to cordata
  cordata<-numeric()
  for (i in 1:length(filelist)) {
    data<-read.csv(filelist[i])
    cdata<-data[complete.cases(data),]
    
    if (nrow(cdata)>threshold) {
      cordata <- c(cordata, cor(cdata$sulfate, cdata$nitrate))
    }
  }
  
  #Return cordata as numeric vector
  #intentionally without rounding; no loss of data.
  return(cordata)
}
