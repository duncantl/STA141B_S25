ncbi = readLines("../Data/NCBIQuery.txt")

v = ncbi[grep("^Description", ncbi) ]
m = gregexpr("[A-Z]", v)


m2 = gregexpr(" [a-z]", v)

# But that includes the space.
# We can add 1 to the position.

# However, a more general way is to use a lookbehind to match a pattern
# that does not get included in the match but is required to identify the
# match.
# It is a zero-length assertion.
# See https://www.regular-expressions.info/lookaround.html

m3 = gregexpr("(?<= )[a-z]", v)

m3 = gregexpr("(?<= )[a-z]", v, perl = TRUE)


m4 = gregexpr("([A-Z]|(?<= )[a-z])", v, perl = TRUE)



# Not preceded by is
# (?<!pattern)

# Lookahead i.e. immediately after
# (?=pattern)
# and (?!pattern)

