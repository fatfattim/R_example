# Example codes
# To get close price of some company, and then calculate field divide.
# and finally, you can refer to output object, to determine what is purchase price

##### Load Quantitative Financial Modelling & Trading Framework #####
library(quantmod)
##### Global Variable #####
fromDate <- "2016-12-01"
stockSrc <- "yahoo"
company <- "1460.TW"

# Get Close Price
s1460 = Cl(getSymbols(company, from = fromDate, src = stockSrc, auto.assign=FALSE))
# Get dividend Yield
dividends = getDividends(company, from = "2015-01-01",src = stockSrc, auto.assign = FALSE)
names(dividends)[1] <- "Dividend"
averageDivide = as.vector(dividends$Dividend)
closePrice <- Cl(getSymbols(company, from = fromDate ,auto.assign=FALSE))
output <- cbind(closePrice, c(coredata(mean(averageDivide))) / closePrice)
names(z)[2]<-"Dividend"

chartSeries(output, subset='last 3 months')
