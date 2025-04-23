ll = readLines("../Data/offline")
ll2 = grep("^#", ll, value = TRUE, invert = TRUE)

length(ll2)
head(ll2)


els = strsplit(ll2, ";")

head(els)

time = gsub("^t=", "", sapply(els, function(x) x[1]))

class(time)
length(time)

time = as.integer(time)
# warnings about NAs
table(is.na(time))

# Make numeric


time = gsub("^t=", "", sapply(els, function(x) x[1]))
time = as.numeric(time)

# Make these values in POSIXct times. Check with the first 6
structure(head(time)/1000, class = c("POSIXct", "POSIXt"))

# Now all of them.
time = structure(time/1000, class = c("POSIXct", "POSIXt"))


# We can do the same thing for id, degree and also pos
# for pos

pos = strsplit(gsub("^pos=", "", sapply(els, function(x) x[3])), ",")
pos = lapply(pos, as.numeric)
pos2 = do.call(rbind, pos)

ans = data.frame(time = time)
ans[ , c("x", "y", "z") ] = pos2


class(ans)
dim(ans)
names(ans)
sapply(ans, class)

summary(ans)


# The variable number of detected devices on each line.

# omit the first 4 elements
#
els.var = lapply(els, function(x) x[-(1:4)])
head(els.var)


# What do we do next?
# Can get the MAC address
# Then the signal, then channel, then type.
# How strsplit and sapply(x, `[`, 1)
# 
# 
lapply(els.var, )

