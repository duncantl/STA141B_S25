library(XML)

doc = htmlParse(readLines("https://greenercars.org/greenercars-ratings/"))
tbl =  readHTMLTable(doc, which = 1)
v = c("Green Score", "Weight")
tbl[v] = lapply(tbl[v], as.numeric)
hy = tbl$Hybrid = grepl("/", tbl$City)

tbl0 = tbl

v = c("CityMPG", "CityMPKW", "HiwyMPG", "HiwyMPKW")
v0 = c("City*", "Hiwy*")
# 2 columns on right, 4 on left being assigned, recycling rule repeats the 2 columns on the right, in the correct order - 1, 2, 1, 2
# tbl[v] = lapply(tbl0[, v0], as.numeric)
# But not correctly! That lead to mismatches.
tbl[v] = lapply(tbl0[, rep(v0, each = 2)], as.numeric)

# Had this as Electric and was not getting the same answers. Very frustrating.
w = tbl$FuelType == "Electricity" 
tbl[w & !hy, v[c(1, 3) ]] = NA
tbl[!w & !hy, v[c(1, 3) + 1] ] = NA

tmp3 = do.call(cbind, lapply(tbl[hy, v0], function(x) do.call(rbind, strsplit(x, " / "))))
mode(tmp3) = "numeric"
tbl[hy, v[c(2, 1, 4, 3)] ]= tmp3

#################

if(FALSE) {
    f = c("greencars.R", "greencars2.R")
    ff = file.path("~/Classes/Davis/STA141B_24_25/", f)
    tbls = lapply(ff, function(f) {e = new.env(); source(f, e); e$tbl})
#    names(tbls) = f
    sapply(tbls, dim)
    do.call(identical, tbls)
    do.call(all.equal, tbls)


    # [1] "Component “CityMPKW”: Mean relative difference: 0.114971" "Component “HiwyMPG”: Mean relative difference: 0.2334601"
    # So compare those two
    # Debugging
    z = cbind(tbls[[1]]$CityMPKW, tbls[[2]]$CityMPKW)
    table(z[,1] == z[,2], useNA = "always")
    all(is.na(z[,1]) == is.na(z[,2]))
    w = is.na(z[,1])
    z[!w,]
    
#      [,1] [,2]
# [1,] 4.26 4.26
# [2,] 3.80 3.80
# [3,] 4.11 3.36
# [4,] 3.52 2.98
# [5,] 3.46 2.88
# [6,] 3.65 2.93    
}
