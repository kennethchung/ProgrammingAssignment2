## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
## This function converts a R based matrix into a cached matrix and
## and store inverse of the result
makeCacheMatrix <- function(x = matrix()) {
	m <- NULL
	set <- function(y) {
		x <<- y
		m <<- NULL
	}
	get <- function() x
	setInverse <- function(solve) m <<- solve
	getInverse <- function() m
	list(set = set, get = get,
			setInverse = setInverse,
			getInverse = getInverse)
}


## This function returns the inverse of a matrix from the cached result if 
## it was calculated before otherwise it will calculcate the inverse and store the result
cacheSolve <- function(x, ...) {
	m <- x$getInverse()
	if(!is.null(m)) {
		message("getting cached data")
		return(m)
	}
	data <- x$get()
	m <- solve(data, ...)
	x$setInverse(m)
	m
}


