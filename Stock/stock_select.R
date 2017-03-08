#Example codes

##### Global Variable #####

fromDate = "2016-06-01"

##### Load Quantitative Financial Modelling & Trading Framework #####
library(quantmod)

#2017/03/08 refer to https://woodstar-woodstar.blogspot.tw/2016/04/r.html

#宏遠興業
s1460 = getSymbols('1460.TW', from = fromDate, src="yahoo", auto.assign=FALSE)
chartSeries(s1460, subset='last 3 months')

#宏遠興業-每日殖利率
d1460 = getDividends('1460.TW', from = fromDate,src = "yahoo", auto.assign = FALSE)
