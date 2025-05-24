1STA141B, Spring Quarter 2025

Instructor: Duncan Temple Lang


Piazza [link](https://piazza.com/class/m8vu0p011kn5a2)


### Local copies of all the files in the class repository 

So you can view the files in your browser, or use directly in R, etc.
you 
+ clone the repository into a directory on your machine
+ pull any updates as often as you want.

In a terminal, do this once
```
git clone https://github.com/duncantl/STA141B_S25.git
```

Then, any time you want to get any updates - new files, changes to existing ones - 
```
cd STA141B_S25
git pull
```


# Files



+ [Organizing Code](OrganizingCode/README.md)





+ [Day 1](Day1)
   + [Slides](Day1/Day1.key.pdf)
   + [NCBI fixed-width format data](Data/NCBIQuery.txt)
   

+ [Day 2](Day2) (04/03)
  + Reading fixed-width format data.frames - NCBI
  + [README](Day2/README.md)
  + [Rsession](Day2/Rsession)
  + [R functions](Day2/ncbiFunctions.R)
  + [R functions for alternative approach (preferred)](Day2/ncbiFunctions2.R)  

+ [Day 3](Day3) (04/08)
  + More work on reading NCBI data.frames
  + [README](Day3/README.md)
  + [Rsession](Day3/Rsession)  
  + [mkHeader function](Day3/header.R)
  + [compute starting position of NCBI columns](Day3/colStarts.R)
  
+ [Day 4](Day4) (04/10)
  + Common issues in assignment 1 part 1
     + How to organize code, functions, report text and R markdown.
        + Keep the functions in separate files, out of Rmd file
     + Avoid loops to reduce 
	    + Whole-object/vector mindset
	 + If using loops, preallocate the answer vector to have the correct number of elements.
     + Avoid repeating code with one argument changed.
	 
  + [README](Day4/README.md)
  
+ [Day 5](Day5) (04/15)
  + Debugging
  + "Whole-object/vector" approach
  + [README](Day5/README.md)
  
+ [Day 6](Day6) (04/17)
  + [Regular expressions](Day6/RegularExpressions.md)
  + [Regex commands](Day6/regexCommands.md)
  + [R session](Day6/Rsession)

+ [Day 7](Day7) (04/22)
  + Reading the wireless detected device data [offline](../Data/offline)
  + [README](Day7/README.md)
  + [R session](Day7/Rsession)
  + [exploring approach](Day7/offline.R)
  + [more succinct approach](Day7/offline2.R)  
  
+ [Day 8](Day8) (04/24)
  + [README](Day8/README.md)
  + [Computing the NCBI column positions with regular expressions](Day8/ncbiColumns.R)
  + [Reading Web server log records]
     + [version 1](Day8/weblog.R)
     + [version 2](Day8/weblog2.R)	 
     + [version 3](Day8/weblog3.R)	 	 
  + [R session](Day8/Rsession)
  
+ [Day 9](Day9) (04/29)
  + [More on reading Web server log records](../Day8/weblog3.R)
  + [R session](Day9/Rsession)


+ [Day 10](Day10) (05/01)
  + [R session](Day10/prep.session)
  + [getCaptures function](Day10/getCaptures.R)
  
+ [Day 11](Day11) (05/06)
   + Relational Databases
   + [Slides](Day11/dbms.html)
   + [Summary of single table operations](Day11/Overview.md)

+ [Day 12](Day12) (05/08)
  + [README.md](Day12/README.md)

+ [Day 13](Day13) (05/13)
  + [README.md](Day13/README.md)

+ [Day 14](Day14) (05/15)
  + [README.md](Day14/README.md)

+ [Day 15](Day15) (05/20)
  + [README.md](Day15/README.md)

+ [Day 16](Day16) (05/22)
  + [README.md](Day16/README.md)

+ [Day 17](Day17) (05/27)
  + [README.md](Day17/README.md)

+ [Day 18](Day18) (05/29)
  + [README.md](Day18/README.md)

+ [Day 19](Day19) (06/03)
  + [README.md](Day19/README.md)

+ [Day 20](Day20) (06/05)
  + [README.md](Day20/README.md)
