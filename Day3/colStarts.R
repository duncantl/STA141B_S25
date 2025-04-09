######

computeColStarts =
function(x)
{
    v = strsplit(x, "")[[1]]
    w = v %in% LETTERS
    i = which(w)
    w = which(chars %in% letters)
    st = chars[w - 1] == " "

    sort(c(i, w[st]))
}


