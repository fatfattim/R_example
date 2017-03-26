
#Course 2
plot(c(1,2,3,4), c(5,6,7,8))

##### Load Quantitative Financial Modelling & Trading Framework #####
library(quantmod)
##### Global Variable #####
fromDate <- "2017-01-01"
stockSrc <- "yahoo"
company <- "1464.TW"

##### Chapter 2 : Downloading Stock #####
stock <- getSymbols(company, from = fromDate, src = stockSrc, auto.assign=FALSE)
summary(stock)
class(stock)

basket_symbols <- c('1464.TW', '1460.TW')
getSymbols(basket_symbols, from = fromDate, src = stockSrc)
summary(`1460.TW`)

#Merge basket symbols to new xts & zoo object
basket <- data.frame(as.xts(merge(`1460.TW`, `1464.TW`)))

##### Chapter 3 : Creating great charts with quantmod #####
getSymbols(company, from = fromDate, src = stockSrc)
plot(`1464.TW`)
lineChart(`1460.TW`, line.type = 'h', theme = 'white')
barChart(`1464.TW`, bar.type = 'hlc', TA = NULL)
candleChart(`1464.TW`, bar.type = 'hlc', TA = NULL)
candleChart(`1464.TW`, bar.type = 'hlc', TA = NULL, subset = '2017-02')
candleChart(`1464.TW`, bar.type = 'hlc', TA = NULL, subset = '2017-02::2017-03')
candleChart(`1464.TW`, theme = chartTheme('white', up.col='red', dn.col='green'), TA = NULL, subset = '2017-02::2017-03')
chartSeries(`1464.TW`, type = c("matchsticks"), TA = NULL, subset = '2017-02::2017-03')

