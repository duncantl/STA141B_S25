## Day 14

+ [questions](Qs.md) about the stats.stackexchange database
+ [answers](ans.sql) for many of these questions
+ [SQL session](day14.sqlsession)
+ [Question about behavior of subset() function](subset_ID.R)
  + Answer: the variable ID used in `subset(p, playerID == ID)` 
    is also a column in `p` so we end up comparing
	 `p$playerID == p$ID` rather than
	 `p$playerID = ID` where ID is in the global environment/workspace.
