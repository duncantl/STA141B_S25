library(RSQLite)

if(FALSE) {
    file = "lahman_1871-2022.sqlite"
    db = connect(file)
    # get the names of the tables
    names(db)
    # get a data.frame of the number of rows and columns for each table
    dim(db)
    ncol(db)
    nrow(db)

    # return the first n rows of each table in the database
    head(db)

    # Copy the specified table from the database to an R data.frame
    db$People

    # copy the tables from the database to R data.frames
    t = getTables(db)
    sapply(t, class)
    sapply(t, nrow)


    # execute a SQL query in the default database
    sql("SELECT COUNT(*) FROM People")


    # Get the text of the SQL command defining/creating a given table.
    getSQL("People")

    # A data.frame describing the columns in the specified table.
    # name, type, notnull, dflt_value, primary key (pk)
    getTableInfo("People")
}


names.SQLiteConnection =
function(x)
    dbListTables(x)

head.SQLiteConnection =
function(x, n = 6L, tables = names(x), ...)    
{
    structure(lapply(tables, function(tbl) thead(n = n, dbms = x, tableName = tbl)),
              names = tables)
}

thead =
    # thead(People)
    # uses the default database.
function(table, n = 6L, dbms = db, tableName = deparse(substitute(table)))
{
   dbGetQuery(dbms, sprintf("SELECT * FROM %s LIMIT %d", tableName, n))
}


dim.SQLiteConnection =
function(x, tables = names(x) )
{
    nr = nrow.SQLiteConnection(x, tables)
    nc = ncol.SQLiteConnection(x, tables)
    data.frame(nrow = nr, ncol = nc, row.names = tables)
}


nrow.SQLiteConnection =
    # Won't be called via nrow(db)
    # nrow() calls dim() and gets the first element.
    # So returns a data.frame with 1 column rather than a vector.
    # Same for ncol.SQLiteConnection and ncol().
function(x, tables = names(x) )
{
    tables = names(x)
    q = sprintf("SELECT COUNT(*) FROM %s", tables)
    structure(sapply(q, function(qry) dbGetQuery(x, qry)[1, 1]),
              names = tables)
}

ncol.SQLiteConnection =
function(x, tables = names(x) )
{
    tables = names(x)
    structure(sapply(tables, function(t) length(dbListFields(x, t))),
              names = tables)
}


connect =
function(file)
{
    if(!file.exists(file))
        stop("No such file: ", file, ". Check the path to the file is correct")

    dbConnect(SQLite(), file)
}


"$.SQLiteConnection" =
function(x, name)    
{
    getTable(name, x)
}

# [ method

getTable =
function(tableName, db)
{
    tbls = dbListTables(db)
    m = pmatch(tableName, tbls)
    if(is.na(m))
        stop("No table matching ", tableName, " in ", paste(tbls, collapse = ", "))

    tableName = tbls[m]
    dbGetQuery(db, sprintf("SELECT * FROM %s", tableName))
}

getTables =
function(db, tables = dbListTables(db))
{
    structure( lapply(tables, getTable, db),
               names = tables)
}


sql = query =
    # 
function(sql, dbms = db)
{
    dbGetQuery(dbms, sql)
}

getSQL =
    # Get the SQL code to define a given table
function(tableName = dbListTables(dbms), dbms = db)
{
    q = sprintf("SELECT sql FROM sqlite_schema WHERE name = '%s'", tableName)
    ans = lapply(q, query, dbms)
    if(length(tableName) == 1)
        return(ans[[1]])
    structure(ans, names = tableName)
}

getTableInfo =
    # Get information for a table using the pragma table_info()
function(tableName = dbListTables(dbms), dbms = db)
{
    q = sprintf("pragma table_info('%s')", tableName)
    ans = lapply(q, query, dbms)
    if(length(tableName) == 1)
        return(ans[[1]])
    structure(ans, names = tableName)
}
