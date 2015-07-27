### Combination of these function below user may calculate a given matrix's inverse.
### Functions are supposed to calculate inverse only if it has not yet calculated &
### stored in cache previously.

## makeCacheMatrix() stores 1) a matrix 2) inverse of the matrix if already 
## calculated by cacheSolve(). makeCacheMatrix() is storing a list of 4 items 
## that are separate functions.

# "i" variable is used to store inverse of a matrix passed to the function
# - getMatrix sub-function simply returns a matrix passed to makeCacheMatrix function
# - setMatrix sub-function sets a different value for "x" (function argument) 
#   and nulls out "i" variable
# - setInverse sub-function caches an inverse of a matrix 
#   / that is calculated outside of this function -> cacheSolve() /
# - getInverse sub-function simply returns cached "i" variable
makeCacheMatrix <- function(x = matrix()) {
    i <- NULL
    getMatrix <- function() x
    setMatrix <- function(y) {
        x <<- y
        i <<- NULL
    }
    setInverse <- function(inverse) i <<- inverse
    getInverse <- function() i
    list(getMatrix=getMatrix, setMatrix=setMatrix, 
         setInverse=setInverse, getInverse=getInverse)
}

## cacheSolve function calculates inverse of a matrix using the feature of
## memory caching if possible.

# cacheSolve() retrieves stored inverse from makeCacheMatrix and evaluate its content:
# - if it is empty (NULL) then it calculates inverse value
# - otherwise it retrieves from cache
cacheSolve <- function(x, ...) { 
    inv <- x$getInverse()
    if(is.null(inv)) {
        invSolved <- solve(x$getMatrix())
        x$setInverse(invSolved)
        return(invSolved)
    }
    message("Value loaded from cache..")
    print(inv)
}

### Suggested usage // with console examples:
# - Create/load a matrix and assign it to a variable. // m <- matrix(1:4,2,2)
# - Load the makeCacheMatrix() and cacheSolve() functions.
# - Assign makeCacheMatrix() to a variable with the previously created/loaded 
#   matrix as function's argument. // mcm <- makeCacheMatrix(m)
# - You can check now what is stored now in cache:
#       mcm$getMatrix() will return initially created/loaded matrix.
#       mcm$getInverse() will return NULL since no inverse has been calculated yet.
# - If you want to change the cached matrix you may call mcm$setMatrix(m2) where
#   m2 represent the new matrix to be cached.
# - Calling cacheSolve(mcm) will return the inverse of cached matrix (and parallelly
#   will cache inverse value to memory).
# - You may check the cached inverse by calling mcm$getInverse() (and compare to the result
#   returned previously).
# - If you call cacheSolve(mcm) again (without changing cached matrix meanwhile), 
#   cacheSolve() will return matrix's inverse from memory instead of recalculating it.
#   You are informed about this on console with a message of "Value loaded from cache...".

