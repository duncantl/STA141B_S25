# A student identified an interesting situation with subset()
# They were using
# p = dbGetQuery(db, "People")
#
# But we will use 3 rows from that table as a minimal reproducible example

p = structure(list(ID = 16059:16061, playerID = c("rosenwa01", "rosepe01", 
"rosepe02"), birthYear = c(1965L, 1941L, 1969L), birthMonth = c(2L, 
4L, 11L), birthDay = c(19L, 14L, 16L), birthCity = c("Brooklyn", 
"Cincinnati", "Cincinnati"), birthCountry = c("USA", "USA", "USA"
), birthState = c("NY", "OH", "OH"), deathYear = c(NA_character_, 
NA_character_, NA_character_), deathMonth = c(NA_character_, 
NA_character_, NA_character_), deathDay = c(NA_character_, NA_character_, 
NA_character_), deathCountry = c(NA_character_, NA_character_, 
NA_character_), deathState = c(NA_character_, NA_character_, 
NA_character_), deathCity = c(NA_character_, NA_character_, NA_character_
), nameFirst = c("Wayne", "Pete", "Pete"), nameLast = c("Rosenthal", 
"Rose", "Rose"), nameGiven = c("Wayne Scott", "Peter Edward", 
"Peter Edward"), weight = c("220", "192", "180"), height = c("77", 
"71", "73"), bats = c("R", "B", "L"), throws = c("R", "R", "R"
), debut = c("1991-06-26", "1963-04-08", "1997-09-01"), bbrefID = c("rosenwa01", 
"rosepe01", "rosepe02"), finalGame = c("1992-04-14", "1986-08-17", 
"1997-09-28"), retroID = c("rosew001", "rosep001", "rosep002"
)), row.names = 16059:16061, class = "data.frame")


# They had 
ID = "rosepe01"

# and then used that 
x = subset(p, playerID == ID)

# The result is an empty data.frame.

# However, putting the value of ID directly into the command
y = subset(p, playerID == 'rosepe01')

# we get one row.

# We expect the value of the variable ID in our global environment/workspace
# to be used. However, subset() uses non-standard evaluation (NSE). This is convenient but makes it
# harder to reason about.
#
# The issue is that ID is the name of a column in p.
# So playerID == ID uses the columns playerID and ID in p and does not need to look for ID
# in the parent.frame() - which is GlobalEnv.

# subset() is convenient as we don't have to specify the data.frame to qualify each variable
# But while this helps for playerID, it caused problems with ID as we didn't mean the ID
# column in the data.frame, but instead, the ID variable in the works space.

# We could have used 
p[p$playerID == ID, ]


#
# If we had used a different name for our ID variable, e.g., ID0
# this works as we might expect.
ID0 = "rosepe01"
x = subset(p, playerID == ID0)


