# SQL
![SQL Logo](img-sql.png)

SQL (pronounced as either S-Q-L or SEQUEL) is a language used for relational database management. You can set up a database, create a table, and query the data using this one language. It's great for quickly retrieving information in the back-end and is very easy to read since it resembles English. Typically, this would be used in conjunction with another language, but we can run the program by itself using MySQL.

## How to Run
Install a [MySQL server](https://www.mysql.com/), then run the following commands:
```
sudo service mysql start
sudo mysql -u root
source HowToSQL.sql
```

When you're done, run:
```
exit # or quit or \q
sudo service mysql stop
```

For more info on SQL, check out the [documentation](https://dev.mysql.com/doc/refman/8.0/en/).
