##### Practical Data Science: Analyzing Stock Market Data with R #####
##### Lecture 1: Insight from a Moving Average #####

#moving average, the grand-daddy of all indicators.

library(quantmod)
fromDate <- "2016-01-01"

getSymbols('5203.TW', src='yahoo', from = fromDate)

price_vector <- `5203.TW`$'5203.TW.Close'

plot(price_vector)

period <- 100
moving_average_vector <- c()
for (ind in seq((period+1),(length(price_vector))) ) {
  print(ind)
  moving_average_vector <- c(moving_average_vector,
                             mean(price_vector[(ind-period):ind]))
}
#par(mfrow=c(2,1))
plot(price_vector)

#SMA -> Simple Moving Average
plot(moving_average_vector, type='l', col='red', lwd=3, main = paste('SMA', period))

#To think
length(moving_average_vector)
length(price_vector)
if(length(price_vector) - length(moving_average_vector) == period) {
  print("Yes")
}

#As a result we provide below function to avoid data not sync in the same point
c(rep(as.numeric(price_vector[period]), period))

moving_average_vector <- c(rep(NA, period))
for (ind in seq((period+1),(length(price_vector))) ){
  moving_average_vector <- c(moving_average_vector, mean(price_vector[(ind-period):ind]))
}

# pass it back to time series object
`5203.TW`$'5203.TW.Close.SMA' <- moving_average_vector
plot(`5203.TW`$'X5203.TW.Close')
lines(`5203.TW`$'5203.TW.Close.SMA', type='l', col='red', lwd=2)

# by addSMA function
chartSeries(price_vector, theme="white", TA="addSMA(90)")

##### Lecture 2: Insight from Multiple Moving Averages #####
library(quantmod)
company <- "2356.TW"
closePrice <- Cl(getSymbols(company, from = fromDate ,auto.assign=FALSE))
names(closePrice)[1] <- "Close"
#EMA : 平滑移動平均線
chartSeries(closePrice, theme="white", TA="addEMA(50,col='black');addEMA(200, col='blue')")
EMA10 <- EMA(price_vector, n=10)
EMA50 <- EMA(price_vector, n=50)
EMA200 <- EMA(price_vector, n=200)
Fast.Diff <- EMA10 - EMA50
Slow.Diff <- EMA50 - EMA200
# Detrending the Data by Subtracting Two Moving Averages
addTA(Fast.Diff, col='blue', type='h',legend="10-50 MA")
addTA(Slow.Diff, col='blue', type='h',legend="50-200 MA")


# install.packages('binhf')
library(binhf)
# look for long entries
Long_Trades <- ifelse(
  Slow.Diff  > 0 &
    Fast.Diff  > 0 &
    shift(v=as.numeric(Fast.Diff), places=1, dir="right") < 0,
  closePrice, NA)
# look for long exits (same thing but inverse signts)
Short_Trades <- ifelse(
  Slow.Diff  < 0 &
    Fast.Diff  < 0 &
    shift(v=as.numeric(Fast.Diff), places=1, dir="right") > 0,
  closePrice, NA)
plot(closePrice)
points(Long_Trades, col='blue', cex=1.5, pch=18)
points(Short_Trades, col='red', cex=1.5, pch=18)


##### Lecture 3: More Insight from Multiple Moving Averages #####
library(quantmod)
library(TTR)
library(binhf)
fromDate <- "2016-01-01"
company <- "2356.TW"
getSymbols(company, src='yahoo')
closePrice <- Cl(getSymbols(company, from = fromDate ,auto.assign=FALSE))
names(closePrice)[1] <- "Close"

company.EMA.10 <- EMA(closePrice$Close, n=10)
company.EMA.50 <- EMA(closePrice$Close, n=50)
company.EMA.200 <- EMA(closePrice$Close, n=200)

#Reverse signal
Fast.Diff <- company.EMA.10 - company.EMA.50
Slow.Diff <- company.EMA.50 - company.EMA.200
# look for long entries
Long_Trades <- ifelse(
  Slow.Diff > 0 &
    shift(v=as.numeric(Slow.Diff), places=1, dir="right") > 0,
  closePrice$Close, NA)
# look for long exits (same thing but inverse signts)
Short_Trades <- ifelse(
  Slow.Diff < 0 &
    Fast.Diff < 0 &
    shift(v=as.numeric(Fast.Diff), places=1, dir="right") > 0,
  closePrice$Close, NA)

