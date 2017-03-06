#Example codes

##### How to get datasets from package #####
library(UsingR)
#we could get data set by below commands
data(package = "UsingR")

##### Vector, Matrix, Array, DataFrame #####
#refer to http://www.statmethods.net/input/datatypes.html

#Vector
weightedstock <- c(2330, 2317, 6505, 2412)
weightedstockname <- c("台積電", "鴻海", "台塑化", "中華電")
stockmixed <- c("台積電", 2317, "台塑化", 2412)

#Matrix v.s array
x <- matrix(1:10, 2)
y <- array(1:10, c(2, 5))
identical(x, y)

#DataFrame
d <- c(1,2,3,4)
e <- c("red", "white", "red", NA)
f <- c(TRUE,TRUE,TRUE,FALSE)
mydata <- data.frame(d,e,f)
