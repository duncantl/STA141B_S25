# A different way to get the tables using cumsum()
# I prefer this approach.
# And then we reuse several of the functions in ncbiFunctions.R
getBlocks =
function(ll)
{
    w = substring(ll, 1, 7) == "Query #" | substring(ll, 1, 11) == "Alignments:"
    g = cumsum(w)
    ans = split(ll, g)
    names(ans) = sapply(ans, `[`, 1)
    ans
}

getTables =
    # this calls getBlocks() and gets the resulting elements
    # whose names start with "Query #"
function(ll)
{
    b = getBlocks(ll)
    w = substring(names(b), 1, 7) == "Query #"
    b[w]
}


readNCBITables2 =
    # Top-level/starting function
function(file, colStarts = ColStarts)
{
    ll = readLines(file)
    tbls = getTables(ll)
    ans = lapply(tbls, readTableData2, colStarts)
}

readTableData2 =
function(txt, colStarts = ColStarts)
{
    txt = txt[ txt !=  "" ]
    # having removed the blank line between Query...  and Sequences...
    # only 2 remaining before the actual table content.
    readTableData(txt[-(1:2)], colStarts = colStarts)
}
