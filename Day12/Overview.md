
+ Structure and terminology
+ Single table operations
  + subsetting  rows - WHERE
  + columns - 
  + derived columns
     + COUNT() and COUNT(DISTINCT var)
	 + operations, e.g., age + 10, ` first ||  last`
  + column names
  + ORDER BY   
  + GROUP BY
     + HAVING
  
+ Sending SQL commands from R
  + connect
  + send
  + result is always a data.frame
  

+ 2 and more tables
  + JOIN
  + concept
     + cartesian product and filter.
  + LEFT JOIN of A and B
     + keep records in A even if no match in B
	    + set columns corresponding to B as NULL
