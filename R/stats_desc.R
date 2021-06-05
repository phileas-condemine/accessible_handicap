library(data.table)

handicap = fread("data/data-es.csv",encoding = "UTF-8")


nm = names(handicap)

grep("access",nm,value=T,ignore.case = T)
grep("handicap",nm,value=T,ignore.case = T)
