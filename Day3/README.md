# Day 3


## Review steps for reading NCBI data
+ read lines entire file
+ group lines to get tables
+ for each table
   + read data values
      + need positions of the start of each column, 
      + then the column widths
   + transform columns, e.g., Query cover column which is %
   + column names


# Topics

+ Go through the functions from Day2
  + Connect to steps
  + how to write functions.
      + Small/short/focused functions 
	      + avoid complexity and losing focus
		  + easier to test separately from the top-level task.
+ Do the full mkHeader()
  + Note how we have turned this into calling existing functions
    and not having to write low-level/direct manipulation solutions
	ourselves, i.e. a call to read.fwf() with 2 lines and then combine together.
  + See [header.R](header.R)
+ Computing the column starts.
   + See [colStarts.R](colStarts.R)

+ [Rsession](Rsession)


# Debugging

Useful/important functions

+ debug()
   + stop when the specified function is called and explore and control evaluation step-by-step
+ recover()
    + `options(error = recover)`
	+ allows moving between the different calls on the call stack and exploring the current state of
      each call and call frame.
+ browser()
    + Instead of debug, can add this as a command anywhere in your function and
	  R will stop there and allow exploration and step-by-step evaluation
+ trace
    + can add code to run each time the function is called or exits
	+ can add the code anywhere in the body of the function.





