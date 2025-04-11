
## Workflow

+ Start exploring approaches and code by putting commands in a .R file
+ Add a few more commands.
+ Realize that they are working and that I can start to think about 
  turning them into a function.
  
+ Create a new file - functions.R, say, or readClimate.R 
  + Use `source("functions.R")` to read the new version.
    + Make certain to do this when you make changes that you are ready to use/test
  + More reliable than remembering to reevaluate chunks in Rmd files.	
 
+ When starting to write report, then create a .Rmd file
  + Only include the material you want to include in the report
  + The functions are already written.
  +  If you want to include the code in the function files, there is a mechanism
     to include those files directly, i.e., w/o copying their contents manually.


Analogy: writing an essay.
  + Write down possible directions
     + different arguments
     + where to look for information
	 + ....
  + Do research 
     + Collect information
  + Create outline
  + Write report
  
Would you start with the .docx file that you were going to submit? 


+ Rmd files are clunky for writing experimental code and functions

+ See [RmarkdownUsage.md](RmarkdownUsage.md)


## Why separate Functions and Script Files?

Because I want to change a function and then re-source() it 
and then test it.

I don't want to re-run all the additional computations, e.g.,
+ unzip the files
+ list the files
+ read any data
+ ...

I want to change how a function works and test that single aspect
on existing data.


### Check for Non-local Variables - typos, "pasteos"

When developing functions, one common approach is to write
a command and run it at the R prompt (either directly or indirectly)
and then refine it. 

```
f = "../Data/NCBIQuery.txt"
ll = readLines(f)
w3 = substring(ll, 1, 7) == "Query #"
```

When it finally gives you what you want/expect,
we add it to the body of a function.
We continue to add commands to the function.

```
doit = 
function()
{
	ll = readLines(f)
    w3 = substring(ll, 1, 7) == "Query #"	
}
```

Then we add parameters/formal arguments to the function definition

```
doit = 
function(filename)
{
	ll = readLines(f)
    w3 = substring(ll, 1, 7) == "Query #"		
}
```

We have a mismatch. We have `filename` as the argument but the call to `readLines()`
uses `f` which is our convenient variable name when experimenting.

How do we find where we have reference to variables  that are probably wrong, i.e.,
not defined in our function as parameters or variables that we created in previous assignments?


Use `codetools::findGlobals()` to find such variables.
```
codetools::findGlobals(doit, FALSE)$variables
```
This gives us
```
[1] "f"
```

Imagine if we hadn't found this. We have a collection of these .txt files.
What happens withh
```
a = doit(f)
files = list.files(pattern = ".txt")
v = lapply(files, doit)
```

# DRY - Don't Repeat Yourself

+ The DRY Principle
   + avoid repeating the same code with minor changes.
   + if have to change it, we have to change all instances of it.  So this is hard to maintain and
     adapt.
	 + Better to abstract it, e.g.,
	    + loop over elements (lapply/sapply)
		+ write a function and call that several times.

+ Example of repeating code - [RepeatedCode.R](RepeatedCode.R)

# `for()` Loops

See 

+ [dayMonth.R](dayMonth.R) - original loop, concatenation 
+ [dayMonth2.R](dayMonth2.R) - using vectorization 
+ [dayMonth3.R](dayMonth3.R) - slight variation of dayMonth2.R to deal with extra spaces
+ [dayMonth4.R](dayMonth4.R) - slight variation of dayMonth3.R to create the data.frame.


+ [loops.md](loops.md)


## Complexity

## Concatenation

## Try to use vectorized approaches - all elements in one operation.



# Debugging


