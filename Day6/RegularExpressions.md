# Regular Expressions

Language for finding patterns in text.

+ Finding content
+ Replacing/substituting/removing content


## Functions

+ grep()
+ grepl()
+ gregexpr(), regexpr(), regexec(), gregexec()
+ regmatches()
+ gsub(), sub()


Note the `perl = TRUE` argument for some of these functions.

## Examples

.clm files
+ Find  lines that start with `* day`
```r
 grep("* day", ll, fixed = TRUE)
```
But that is not quite correct.
This doesn't say the text must occur at the start of the string.

```r
 ll.days = grep("^\\* day", ll, value = TRUE)
```

For each string, separate by one or more spaces

```
els = strsplit(ll.days, " +")
table(sapply(els, length))
```

Alternatively,
```
els2 = strsplit(ll.days, "( |  )")
```

This says match  either a single space  or 2 consecutive spaces.

This will be "greedy" when it matches and get the longest match.



So we have seen some "special" characters that means something other than match the literal character.

+ `^`
+ `|`
+ `+`
+ Also `*`



The idea is 
 + match this pattern from where you currently are

The regular expression language does all the hard work of looking ahead 
to see if we currently match the pattern from the current position,
and 
+ if not, moving to the next position and searching for a match, or
+ if there is a match, moving to the character immediately after the matched pattern and continuing
  to look for the next pattern specified in the regular expression


The functions grep(), etc. work separately on each string, i.e., each element of a character vector.

If you want them to treat a collection of strings as a single block, use `paste(strings, collapse =
"")` (or `sep = "\n"`) to make a single string. Then you can find patterns across "lines".


## Special/meta characters

+ `^` and `$` 
   + start and end of string
+ `.` 
   + match any character
+ `[]` - character sets
   + any of the following, e.g, an `a` or `b` or  `c`
   + e.g., `[abcdef]`, `[a-f]`, `[A-Z0-9]`
   + named character sets, e.g., `[[:space:][:punct:]]`
+  `|`
   + Different from character set because specifying entire sub-patterns
   + `(horse|donkey)`
+ Quantifiers for indicating how many times to match the previous pattern.
   + `*` - 0 or more matches
   + `?` - 0 or 1 matches
   + `+` - 1 or more matches
   + `{n}` - n matches
   + `{m,n}` - betweem m and n matches, inclusive
   + `{m,}` - at least m matches
   + `{,n}` - at most n matches



+ [Wireless data](../Data/offline)
+ [Web server log](../Data/eeyore.log)
+ Robot logs
