
els2 = strsplit(ll2, "[;=,]")

head(els2)

common = sapply(els2, `[`, c(2, 4, 6, 7, 8, 10))

class(common)
dim(common)

common = t(common)


# Now the variable number of detected devices

rows = lapply(els2, function(x) matrix(x[-(1:10)], , 4, byrow = TRUE))

d = do.call(rbind, rows)


# Now repeat each row in common as many times as there are rows in each element of rows.

idx = rep(1:nrow(common), sapply(rows, nrow))

d2 = as.data.frame(cbind(common[idx, ], d))

names(d2) = c("time", "device", "x", "y", "z", "degree",
              "MAC", "signal", "channel", "type")

num = c("x", "y", "z", "degree", "signal")
d2[num] = lapply(d2[num], as.numeric)

fac = c("device", "MAC", "channel", "type")
d2[fac] = lapply(d2[fac], factor)

d2$time = structure(as.numeric(d2$time)/1000, class = c("POSIXct", "POSIXt"))

summary(d2)
