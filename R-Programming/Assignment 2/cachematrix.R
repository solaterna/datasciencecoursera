## This function creates a list of operations to get and set matrix as well 
## as get and set inverse of matrix
## m is the variable which stores the cache of matrix
makeCacheMatrix <- function(x = matrix()) {
  
  ## initial m as null, m is the cache
  m <- NULL 
  
  ## set function, to reinitialise cache
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  
  ## get function, returns current matrix
  get <- function() x
  
  ## setinverse function, super-assign matrix inverse to m in the parent frame
  setinverse <- function(inverse) m <<- inverse
  
  ## getinverse function, return m
  getinverse <- function() m
  
  ## create return list of 4 operations
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## This function uses the list of operations which makeCacheMatrix provides
## to store the cache of matrix inverse
cacheSolve <- function(x, ...) {

  m <- x$getinverse() #get cache
  
  ## if cache is not null, return cache of matrix inverse
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  
  ## assigns matrix to data
  data <- x$get()
  
  ## get inverse of data using solve
  m <- solve(data, ...)
  
  ## using setinverse to cache results of m
  x$setinverse(m)
  
  ## Return a matrix that is the inverse of 'x'
  m
}

# # Code Test
# # load source
# source("cachematrix.R")
# 
# # create test matrix
# matrixA<-rbind(c(1,8,-9,7,5),c(0,1,0,4,4),c(0,0,1,2,5), c(0,0,0,1,-5), c(0,0,0,0,1))
# matrixA<-rbind(c(1,10,59,3),c(0,1,85,3),c(0,0,1,6), c(0,0,0,1))
# matrixA<-rbind(c(1,2,3),c(0,1,3),c(0,0,1))
# 
# # get inverse of test matrix if matrix is the same, else recache
# if (identical(a$get(),matrixA)){
#     matrixAinv<-cacheSolve(a)
#     
#     # Check if inverse works
#     identical(matrixA%*%matrixAinv,diag(1,nrow(matrixA),ncol(matrixA)))
#     print(a$get())
#     print(a$getinverse())
#     
# } else {
#   # reinitialise cache with using new matrix
#   a$set(matrixA)
#   matrixAinv<-cacheSolve(a)
#   
#   # Check if inverse works
#   identical(matrixA%*%matrixAinv,diag(1,nrow(matrixA),ncol(matrixA)))
#   print(a$get())
#   print(a$getinverse())
# }



