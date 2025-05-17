# p = db$People

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

ID = "rosepe01"
x = subset(p, playerID == ID)
y = subset(p, playerID == 'rosepe01')


# The issue is that ID is a column in p.
# So playerID == ID uses the columns playerID and ID in p and does not need to look for ID
# in the parent.frame() - which is GlobalEnv.
