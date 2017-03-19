# Example codes
# To get close price of some company, and then calculate field divide.
# and finally, you can refer to output object, to determine what is purchase price

##### Load Quantitative Financial Modelling & Trading Framework #####
library(quantmod)
##### Global Variable #####
stockSrc <- "yahoo"
company <- "1460.TW"

getPrices <- function(company, stockSrc, closePrice) {
  # Get Close Price
  names(closePrice)[1] <- "Close"
  averageclosePrice = mean(as.vector(closePrice$Close))
  standardDeviation <- sd(as.vector(closePrice$Close))
  ReasonablePrice <- averageclosePrice - standardDeviation
  SellingPrice <- averageclosePrice + standardDeviation
  output<-list(ReasonablePrice = averageclosePrice - standardDeviation, SellingPrice = averageclosePrice + standardDeviation)
  return(output)
}

# take profit and cutting loss, return a list that contains Sum and Items
getResult <- function(closePrice, profit, loss, purchasedItems) {
  resultSum <- 0
  
  profitIndex <- which((closePrice - purchasedItems) / purchasedItems > profit)

  if(length(profitIndex) > 0) {
     resultSum <- resultSum + sum(closePrice - purchasedItems[profitIndex])
     purchasedItems <- purchasedItems[-profitIndex]
  }
  
  lossIndex <- which((closePrice - purchasedItems) / purchasedItems < loss)
  if(length(lossIndex) > 0) {
    resultSum <- resultSum + sum(closePrice - purchasedItems[lossIndex])
    purchasedItems <- purchasedItems[-lossIndex]
  }
  
  output<-list(Sum = resultSum, Items = purchasedItems)
  return(output)
}

# Backtesting 30 days
# TODO need to get trade day, not everyday
backTesting <- function(profit, loss) {
  days <- 10
  duration <- seq(Sys.Date() - days, length = days, by = "1 days")
  purchasedItems <- vector(mode="numeric", length=0)
  result <- 0
  for ( i in seq_along(duration) ) {
    fromDate <- seq(duration[i] - days, length = 1, by = "1 days")
    closePrice <- Cl(getSymbols(company, from = fromDate , to = duration[i], auto.assign=FALSE))
    names(closePrice)[1] <- "Close"
    outputPrice <- getPrices(company, stockSrc, closePrice)
    reasonablePrice <- outputPrice[1]
    #outputPrice[1] is Reasonable price
    x <- as.vector(closePrice$Close)
    priceOfToday <- x[length(x)]
    if(priceOfToday < reasonablePrice) {
      print(duration[i])
      print(paste("close price", priceOfToday))
      print(reasonablePrice)
      purchasedItems[length(purchasedItems) + 1] <- priceOfToday
    }
    
    # take profit and cutting loss
    filterResult <- getResult(priceOfToday, profit, loss, purchasedItems)
    
    result <- result + filterResult$Sum
    purchasedItems <- filterResult$Items
  }
  
  return(result)
}

x <- vector(mode="numeric", length=0)


x[1] <- 10
x[2] <- 20
x[3] <- 30
hah <- getResult(10, 0.4, -0.2, x)
hah$Sum

y <- backTesting(0.01, -0.03)



