ll = readLines("../Data/eeyore.log")
# We could try to split by space

# While we will be able to make this work in this specific case,
# it is very fragile, i.e., not robust.
# Imagine the useragent field was not the last one but before any of the others.
# Then we would not know which elements were from useragent and which were from
# the next variable.


els = strsplit(ll, " ")
table(sapply(els, length))

# If we are very lucky, we can piece the elements back together
# Let's look at the first element.
els[[1]]

# We glue the date-time and the -0800] back together
# Are these always the 4th and 5th elements
all(sapply(els, `[`, 5)  == "-0800]")
all(grepl("/2015:", sapply(els, `[`, 4)))

# Seems to be what we want.

pos = c(IP = 1, login = 3, datetime = 4, operation = 6, path = 7,
        HTTPVersion = 8, status = 9, bytes = 10, referrer = 11)
cols = lapply(pos, function(i) sapply(els, `[`, i))

df2 = as.data.frame(cols)
names(df2)

df2$datetime = paste(df2$datetime, sapply(els, `[`, 5))

useragent = sapply(els, function(x) paste(x[-(1:11)], collapse = " "))
# Examine and make certain it is what we expect.

df2$useragent = useragent


# Now need to clean up the variables.
# Remove
# [ and ]
# " at the start and end of some strings
# HTTP/
# And convert the datetime to a POSIXct
#



df2$datetime = gsub("^\\[|\\]$", "", df2$datetime)
tmpd = df2$datetime
df2$datetime = as.POSIXct(strptime(df2$datetime, "%d/%b/%Y:%H:%M:%S"))

tmp = gsub("^HTTP/", "", df2$HTTPVersion)
tmp = gsub('"$', "", tmp)
df2$HTTPVersion = as.numeric(tmp)


quote = c("operation", "referrer", "useragent")
df2[quote] = lapply(df2[quote], function(x) gsub('(^"|"$)', '', x))

int = c('status', 'bytes')
df2[int] = lapply(df2[int], as.integer)

