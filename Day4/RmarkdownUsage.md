
## My Preferred Workflow

+ Develop functions in one or more files dedicated for writing functions.
   + When you update a function, use `source()` to read that file and (re)define the functions it
     contains.
   + You can create and edit these files in RStudio. Not every file needs to be or should be an Rmarkdown file.	 

+ Use simple .R files for experimenting and refining code.  
   + You can open these in RStudio.  
   + You can have several of these "script" files. You can also  keep code for different purposes
     in the same file but try to separate them with e.g.,
```
 ################################
```
    and a comment that says what this is for.

+ Use Rmarkdown only for writing your report, not for developing the code.
   + Rmarkdown is a little cumbersome for managing trial snippets of code, debugging code, ...
   + It is great for taking the final code and running it, inserting the plots and text output and
     creating the PDF.

+ Move code from the experimental .R files either
   + into a function in a .R file, or 
   + into the Rmarkdown as part of the code that calls your functions and generates the
     intermediate results or output to appear in the report PDF.



I will often open a .R file and start writing a sequence of commands to explore the problem.

Gradually, I might move some lines of code into a function as I know I need to apply this 
to another file.  I'll create a new file for that function, but often have several related functions
in the same file.

As I add more steps to a function, at some point, I'll think "this is getting too large".
I'll look at the function and see if I can put the new part into  a separate function.
And I may look at the previous steps and say "time to make some of these separate functions."



# Background

When talking with students over the years in office hours, etc.
I see them using Rmarkdown in a way that I think makes some things more complicated
for them.

Managing running code in several "chunks"  within an Rmarkdown file is not terribly difficult
but it can be error prone.
One has to make certain to reset the state of your R workspace appropriately. Otherwise,
the results will not be the same as if you ran everything from scratch.

Importantly, I see people cut-and-pasting  lines from a chunk and then
putting them into a new chunk in the same Rmarkdown file, just so they can run that code separately
to try something.

They can run this code directly in R. Putting in a new chunk means they have to remember to delete
that or merge that code back into the original code from where it was cut-and-pasted.

The goal is to have the interface help you, not that you obey it and do more work.


