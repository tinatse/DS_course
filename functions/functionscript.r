#Add two numbers together
add2 = function(x,y){
  x+y
}

add2(1,2)

#above 10
above10 = function(x){
  use = x>10
  x[use]
}

x = 1:20
above10(x)
#above n
above = function(x, n){
  use = x>n
  x[use]
}
above(x)


#above n, n is default 10
above = function(x, n=10){
  use = x>n
  x[use]
}
above(x)
above(x,5)

columnmean = function(y){
  nc = ncol(y) #calculate number of columns
  means = numeric(nc) # vector with means , same number as number of columns (nc)
  for(i in 1:nc){ 
    means[i] = mean(y[,i]) #mean of column i
  }
  means
}

columnmean(airquality)

#by default will remove NA
columnmean = function(y, removeNA = TRUE){
  nc = ncol(y) #calculate number of columns
  means = numeric(nc) # vector with means , same number as number of columns (nc)
  for(i in 1:nc){ 
    means[i] = mean(y[,i], na.rm = TRUE) #mean of column i
  }
  means
}

columnmean(airquality)

#lazy evaluation
#no partial matching in ... functions

lm <- function(x) { x * x }
lm
#finds my packages first then the one in base package... Base package is the last one to be looked at!
#serach order
#search()
