---
title: SQL Cheatsheet
date: 2022-12-09 15:34:17
tags: SQL
---

## Info

After struggling for hours on the interwebs I usually find the magic combination of SQL syntax for solving a particular problem.  
The problem comes in when I don't frequently work with SQL and forget what the syntax was that I used.  

Here is a collection of my favourite SQL snippets

### Updates

Simple `Update` queryies specifies the table to modify, the columns and values to set and a `Where` clause to avoid updating all records in the table.  

``` SQL
UPDATE MyTable
SET Name = 'sql noob'
WHERE Id = 1
```

But what if you want to update multiple records each with a unique set of value. We can use an `Update From` approach. Typicall this requires a datasource containing the desired changes you want to apply to your table, and hopefully a matching identifier. If you have this you can join your datasource to the table you intend to change and do away with `Where`.

``` SQL
UPDATE MyTable
SET Name = tmp.Name
FROM #TempWithUpdates tmp
INNER JOIN MyTable my
    ON tmp.Id = my.Id
```

### Insert

Adds new rows to a table.  
``` SQL
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);
```

### Delete

Removes one or more rows from a table.
``` SQL
DELETE FROM table_name
WHERE condition;
```
NOTE: the `condition` must be true for a row to be deleted

### Subqueries

A query within another query. The results of the subquery are used in the main query.
``` SQL
SELECT column_name(s)
FROM table_name
WHERE column_name IN (SELECT column_name FROM table_name WHERE condition);
```


### Merge

Combines data from two tables into one.
``` SQL
MERGE INTO target_table USING source_table
ON target_table.column = source_table.column
WHEN MATCHED THEN
UPDATE SET target_table.column = source_table.column
WHEN NOT MATCHED THEN
INSERT (column1, column2, column3, ...) VALUES (source_table.column1, source_table.column2, source_table.column3, ...);
```

### Temp Tables

todo

### WIP 

where not exists
https://stackoverflow.com/questions/35857726/select-records-from-a-table-where-two-columns-are-not-present-in-another-table

where in
https://stackoverflow.com/questions/17548751/how-to-write-a-sql-delete-statement-with-a-select-statement-in-the-where-clause

insert into subquery
https://stackoverflow.com/questions/9692319/how-can-i-insert-values-into-a-table-using-a-subquery-with-more-than-one-result

cte VS temp table vs table variable
https://www.dotnettricks.com/learn/sqlserver/difference-between-cte-and-temp-table-and-table-variable#:~:text=Temp%20Tables%20are%20physically%20created,the%20scope%20of%20a%20statement.
https://stackoverflow.com/questions/2920836/local-and-global-temporary-tables-in-sql-server#:~:text=Local%20temporary%20tables%20(%20CREATE%20TABLE,have%20referenced%20them%20have%20closed

merge output
https://www.sqlservercentral.com/articles/the-output-clause-for-the-merge-statements