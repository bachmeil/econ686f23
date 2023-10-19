# Create a database
library(sqldf)
sales1 <- read.csv("sales1.csv")
sales2 <- read.csv("sales2.csv")
# sales1 and sales2 are data frames in R
# Tell sqlite to create a new database
db.sales <- dbConnect(SQLite(),
                      dbname="sales.sqlite")
# db.sales is an R object holding information
# about the sales.sqlite database
# Add a new table
dbWriteTable(conn=db.sales, name="salesdb1",
             sales1, overwrite=TRUE,
             row.names=FALSE)
# Connection, name of table in the database
# you want to create, data to copy from R
dbWriteTable(conn=db.sales, name="salesdb2",
             sales2, overwrite=TRUE,
             row.names=FALSE)
# Basic queries
# dbGetQuery: Usual function to run a query
# Returns output in R format
# First argument is the DB connection
dbGetQuery(db.sales, 
           "select * from salesdb1")
dbGetQuery(db.sales, 
           "select * from salesdb2")

# Work with the data
s2 <- dbGetQuery(db.sales, 
           "select * from salesdb2")
class(s2)
plot(s2$price, type="l")
# s2 is R data like any other R data we've
# worked with
# where is used to restrict the data
july.sales <- dbGetQuery(db.sales,
      "select * from salesdb1 where month='201807'")
july.sales
# Multiple conditions
# Use and/or
jun_jul <- dbGetQuery(db.sales,
  "select * from salesdb1 where month='201806' or month='201807'")
jun_jul <- dbGetQuery(db.sales,
                      "select * from salesdb1 where month<='201807'")
# Selecting variables
dbGetQuery(db.sales,
   "select customer, amount from salesdb1 where month<='201807'")
dbGetQuery(db.sales,
"select customer, amount from salesdb1 where month<='201807' order by amount")

# Sorting the results
dbGetQuery(db.sales,
paste0("select customer, amount from salesdb1 ",
 "where month<='201807' order by amount"))
dbGetQuery(db.sales,
paste0("select customer, amount from salesdb1 ",
  "where month<='201807' order by amount desc"))

# Limits
dbGetQuery(db.sales,
paste0("select customer, amount from salesdb1 ",
"where month<='201807' order by amount desc ",
"limit 3"))

# Grouping
# Sum the sales
# Have to provide the group
totals <- dbGetQuery(db.sales,
"select customer, sum(amount) from salesdb1 group by customer")
totals
# What if there is no group by clause?
dbGetQuery(db.sales,
           "select customer, sum(amount) from salesdb1")
# Joining
# 6% flat commission
revenue <- dbGetQuery(db.sales,
"select * from (salesdb1 join salesdb2 on salesdb1.month=salesdb2.month)")
revenue
revenue <- dbGetQuery(db.sales,
                      "select employee, amount, price from (salesdb1 join salesdb2 on salesdb1.month=salesdb2.month)")
revenue
# Can do further calculations in R
mary <- revenue$employee == " Mary"
sum(revenue[mary,"amount"] * revenue[mary, "price"])*0.06




