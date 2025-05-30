# try(), catching errors and avoiding recomputing previous pages

Suppose we have a collection of URLs - in the variable `urls` - 
and we want to get the "fully completed" HTML content of each.

```r
lapply(urls, function(u) {
               dr$navigate(u)
			   Sys.sleep(100000)# NOOOOO
			   dr$getPageSource()[[1]]
})
```

I prefer the following which seems like the same but makes things easier.

Move the anonymous function in the call to `lapply()` and assign it 
to a variable, i.e.,
```r
getDynPage =
function(u) {
   dr$navigate(u)
   Sys.sleep(100000)# NOOOOO
   dr$getPageSource()[[1]]
}
```

Now, we can test this function before `lapply()`ing to 1000 urls.
We can check
```r
nchar(getDynPage(urls[1]))
nchar(getDynPage(urls[100]))
grepl("<html", getDynPage(urls[1]))
```

So this helps to verify the code works before we apply it to a large number of URLs.
But more usefully, we can easily add the following protection
```r
ans = lapply(urls, function(u) try(getDynPage(u)))
names(ans) = urls)
```
Note that we put names on the result to associate each element with the corresponding URL.
This will help later.

The `try()` function does the following:
+ if the function returns successfully, `try()` returns the value of that call to `getDynPage()`
+ if the function (getDynPage()) throws an error, `try()` returns an object that identifies an error
   but it does not cause R to stop the `lapply()` call. 
   It continues processing each of the next elements of `urls` and filling the corresponding
   element of `ans`.
   

So after the call the `lapply()` above, we can determine which, if any, elements resulted in an error.
```r   
err = sapply(ans, inherits, 'try-error')
table(err)
```

We are check each element of `ans` to see if it was due to an error that `try()` "caught" but
marked.
`inherits()` checks to see if any of the elements of `class()` is `"try-error"`.


Without the inclusion if the `try(getDynPage(u))`,
we would stop when the first error occurred.

Suppose we either dropped that URL or fixed the problem, 
we would have to start from the beginning again, i.e.,
reprocess the original URLs which had no errors.

So 
```r
ans = lapply(urls, function(u) try(getDynPage(u)))
```
allows us to continue after each error and then
return to determine which URLs caused the errors.

We might find that there were only a few of these.
We might decide to omit these.

Alternatively, we might find some common characteristic for many or all of these
and find a second approach to handle these, e.g., a `getDynPage2()` function.
Rather than re-processing all URLs, we can use

```r
ans[err] = lapply(urls[err], function(u) try(getDynPage2(u)))
```
In other words,  we are only 
+ processing the urls for which we had an earlier error
+ replacing the elements of `ans` for which we had an earlier error
+ calling getDynPage2, not getDynPage for each.

Some of these calls to `getDynPage2()` may  yield errors, but these only replace
existing errors.

So we can compute `err` again - 
```r
err = sapply(ans, inherits, 'try-error')
table(err)
```
and see which URLs  are still causing errors.


So `try()` let's us 
+ process all our elements
+ examine the characteristics of those which failed
+ recompute the elements with errors and correct them
+ iterate this process without having to recompute all of the original elements.


