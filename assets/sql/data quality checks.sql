/*

# Data quality checks

1. Data should have 100 records of chanel names (row count check)
2. Data needs 3 colums (column count test)
3. The channel name column must be in string format, and other two colunms in numerical format  (data type check)
4. Each record should be unique (duplicate count checks)

row count = 100 
column count = 4

data types
channel_name = VARCHAR
total_subscribers = INTEGER
total_views = INTEGER
total_videos = INTEGER

Duplicate count = 0

*/


---1. Row count check

SELECT
	COUNT(*) as no_of_rows 

FROM 
	view_uk_youtubers_2024

---2. Column count check

SELECT
	COUNT(*) as column_count
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME = 'view_uk_youtubers_2024'

---3. Data type check

SELECT
	COLUMN_NAME,
	DATA_TYPE
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME = 'view_uk_youtubers_2024'

---4. Duplicate count checks

SELECT
	channel_name, 
		COUNT(*) as duplicate_counts
FROM 
	view_uk_youtubers_2024

GROUP BY
	channel_name
HAVING 
	COUNT(*) > 1

