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

todo

### Delete

todo

### Subqueries

todo

### Merge

todo

### Temp Tables

todo
