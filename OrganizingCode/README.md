
# Organizing Code for Projects/Assignments

+ Do not use an Rmarkdown to do the exploration and write functions.
  + Only put code and text into the Rmarkdown file that you know will go into the report.

+ Do the initial explorations with code in a .R file 
  + or at the R prompt and move commands that you want to keep into the .R file.
  
+ Use different .R files for different aspects of the exploration in order to keep 
   the code more understandable for you.
   
+ As you want to include explorations in the  report, move the code into the Rmarkdown file.
   + Make certain to include all the code that must be run before that.
   + Write a narrative that describes these steps.
   
   
+ When you start to write functions, put them in a .R file
   + one file per function or several related functions in a .R file
   
+ Use `source("funs.R")` every time you make a change to a function and want to test it.
   + You will be iteratively refining the function(s) so this is a much simpler way than managing 
     

+ To display the code in a .R file (function or script) in the Rmarkdown report, use
```
  ```{r, file = "funs.R"}
  ```
```
