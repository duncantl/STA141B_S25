# NCBI

+ Goal is to read NCBI results with 2 fixed-width format files.

+ Trying to write functions that will do this for any NCBI result file.
   + Not just the one we are exploring

+ What is the strategy for reading both tables from the file.
   + Enumerate the steps, i.e., make a plan.
     + See if steps are likely to lead to a result. 
     + What steps seem hard or may not work?
	    + Can we think of alternatives.
   + map each step to the name of a function we will create.

<!-- + See Basics.md and README.md -->


+ Can't use `read.fwf(, skip = numLines)`
    + only skips the start, but doesn't know where to stop so would keep reading into the 
	  `Alignments:` section and even into the next table and then its `Alignments:` section, 
	  i.e., all the way to the end of the file.


## Steps

+ Want a function to read both - actually all  - tables
   + function - `readNCBITables()`
   + user provides the file name
   + can have a default which is our test data.

+ What does it do?

+ read the contents of the file
   + readLines() - already exists

+ Get the sequence/block of lines for each of the rectangular (FWF) tables
   + a list with n character vectors, 1 for each table.
   + `getTables()`
   + for ncbiFunctions.R approach didn't actually implement this since it is 2 lines of code.
     + For ncbiFunctions2.R - did implement as `getTables()` and `getBlocks()` and the latter uses
	   `cumsum()`.
   
+ process each table 
   + Implemented as `readTableBetween()` and `readTableData()`
      + first just subsets the lines.
   + get the values into a data.frame
   + convert any columns, e.g., the 100% to numeric vector.
   + compute the column names - `mkHeader()`
   
+ read the data values of a table
   + read.fwf ?
   + not in a file.
   + need the column widths or starting positions
     + This is a separate step
	 + Is there any way we can "punt" on this and keep making progress, and return to make it general later??

+ construct the column names and set these names on the data.frame

+ Transform any column that does not have the appropriate type.


+ So for now, implement
   + `readNCBITables()`
   + `getTables()`
   + `mkHeader()`



# Validating the results after we read the data

+ Validate the results
  + Check length of results - 2
  + Class of result - list
  + Class of elements - `sapply(z, class)`
  + Dimensions, since data.frame elements
     + `sapply(z, dim)`  
  + Class of each column of the first element
    + `sapply(z[[1]], class)`
    + Make sense?
	+ Query cover is a character vector, not numbers.
	  + Actually contains spaces at end. 
	  + How did we determine this?
	     + `z[[1]]`
	  + Need to clean and convert to number.
	     + `as.numeric(substring(trimws(z[[1]]$"Query cover"), 1, ?))`
         + Where do we add this to the code?		 
	  + Example of iteratively refining the code
	    + Then needing to retest all the checks.
  + summary/plot/... for different variables

  + Max Score and Total Score seem to be the same - concerning?
     + Verify that they are correct and being the same make sense.


+ Session implementing some of these validations

```
f = "../Data/NCBIQuery.txt"
z = readNCBITables(f)

class(z)
[1] "list"

length(z)
[1] 2

names(z)
NULL

sapply(z, class)
[1] "data.frame" "data.frame"

sapply(z, dim)
     [,1] [,2]
[1,]  100  100
[2,]   11   11

sapply(z, names)
      [,1]          [,2]         
 [1,] "Description" "Description"
 [2,] "Name"        "Name"       
 [3,] "Name"        "Name"       
 [4,] "Taxid"       "Taxid"      
 [5,] "Score"       "Score"      
 [6,] "Score"       "Score"      
 [7,] "cover"       "cover"      
 [8,] "Value"       "Value"      
 [9,] "Ident"       "Ident"      
[10,] "Len"         "Len"        
[11,] "Accession"   "Accession"  


sapply(z[[1]], class)

Description        Name        Name       Taxid       Score       Score       cover       Value       Ident         Len 
"character" "character" "character"   "numeric"   "numeric"   "numeric" "character"   "numeric"   "numeric"   "numeric" 
  Accession 
"character" 
```



# `cumsum()` approach

+ [functionsNCBI2.R](functionsNCBI2.R)

+ Idea here is to create a group label for  all of the lines in the file to 
  assign them to different groups.
  + We match lines starting with `Query #` or `Alignments:`
```
wq = substring(ll, 1, 7) == "Query #"
wa = substring(ll, 1, 11) == "Alignments:"
w3 = wq | wa
```

+ Now we use `cumsum()` to compute the group labels.
   + The start of `w3 is `FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE`
   + `cumsum()` for this converts the logical vector to numbers and computes the cumulative/running
     sum.
	  + `0, 0, 0, 0, 1, 1, 1`
   + When we get to the first element corresponding to an `Alignment:` row in `ll`, 
     the running sum gets another TRUE and changes to 2.
   + When we get to the next element corresponding to the second `Query #`, it changes to 3
   + Then for the next `Alignment:`, it changes to 4
   + So we have  `0, 0, 0, 0, 1, 1, 1, ....., 1, 2, 2, 2, ...., 3, 3, 3, ..., 4, 4, 4, ...`
   + We now can use
```
g = split(ll, cumsum(w3))
```   
   + This has 5 elements
      + The 4 lines at the top of the file
	  + The table for the first `Query #` to the first `Alignments:`
	  + The material for the first `Alignments:` to the start of the second `Query #` table.
	  + The second `Query #` table lines
	  + The second `Alignments:` section to the end of the file.
	  
+ Note how we are using vectors and not referencing individal row numbers.
   + This is vectorization




+ Now that we have 2 implementations, let's compare the results

```
source("ncbiFunctions.R")
source("ncbiFunctions2.R")
z = readNCBITables(f)
z2 = readNCBITables2(f)
```

```
identical(z, z2)
[1] FALSE
```
So they are not identical. Let's call `all.equal()` to see a summary of the differences
```
all.equal(z, z2)
[1] "names for current but not for target"
```
This is good. The apparent difference is that `z2` has names on the 2 elements in the list.

Let's verify that the elements are identical
```
mapply(identical, z, z2)
[1] TRUE TRUE
```
That's what we want - each element in `z` and `z2` are identical.



