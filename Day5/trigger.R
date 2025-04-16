source("clmFuns2_bug.R")
clm.files = list.files("../../Assignments/Solar/Files", pattern = ".clm$", full = TRUE)

read.clm2(clm.files[1])

#Error in FUN(X[[i]], ...) : object 'll' not found




#
source("clmFuns2_bug2.R")
o = read.clm2(clm.files[1])

# No error.  But wrong answer.
# How do we know?

# We do have warnings

warnings()
# In getDayMonth(txt[1])


# how many warnings - 50
# May want to change nwarnings options
#
options(nwarnings = 1e7)
o = read.clm2(clm.files[1])

# Why 108 warnings

table(is.na(o$day))
table(is.na(o$month))


table(is.na(o$month), is.na(o$day))



# What if we turn warnings into error?
options(warn = 2)
o = read.clm2(clm.files[1])

