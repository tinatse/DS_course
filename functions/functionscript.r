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


# Scoping Rules -----------------------------------------------------------
#Lexical Scoping
make.power = function(n) {
  pow = function(x) {
    x^n
  }
  pow
}

#cube is the make power to 3
cube = make.power(3)
cube(2)

#square function makes it to power of 2
square = make.power(2)
square(3)


#function environment 
ls(environment(cube))
get("n", environment(cube))


y = 10
f = function(x){
  y = 2
  y^2 + g(x)
}

g = function(x){
  x*y
}

#calculation is 
#y^2 + g(x)
#4 + (x*y)
#4 + (3*2)
f(3)
#10

g <- function(x) {
  a <- 3
  x+a+y
}

#x + a + y
#3 + a + y
g(2)

y =3

g(2)


