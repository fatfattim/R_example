# Example codes
# To get close price of some company, and then calculate field divide.
# and finally, you can refer to output object, to determine what is purchase price

##### Load Quantitative Financial Modelling & Trading Framework #####
library(quantmod)
##### Global Variable #####
fromDate <- "2016-12-01"
stockSrc <- "yahoo"
company <- "2498.TW"

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

getVolume <- function(company, stockSrc, fromDate) {
  closePrice <- getSymbols(company, from = fromDate ,auto.assign=FALSE)
  #keep close and volume
  closePrice <- closePrice[,(4:5)]
  names(closePrice)[1] <- "Close"
  names(closePrice)[2] <- "Volume"
  #remove volume == 0
  closePrice <- closePrice[which(closePrice$Volume > 0),]
  
  #append percent data
  colClose <- closePrice[, "Close", drop = FALSE]
  n <- nrow(closePrice)
  colClose <- as.vector(colClose[1:n, 1])
  sbux_ret <- ((colClose[2:n] - colClose[1:(n-1)]) / colClose[1:(n-1)])

  #remove first item since not have previous data
  closePrice <- closePrice[-1]
  closePrice <- cbind(closePrice, c(coredata(sbux_ret[1:n - 1])))
  names(output)[3] <- "Percent"
  return(closePrice)
}

outputDivide <- appendDivideField(company, stockSrc, fromDate)
outputPrice <- getPrices(company, stockSrc, fromDate)
outputVolume <- getVolume(company, stockSrc, fromDate)
