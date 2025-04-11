
# Loops and Trying to Use Vectorized Operations

`for()` loops fine and they are a natural way to think of writing code.
However, they can make code more complicated.


Consider the ncbiFunctions.R file and the function

```
readNCBITables =
    # top-level function that reads all the Query #.. tables in a file
    # Uses the start and end row number.
function(file)
{
    ll = readLines(file)
    starts = which(substring(ll, 1, 7) == "Query #")
    ends = which(substring(ll, 1, nchar("Alignments:")) == "Alignments:")    
    mapply(readTableBetween, starts, ends, MoreArgs = list(ll), SIMPLIFY = FALSE)
}
```

We didn't loop to find `starts` or `ends`. We used vector operations to 
+ get the first 7 and 11 characters of each line
+ compare to our target strings


We did loop over the elements of starts and ends but used `mapply()` to do this.
Using a loop, we would have
```
ans = list()
for(i in seq(along.with = starts))
  ans[[i]] = readTableBetween(starts[i], ends[i], ll)
```
This is 3 lines of code rather than 0.
It is a lot more function calls we have to write
 
+ for()
+ seq()
+ `[` twice
+ assigning to `ans[[i]]` 
+ creating the variable `ans`


## Concatenating/Appending.
Some people will write
```
ans = c(ans, readTableBetween(starts[i], ends[i], ll))
```

There are 2 issues with this
+ If we run the `for()` loop code again,  we have to remember to reinitialize `ans` or else
   we are just adding to it.
+ While it looks simple to concatenate the new value to the end of `ans`,
  when `ans` gets large, this can be very slow.
  + Suppose we 999,999 elements in `ans` and we append one more.
    R has to allocate a new vector of length 1 million, copy all 999,999 values
	 to that new vector, then insert the new element and then clean up the origina
	 version of `ans`.
  + We are much better pre-allocating the vector/list with the correct number
   of items and inserting each result into the existing place.


The original code 
```
   ans[[i]] = readTableBetween(starts[i], ends[i], ll)
```
is still doing this concatenation, but again, it is not explicit.
Consider `i = 2. We are inserting a value into the 2nd element of `ans`.
It doesn't exist. So R has to create a new list with length 2 and copy the 
values from the previous version to that  and then insert the new object into 
the 2nd element.


The better approach  is
```
ans = vector("list", length(starts))
for(i in seq(along.with = starts))
  ans[[i]] = readTableBetween(starts[i], ends[i], ll)
```
Here, `ans` has as many elements as we need and we are inserting
each result from `readTableBetween()` into the existing element.
R doesn't have to change the length of `ans` after it is created.




##

I saw some people working on the `* day month` lines in the climate files
and writing a loop something like

```
block_starts = grep("\\*", ll)

header = c()
for(i in seq(along.with(block_starts)))
{
	  header[i] = ll[ block_starts[i] ]
	  parsed_header = strsplit(header[i], " +") # a regular expression - one or more spaces
	  day = parsed_header[3]
	  month = parsed_header[5]
}
```

There are a few problems with this and partially because the code is getting complicated.


My approach is
```
all.els = strsplit(ll[block_starts], " +")
dm = sapply(all.els, function(x) as.integer(x[c(3, 5)]))
dm = as.data.frame( t(dm) )
```


The key is to think about how we can work on all the elements of a vector in the same call.


