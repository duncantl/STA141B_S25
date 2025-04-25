# Read the lines.
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


# Instead of this 2 step process, we could have extracted the value after the first - and before the next space
# and then see what they look like to create a pattern
rx2 = "^[0-9.]+ - ([^ ]+) .*"
table(gsub(rx2, "\\1", ll))

# Note rx2 carefully. It shows 2 things
# The part (without ())   '[^ ]+ ' is
#   match one or more characters which are not a space and then a space.
# This is a common pattern that is much better than '.+ ' which is to match one or more characters and then a space.
# That allows for matching the 'abc def' in 'abc def ' because of the second space.
# But we wanted to stop at the first occurrence of a space.  Hence the '[^ ]+ '



# Now grow the regular expression

rx = "[0-9.]+ - - \\[[0-9]+/Nov/2015:[0-9]{2}:[0-9]{2}:[0-9]{2} -0800\\]"

# This is too specific and too detailed.
# It won't match other months or years.
# It specifies all the details/elements of the date-time, but can we do it more succinctly.


rx = "^[0-9.]+ - (-|[a-z0-9]+) \\[[^]]+\\] "

# What is this doing.
# \\[  to match a literal [ since [ would ordinarily be the start of a character set.
#  Same for the ending \\]
# The bit in between is [^]]+ and this is like the [^ ]+ which is match one or more
# characters that are not ] and then we add the \\] so we stop at the first occurrence
# of ]

# Why didn't we have to escape the ] in [^]] ?
# Didn't have to escape the first ] since it the regular expression recognizes
# the [^ must have a character asn [^] to end the character set would mean nothing - everything except nothing.
# But we could have escaped it.

# Let's add () to each part we match as we will want to refer to the capture groups.

rx = "^([0-9.]+) - (-|[a-z0-9]+) \\[([^]]+)\\] "
#                                   ^^^^^^^

# Check we still match
w = grepl(rx, ll)

# We should check that we are matching the parts correctly, not just matching overall.

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
# This is because we are only replacing the bits that matched and leaving the rest.
# So we can separate the remainder by adding ;;; after the 3rd capture group and so before
# the remaining part we didn't explicit match.

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
class(tm2)
head(tm2)

# Did strptime() figure out the PST or just use my computer's current setting?
# Or do we need to tell it about the -0800
table(is.na(tm2))

# What's this POSIXlt, POSIXt ?
# What happens when an object has 2 classes - i.e., a vector 2
 

# Grow the rx for the next part -
#   the "GET /........ HTTP/1.1"


# Let's check which match GET /...
# or more specifically, which don't match and how we will have to adapt.
w = grepl('"GET /.* HTTP', ll)
ll[!w]

# Only 91 that don't match.
# What are the alternatives?
# If we have information about what to expect, we could build that in.
# Otherwise, discover it from the data.

# Let's find the parts that are after the bit we matched earlier

rx = '^([0-9.]+) - (-|[a-z0-9]+) \\[([^]]+)\\] "([^ ]+ )'
w = grepl(rx, ll)
table(w)

table(gsub(rx, "\\4", ll))

# Need to remove the part after the space
rx = '^([0-9.]+) - (-|[a-z0-9]+) \\[([^]]+)\\] "([^ ]+ ).*'
w = grepl(rx, ll)
table(w)

# Now get just the 4th capture group
table(gsub(rx, "\\4", ll))

# Nobody expected the HBESPY or WFZWXO !

# So we can list these different elements/terms
# or perhaps all capitals.


# Many iterations to get the next parts.


# FINAL rx

# This doesn't get the browser part as we can only reference capture groups 1 to 9 
#       IP       -   login          date-time    HTTP OP  path          version    status   size       referer   browser
rx = '^([0-9.]+) - (-|[a-z0-9]+) \\[([^]]+)\\] "([A-Z]+) ([^ ]+) HTTP/(1\\.[01])" ([0-9]+) (-|[0-9]+) "([^"]*)" "([^"]*)"'

# Create the substitute string to include each of the capture groups and separated by some
# string that does not occur in any of the text. Then we can use that to strsplit()

# We'll use ;;; but we can check this never occurs.
stopifnot(!any(grepl(";;;", ll)))


rx.sub = "\\1;;;\\2;;;\\3;;;\\4;;;\\5;;;\\6;;;\\7;;;\\8;;;\\9"
# BTW, easier way to create the substitute string than type it ourselves.
rx.sub = paste(paste0("\\", 1:9), collapse = ";;;")


tmp = gsub(rx, rx.sub, ll)
tmp2 = strsplit(tmp, ";;;")
table(sapply(tmp2, length))
# There is one that has 8 elements, and all the rest 9.

# Look at this line and the ones before and after it.
i = which(sapply(tmp2, length) == 8)
ll[(i-1):(i+1)]
# And the separated elements.
tmp[(i-1):(i+1)]

# So this doesn't have a value in the referer.
# So it is the last element of our substitute line.
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
df = as.data.frame( do.call(rbind, tmp2) )
names(df) = c("IP", "login", "datetime", "operation", "path", "HTTPVersion", "status", "bytes", "referrer")


# If we used approach 2, we'd have to remove the " at the start and end of the 9th element.
any(grepl('^"', df[,9]))
tmp = gsub('(^"|"$)', "", df[,9])
any(grepl('^"', tmp))
df[,9] = tmp



# We couldn't include the 10th capture group for the useragent/browser because \\10 would be
# read as \\1 followed by a 0.
# There are named capture groups.
# But we will simply change rx to remove, for example, the 1st () group (for the IP address) and
# then the useragent group will be number 9.

rx = '^[0-9.]+ - (-|[a-z0-9]+) \\[([^]]+)\\] "([A-Z]+) ([^ ]+) HTTP/(1\\.[01])" ([0-9]+) (-|[0-9]+) ("[^"]*") "([^"]*)"'
# Compare this with the previous version.
tmp = gsub(rx, "\\9", ll)
head(tmp)
length(unique(tmp))

df$useragent = tmp


# Now we can convert/transform some of the comments.


# We'll check if the status and bytes can be considered integer values.
isInteger =
function(x)
   grepl("^[0-9]+$", x)

sapply(df[c("status", "bytes")], function(x) all(isInteger(x)))

# all true for status, but not bytes

table(df$bytes[ !isInteger(df$bytes) ])

# All -  so we can convert all of them via as.integer() and will get NAs for the -

int = c("status", "bytes")
df[int] = lapply(df[int], as.integer)

# The warnings of NAs introduced are okay.

# Now convert the datetime as we did above.
tmp = as.POSIXct(strptime(df$datetime, "%d/%b/%Y:%H:%M:%S"))
table(is.na(tmp))
head(tmp)
df$datetime = tmp






