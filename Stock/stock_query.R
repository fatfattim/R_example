# Example codes
# To query stock by some filter functions, such as open / close / max / min symbols

library(httr)
library(xml2)
library(XML)

url <- "http://www.tse.com.tw/ch/trading/exchange/BWIBBU/BWIBBU_d.php"

fd <- list(
  submit = "Show Prices",
  input_date  = "106/03/10",
  select2 = "ALL",
  order   = "STKNO",
  login_btn = "(unable to decode value)"
)

resp<-POST(url, body=fd, encode="form")
haha <- content(resp,  encoding = "big-5")
doc_string <- as.character(haha)
doc <- htmlParse(doc_string,asText=T)
id_or_class_xp <- "//select[@id='support-links']//text()"
xpathSApply( doc,id_or_class_xp,xmlValue)
