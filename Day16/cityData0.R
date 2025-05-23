library(RCurl)
library(XML)

u = "https://www.city-data.com/city/California.html"

# What happens when we switch to All Cities in the pull-down menu
# Watch the requests to see if new data being requested.
# Apparently not.
# So let's see what's in the original document

txt = getURLContent(u, verbose = TRUE)

# Failed 400 error.
# Cookie?  User agent?
# Try readLines()
txt = readLines(u)

# So that worked. We can try adding the useragent to the getURLContent().
# We don't need to as we can use readLines(), but just to figure out what works.
userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:138.0) Gecko/20100101 Firefox/138.0"
txt = getURLContent(u, useragent = userAgent, verbose = TRUE)

doc = htmlParse(txt)


lnks = getHTMLLinks(doc)
length(lnks)

head(lnks)
# Too "inclusive". Getting links to states.
# We could determine where these are located in the document
# 

a0 = getNodeSet(doc, "//a[@href]")
head(a0)
xmlParent(a0[[5]])
xmlParent(xmlParent(a0[[5]]))

sapply(xmlAncestors(a0[[5]]), xmlName)

tbl = getNodeSet(a0[[5]], ".//ancestor::table")
xmlAttrs(tbl[[1]])



# Look at the HTML and find the first CA city
# or find it with R

getNodeSet(doc, "//a[contains(@href, 'Acampo')]")

tbl = getNodeSet(doc, "//a[contains(@href, 'Acampo')]//ancestor::table")
length(tbl)
xmlAttrs(tbl[[1]])


a = getNodeSet(doc, "//table[@id = 'cityTAB']//a")
head(a)

h = sapply(a, xmlGetAttr, "href")


# Some are of the form javascript:l
# Some are direct, e.g., Acton-California.html

w = grepl("^javascript:l\\(", h)

# Let's see what the Javascript code maps these to when we click one one.
#  javascript:l(\"Acalanes-Ridge\");
# https://www.city-data.com/city/Acalanes-Ridge-California.html
# javascript:l(\"Acampo\");
# https://www.city-data.com/city/Acampo-California.html

# So let's replace those with their expanded version
tmp = gsub('^javascript:l\\("([^)]+)"\\);$', "\\1", h[w])
# Note I did this iteratively, first not removing the "s
h[w] = paste0(tmp, "-California.html")


# Now these are not URLs, but file names.
#
city.urls = getRelativeURL(h, u)


#
v = getURLContent(city.urls[2])

# Need the useragent
v = getURLContent(city.urls[2], useragent = userAgent, verbose = TRUE)


# But we may want to focus on the larger or smaller cities.


# Could read all the tables and then find the one we want
tbls = readHTMLTable(doc)
sapply(tbls, nrow)

# Or focus on the one we know is what we want.
tbl = getNodeSet(doc, "//table[@id = 'cityTAB']")[[1]]
tb = readHTMLTable(tbl)
tb = tb[, -1]
tb[,2] = as.integer(gsub(",", "", tb[,2]))

# We could convert the columns to the correct types and drop map with
tb2 = readHTMLTable(tbl, colClasses = list(NULL, "character", "FormattedInteger"))


# Now get all the documents
# We can process them later.
# Need a delay between requests.


