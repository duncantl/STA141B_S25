+ [dayMonth.R](dayMonth.R)
   + We developed a "whole-object/vector"  approach to extracting the 
     day and month from the .clm files and avoided a loop.
	 See this and other implementations in [Day4](../Day4)
	 
+ 2 examples of debugging a problem
   + [clmFuns2_bug.R](clmFuns2_bug.R)
     + a wrong variable name, often caused by cutting and pasting from an R session.
	 + easily found with codetools::findGlobals()
	 + or running the code and stopping in the error and reading the error message and the code.
	 
   + [clmFuns2_bug2.R](clmFuns2_bug2.R)
      + not a bug but get NA values when we know we shouldn't.
	  + how do we step through the code and see where they occur?
	  
   + [trigger.R](trigger.R)
      + code to trigger both bugs and figure out the problem.
	  
