R Programming Assignment 1: Air Pollution Part 1

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  #Construct list of files with padding
  filelist<-sprintf("%s\\%03d.csv",directory,id)
  
  #Check for pollutant input
  if (!any(pollutant==c("sulfate","nitrate")))  return("Invalid pollutant: specify either sulfate or nitrate")
  
  #Loop and read all specified monitors for specified pollutant
  allpollutant<-numeric()
  for (i in 1:length(id)) {
    data<-read.csv(filelist[i])
    allpollutant<-c(allpollutant,data[,pollutant])
  }
  
  #return mean of pollutant excluding NA
  #Intentionally without rounding; No loss of data
  return (mean(allpollutant,na.rm=1))
}

