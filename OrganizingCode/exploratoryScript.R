f = "alert.full.maccdc2012_00000.pcap"
ll = readLines(f)
al = split(ll, cumsum(ll == ""))



#
# Exploring

l1 = sapply(al, `[`, 1)
w = grepl("", l1)
all(w)


# How to get the snortId
