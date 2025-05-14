Available at https://ucdavis.app.box.com/folder/262877205241?s=i07snhsqr66pnw9wk119uuaj32n6xa0l
Size = 2.5G


sqlite3 ~/Data/stats.stackexchange.db 

.tables

select COUNT(*) FROM Users;

pragma table_info(Users);

select COUNT(DISTINCT Id) FROM Users;


# Where are the people located

SELECT Location, COUNT(Location) AS num FROM Users ORDER BY num DESC LIMIT 30;


Better written as

SELECT Location, 
       COUNT(Location) AS num 
FROM Users 
ORDER BY num DESC 
LIMIT 30;




SELECT Location, 
       COUNT(Location) AS num 
FROM Users 
GROUP BY Location
ORDER BY num DESC 
LIMIT 30;


Probably want to strip away everything before the last ,
Can do this in R.
  How in SQL?


