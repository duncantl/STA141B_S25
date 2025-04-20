readNCBITables =
    # top-level function that reads all the Query #.. tables in a file
    # Uses the start and end row number.
function(file)
{
    ll = readLines(file)
    # This is the equivalent of getTables() but just done directly here
    # rather than as a separate function. See ncbiFunctions2.R for another approach.
    starts = which(substring(ll, 1, 7) == "Query #")
    ends = which(substring(ll, 1, nchar("Alignments:")) == "Alignments:")    
    mapply(readTableBetween, starts, ends, MoreArgs = list(ll), SIMPLIFY = FALSE)
    # NOT THIS    mapply(readTableBetween, starts, ends,   ll, SIMPLIFY = FALSE)
    #  This will make starts and ends as long as ll and then have as many calls as there are elements
    # in ll and we'll have
    #   readTableBetween(starts[i], ends[i], ll[i])
    # Very, very different as the start and end values won't make any sense as the value for lines
    # will be a single string, i.e., a character vector of length.
}

readTableBetween =
    #
    # This must return a data.frame.
    #
function(startIndex, endIndex, lines, colStarts = ColStarts)
{
     # Start 3 lines down
    tt =  lines[ (startIndex + 3): (endIndex - 1) ]
    tt = tt[ tt != "" ]

    # I had the computation of widths and mkHeader() in this function
    # but moved it to readTableData so we could do it all there and
    # reuse for the cumsum() approach in ncbiFunctions2.R
    
    readTableData(tt, colStarts = colStarts) 
}


# For now "hard-code" the index/position of the start of each column.
# Need to check if they are the same for each table and then in each table in
# other query results.
# We'll see on Tuesday  4/8 how to compute the column positions.

ColStarts = c(1, 67, 83, 99, 110, 117, 123, 129, 135, 142, 153)

readTableData = 
function(tt, colStarts = ColStarts, widths = c(diff(colStarts), nchar(tt[1])))
{
    # First read the values in the table, and ignore the header/column nams.
    # omit the 2 header lines
    dataLines = tt[-(1:2)]
    # pass a textConnection() to read.fwf since we are n asking
    # it to read a file but to process the contents we have alread read.
    con = textConnection(dataLines)
    ans = read.fwf(con, widths)

    # Now process the column names.
    h = mkHeader(tt, widths)
    names(ans) = trimws(as.character(h))

    # I had invisible() so it wouldn't print.
    ans
}


mkHeader =
function(txt, widths)    
{
    # For now, just use the second row. We'll talk about how to use
    # both rows to get, e.g., Scientific Name on Tuesday 4/8
    read.fwf(textConnection(txt[2]), widths = widths)
}


