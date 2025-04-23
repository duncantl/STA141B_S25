
# Reading the [offline data][../Data/offline]

This explores 
regular expressions and strategies for reading the 
offline wireless signal detection data.

We explore different strategies, check and verify the structure,
and split the values into a form that we can stack them.

We create 2 data.frames 
  + for the common variables at the start of each line
  + for each detected device with.

Then we repeat the relevant row in common for each detected device and create one data.frame.


+ [R session](Rsession) from class

+ [More direct/succinct description of the approaches and code than in the Rsession.](offline.R)
   + This is for the "longer"/initial way of doing this.

+ [More succinct "clever" way to read the offline](offline2.R)
