u = "https://www.city-data.com/city/Davis-California.html"
doc = htmlParse(readLines(u))
sapply(sec, xmlGetAttr, "id")


sec = getNodeSet(doc, "//section[@id and .//table]")
sapply(sec, xmlGetAttr, "id")
sec[[2]]

readHTMLTable(sec[[2]], which = 1)


sec2 = getNodeSet(doc, "//section[@id and not(.//table)]")
sapply(sec2, xmlGetAttr, "id")

#######

d = lapply(sec, readHTMLTable, which = 1)



