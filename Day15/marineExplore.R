ty = lapply(InAll, function(var) table(sapply(r, function(x) class(x[[var]]))))
len = lapply(InAll, function(var) table(sapply(r, function(x) if(!is.null(x[[var]])) length(x[[var]]) else NA)))
sapply(len, function(x) length(x) == 1 && names(x) == 1)

# So all character scalars or NULL.


ty = lapply(InSome, function(var) table(sapply(r, function(x) if(var %in% names(x)) class(x[[var]]) else NA)))
# All character
len = lapply(InSome, function(var) table(sapply(r, function(x) if(var %in% names(x)) length(x[[var]]) else NA)))
sapply(len, function(x) length(x) == 1 && names(x) == 1)



# When get data.frame, check the columns

z = mkData(r = r)
numNAs = sapply(z, function(x) sum(is.na(x)))
# Developer the fix() function to convert the columns.
# now check we haven't introduced  any additional NAs
z2 = mkData(r = r)
numNAs2 = sapply(z2, function(x) sum(is.na(x)))
identical(numNAs, numNAs2)


tt = table(z2$TYPE_NAME, z2$SHIPTYPE, useNA = "always")
tt2 = tt[-nrow(tt), -ncol(tt) ]
apply(tt2, 2, function(x) sum(x != 0)) == 1

idx = apply(tt2, 1, function(x) which(x != 0))

structure(rownames(tt2), names = colnames(tt2)[idx])



# Duplicates
# gvessels()  1062 based on SHIP_ID

g = split(va, va$SHIP_ID)
table(sapply(g, nrow))
w = sapply(g, nrow) > 1


#
va = gvessels(k)
library(maps)
map('world')
with(va, points(LON, LAT, pch = ".", cex = 2))


# Can lookup a ship's name and find more details at, e.g.,
#   https://www.vesselfinder.com/vessels/details/9263655






