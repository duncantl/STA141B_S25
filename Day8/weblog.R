ll = readLines("../Data/eeyore.log")

# Do all line start with IP address - - [

rx = "[0-9.]+ - - \\["
w = grepl(rx, ll)
table(w)

# Let's look at those that don't.

head(ll[!w])


# So we need to allow for a name in the second -

rx = "^[0-9.]+ - (-|[a-z]+) "
w = grepl(rx, ll)
table(w)
ll[!w]

# So we need to allow digits

rx = "^[0-9.]+ - (-|[a-z0-9]+) "
w = grepl(rx, ll)
table(w)


# Now grow the regular expression

rx = "[0-9.]+ - - \\[[0-9]+/Nov/2015:[0-9]{2}:[0-9]{2}:[0-9]{2} -0800\\]"

# This is too specific and too detailed.
# It won't match other months or years.
# It specifies all the details/elements of the date-time, but can we do it more succinctly.


rx = "^[0-9.]+ - (-|[a-z0-9]+) \\[[^]]+\\] "

# Let's add () to each part we match as we will want to refer to the capture groups.

rx = "^([0-9.]+) - (-|[a-z0-9]+) \\[([^]]+)\\] "

#                                   ^^^^^^^
# Why did we escape the [ and ]
# Why not the other [ ]
# Note the [^]]
# Didn't have to escape the first ] since had context. But we could have escaped it.
# 

w = grepl(rx, ll)

# We should check that we are matching the parts correctly.

# Let's figure out how to extract the matched parts in each line.

# 2 ways
# 1. gsub() and glue the pieces together with some bizarre separator that can't occur in the text
#        and the strsplit
# 2. gregexpr(, perl = TRUE)

tmp = gsub(rx, "\\1;;;\\2;;;\\3", ll)
els = strsplit(tmp, ";;;")

table(sapply(els, length))
els[[1]]

# So we are keeping the remainder of each line after the third match.

tmp = gsub(rx, "\\1;;;\\2;;;\\3;;;", ll)
els = strsplit(tmp, ";;;")

table(sapply(els, length))
els[[1]]


# Is the third element a regular date-time
# We could use a regular expression to check its format.
# But let's try to convert it to a date-time as that is what we want.
# If we get NAs, then we have a problem with the format.

tm = sapply(els, `[`, 3)
head(tm)

tm2 = strptime(tm, "%d/%b/%Y:%H:%M:%S")
head(tm2)

# Did strptime() figure out the PST or just use my computer's current setting?
# Or do we need to tell it about the -0800

table(is.na(tm2))

class(tm2)
# What's this POSIXlt, POSIXt ?
# What happens when an object has 2 classes - i.e., a vector 2
# 


# Grow the rx for the next part -
#   the "GET /........ HTTP/1.1"


# Let's check which match GET /...
# or more specifically, which don't match and how we will have to adapt.
w = grepl('"GET /.* HTTP', ll)
ll[!w]

# Only 91 that don't match.
# What are the alternatives?
# If we have information about what to expect, we could build that in.
# Otherwise, discover it.

# Let's find the parts that are after the bit we matched earlier

rx = '^([0-9.]+) - (-|[a-z0-9]+) \\[([^]]+)\\] "([^ ]+ )'
w = grepl(rx, ll)
table(w)

table(gsub(rx, "\\4", ll))

# Need to remove the part after the space
rx = '^([0-9.]+) - (-|[a-z0-9]+) \\[([^]]+)\\] "([^ ]+ ).*'
w = grepl(rx, ll)
table(w)

table(gsub(rx, "\\4", ll))

# Nobody expected the HBESPY or WFZWXO !

# So we can list these different elements/terms
# or perhaps all capitals.


#
rx = '^([0-9.]+) - (-|[a-z0-9]+) \\[([^]]+)\\] "([^ ]+ ).*'
table(gsub(rx, "\\4", ll))




# FINAL

# This doesn't get the browser part as we can only reference capture groups 1 to 9 
#       IP       -   login          date-time    HTTP OP  path          version    status   size       referer   browser
rx = '^([0-9.]+) - (-|[a-z0-9]+) \\[([^]]+)\\] "([A-Z]+) ([^ ]+) HTTP/(1\\.[01])" ([0-9]+) (-|[0-9]+) "([^"]*)" "([^"]*)"'


rx.sub = "\\1;;;\\2;;;\\3;;;\\4;;;\\5;;;\\6;;;\\7;;;\\8;;;\\9"
tmp = gsub(rx, rx.sub, ll)
tmp2 = strsplit(tmp, ";;;")
table(sapply(tmp2, length))
i = which(sapply(tmp2, length) == 8)
tmp[(i-1):(i+1)]

ll[(i-1):(i+1)]

# Doesn't have a value in the referer.
# So it is the last element of the line.
#
# 2 approaches.
#  Add an NA for that element
#  Include the "" in the match for referrer so there is some content, and then remove those later.

# Approach 1
tmp2[i] = lapply(tmp2[i], c, NA)

# Approach 2.
rx = '^([0-9.]+) - (-|[a-z0-9]+) \\[([^]]+)\\] "([A-Z]+) ([^ ]+) HTTP/(1\\.[01])" ([0-9]+) (-|[0-9]+) ("[^"]*") ("[^"]*")'
tmp = gsub(rx, rx.sub, ll)
tmp2 = strsplit(tmp, ";;;")
table(sapply(tmp2, length))

#Now stack
df = do.call(rbind, tmp2)

tmp3 = gsub('(^"|"$)', '', df[,9])
table(grepl('^"', tmp3))



# BTW, easier way to create the substitute string.
rx.sub = paste(paste0("\\", 1:9), collapse = ";;;")


# How to get all 10 capture groups from each match.
# (?P<name>pattern)


m = gregexpr(rx, ll, perl = TRUE)


m[[1]]
nchar(ll[1])
# So matched entire string.

# Look at the attributes named capture.start and capture.length

s = attr(m[[1]], "capture.start")
l = attr(m[[1]], "capture.length")

substring(ll[1], s, s+l)






#



df = getCaptures(rx, ll, row.names = NULL)


names(df) = c("IP", "login", "datetime", "operation", "path", "HTTPVersion", "status", "bytes", "referrer", "useragent")

# Check the bytes are all digits
w2 = grepl("^[0-9]+$", df$bytes)
table(w2)

table(df$bytes[!w2])

table(df$status, w2)
# So 239 with status 200 but - as the number of bytes.
# Investigate.

df$bytes = as.integer(df$bytes)


tmp = as.POSIXct(strptime(df$datetime, "%d/%b/%Y:%H:%M:%S"))
table(is.na(tmp))
head(tmp)
df$datetime = tmp


table(df$status)




