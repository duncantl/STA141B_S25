
# Inner Join

select * 
FROM fang_info AS i, 
     fang_prices AS p, 
	 fang_sic AS d 
WHERE 
  i.ticker = p.ticker 
 AND 
   i.sic_code = d.SIC;


Drops the records where there isn't a match in the 2nd table, i.e., the one on the right of the join.



If we inner joined just fang_info and fang_prices and not fang_sic, we
get all combinations of company and its price


```sql
select * 
FROM fang_info AS i, 
     fang_prices AS p 
WHERE 
  i.ticker = p.ticker ;
```

# LEFT JOIN

If we want to keep the records in the 1st/left table even if there is no
match in the second table, use an LEFT JOIN

```sql
select * 
FROM fang_info AS i 
LEFT JOIN fang_prices AS p 
ON i.ticker = p.ticker 
LEFT JOIN fang_sic AS d 
ON i.sic_code = d.SIC;
```

A RIGHT JOIN of A and B is equivalent to a LEFT JOIN of B and A, i.e.,
change the order of the tables.

