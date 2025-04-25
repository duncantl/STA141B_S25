
+ Look-behind and "zero length assertions"
   + [ncbiColumns.R](ncbiColumns.R)
      + Find the column positions in the NCBI data using regular expressions
	    and handling the capitalized letters and the one non-capitalized
		column name start.
		
+ [weblog.R](weblog.R)
   + Reading Web server [log file](../Data/eeyore.log)
   
+ [Rsession](Rsession)
   + The code from today's R session.
   

+ [weblog3.R](weblog3.R)
   + A fragile approach that uses `strsplit()` on spaces and relies on the number of 
     elements varying only in the last field/column/variable. That works here but if the order
	 of the fields were different or there were additional fields, this would not work.
   + Also, we have to do some cleanup of the variables, e.g. remove leading and trailing `"` and
     `[` `]`
	 characters.
