# Example codes
# To query stock by some filter functions, such as open / close / max / min symbols

library(httr)
library(xml2)
library(XML)

url <- "http://www.tse.com.tw/ch/trading/exchange/BWIBBU/BWIBBU_d.php"

fd <- list(
  submit = "Show Prices",
  input_date  = "106/03/13",
  select2 = "ALL",
  order   = "STKNO",
  login_btn = "(unable to decode value)"
)

resp <- POST(url, body=fd, encode="form")
haha <- content(resp, encoding = "big-5")
doc_string <- as.character(haha)

# 1. Parse document of element
# 2. Create matrix that contains 5 columns

getOriginalResult <- function(doc_string) {
  doc <- htmlParse(doc_string,asText=T)
  id_or_class_xp <- "//div[@id='tbl-containerx']//text()"
  
  #These functions provide a way to find XML nodes that match a particular criterion.
  stockTableResult <- xpathSApply(doc, id_or_class_xp, xmlValue)
  #remove useless description
  stockTableResult <- stockTableResult[-1]
  #remove \n
  stockTableResult <- stockTableResult[ - which(stockTableResult %in% "\n")]
  x <- 6
  result <- c(stockTableResult[x:(x+4)])
  x <- x + 5
  while (x <= length(stockTableResult)) { 
    result <- rbind(result, stockTableResult[x:(x+4)])
    x <- x + 5
  }
  #Chinese
  colnames(result) <- c(stockTableResult[1:5])
  #English
  colnames(result) <- c("code", "stock", "PE", "DividendYield", "PBR")
  return(result)
}

result <- getOriginalResult(doc_string)
df <- data.frame(result)

removeDebtStock <- function(df) {
  return(df[!grepl("-", df$PE),])
}

getQuickReturnStock <- function(df, boundaryValue) {
  #noDebtStock$PE is factors class
  return(df[which(as.numeric(as.character(noDebtStock$PE)) < boundaryValue),])
}

noDebtStock <- removeDebtStock(df)

quickReturnStock <- getQuickReturnStock(noDebtStock, as.numeric(15))

