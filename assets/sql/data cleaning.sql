/*

Data cleaning steps
1. Removing unnecessary columns/select needed columns only
2. Extract youtube channel names from 1st column
3. Rename the column names

*/


SELECT 
	NOMBRE,
	total_subscribers,
	total_views,
	total_videos
FROM top_uk_youtubers_2024


--- CHARINDEX- Allows you to find the starting position of one string inside another string:

SELECT CHARINDEX ('@', NOMBRE), NOMBRE FROM top_uk_youtubers_2024

--- SUBSTRING

CREATE VIEW view_uk_youtubers_2024 AS

SELECT

	CAST(SUBSTRING(NOMBRE, 1, CHARINDEX ('@', NOMBRE) -1) AS VARCHAR(100)) AS
		channel_name,
		total_subscribers,
		total_views,
		total_videos

FROM
	top_uk_youtubers_2024
