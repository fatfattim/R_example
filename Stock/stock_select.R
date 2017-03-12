# Example codes
# To get close price of some company, and then calculate field divide.
# and finally, you can refer to output object, to determine what is purchase price

##### Load Quantitative Financial Modelling & Trading Framework #####
library(quantmod)
##### Global Variable #####
fromDate <- "2016-12-01"
stockSrc <- "yahoo"
company <- "1460.TW"

appendDivideField <- function(company, stockSrc, fromDate) {
  # Get dividend Yield
  dividends = getDividends(company, from = "2015-01-01",src = stockSrc, auto.assign = FALSE)
  names(dividends)[1] <- "Dividend"
  averageDivide = mean(as.vector(dividends$Dividend))
  # Get Close Price
  closePrice <- Cl(getSymbols(company, from = fromDate ,auto.assign=FALSE))
  names(closePrice)[1] <- "Close"
  output <- cbind(closePrice, c(coredata(averageDivide)) / closePrice)
  names(output)[2]<-"Dividend"
  return(output)
}

getPrices <- function(company, stockSrc, fromDate) {
  # Get Close Price
  closePrice <- Cl(getSymbols(company, from = fromDate ,auto.assign=FALSE))
  names(closePrice)[1] <- "Close"
  averageclosePrice = mean(as.vector(closePrice$Close))
  standardDeviation <- sd(as.vector(closePrice$Close))
  ReasonablePrice <- averageclosePrice - standardDeviation
  SellingPrice <- averageclosePrice + standardDeviation
  output<-list(ReasonablePrice = averageclosePrice - standardDeviation, SellingPrice = averageclosePrice + standardDeviation)
  return(output)
}

outputDivide <- appendDivideField(company, stockSrc, fromDate)
outputPrice <- getPrices(company, stockSrc, fromDate)