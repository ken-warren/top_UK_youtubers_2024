# Analysis of Top 100 UK Youtubers

## Table of Contents

- [Overview](#overview)
- [Objectives](#objectives)
- [Statement of Problem](#statement-of-problem)
- [Data Source](#data-source)
- [Tools](#Tools)
- [SQL Data Analysis](#sql-data-analysis)
- [Power BI Report](#power-bi-report)
- [Visualization](#visualization)
- [Validation](#validation)
- [Conclusion](#conclusion)
- [Recommendations](#recommendations)


## Overview

In this project, I’m studying the top 100 UK YouTubers to assist a marketer in optimizing campaign costs. I explore the readily available data on Top 100 UK YouTube channels using Excel, perform data cleaning and manipulation in SQL, and then transfer the cleaned dataset to Power BI for report generation. By comparing subscriber metrics between SQL and Excel, I’ll recommend high-return YouTubers for the campaign. The goal is to guide marketers in allocating resources effectively based on potential returns. 


## Objectives

1. To explore data on the top 100 UK YouTubers using Excel and gain insights into their performance.
2. To clean the dataset by handling missing values, duplicates, and perform necessary transformations for analysis.
3. To analyze subscriber metrics using both SQL and Excel. Compare results in terms of difference.
4. To transfer cleaned data to Power BI and create interactive visualizations for insights.
5. To recommend high-potential YouTubers based on engagement rates and potential returns.


## Statement of Problem

Ken, a marketer from leading U.K company, wants to lead a successful marketing campaign for the company's products. The company has already approved the marketing budget, so Ken needs to channel the budget towards a successful campaign. Ken faces the challenges of overpricing from third party providers and inconsistent information from the internet. To help Ken lead a successful campaign, we will analyze data on top 100 Youtubers by views, subsbcribers and video uploads. This will help Ken overcome his challenges and make a data-driven decisions on which youtubers to collaborate with for his marketing campaign to be successful.


## Data Source

The data on top 100 U.K Youtubers contrywise is available on [Kaggle](https://www.kaggle.com/datasets/bhavyadhingra00020/top-100-social-media-influencers-2024-countrywise). Since the data is in a different language, you can download the Python-translated dataset that gets the total subscribers, total videos and total views [here](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/datasets/youtube_data_from_python.csv).


## Tools
1. [Excel](https://www.microsoft.com/en-us/microsoft-365/excel) - For exploring and viewin the dataset.
2. [SQL](https://aka.ms/ssmsfullsetup) - For data manipulation and cleaning
3. [Power BI](https://aka.ms/pbidesktopstore) - For creating dashboards

---

## SQL Data Analysis
## Data Cleaning

Data cleaning steps;
1. Removing unnecessary columns/select needed columns only
2. Extract youtube channel names from 1st column
3. Rename the column names

First, create a new database for your excel file. You can open a new query and use the command 
```sql
CREATE DATABASE (your_database_name)

--- use created database:
USE (your_database_name);
```
Go ahead and import Flat file of the downloaded dataset in your created database as shown below.

![image](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/images/import_dataset.png)


Expand on the created database, and you'll see the imported dataset. Right click on it and select top 1000 rows to view the dataset.

![image](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/images/Load_data.png)


The dataset should appear as shown below.

![image](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/images/loaded_db_table.png)
---

Now, let's carry on with the data cleaning;
1. Removing unnecessary columns/select needed columns only
```sql
SELECT 
	NOMBRE,
	total_subscribers,
	total_views,
	total_videos
FROM
  top_uk_youtubers_2024
```

2. Extract youtube channel names from 1st column
```sql
SELECT
  CHARINDEX ('@', NOMBRE), NOMBRE
FROM
  top_uk_youtubers_2024
```
3. Rename the column names and create a new view
```sql
CREATE VIEW view_uk_youtubers_2024 AS

SELECT

	CAST(SUBSTRING(NOMBRE, 1, CHARINDEX ('@', NOMBRE) -1) AS VARCHAR(100)) AS
    channel_name,
		total_subscribers,
		total_views,
		total_videos

FROM
	top_uk_youtubers_2024
```


Expand the view tab under the existing database and you'll see the created view. Right click on it and select top 1000 rows as shown below.

![image](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/images/view_cleaned.png)


The output should show this.

![image](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/images/loaded_view_cleaned.png)

---

## Data Quality Checks

This will include;
- Checking row and column counts
- Assessing the data types
- Checking for any duplicates

1. Row and column counts check
```sql
SELECT
	COUNT(*) as no_of_rows 

FROM 
	view_uk_youtubers_2024

SELECT
	COUNT(*) as column_count
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME = 'view_uk_youtubers_2024'
```

2. Assessing the Data Types
```sql
SELECT
	COLUMN_NAME,
	DATA_TYPE
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME = 'view_uk_youtubers_2024'
```
3. Checking for any duplicates
```sql
SELECT
	channel_name, 
		COUNT(*) as duplicate_counts
FROM 
	view_uk_youtubers_2024

GROUP BY
	channel_name
HAVING 
	COUNT(*) > 1
```

---

# Power BI Report

Load the cleaned dataset from the SQL Server into Power BI using the following steps;

1. Open blank report. From the **Home** tab, select **Get data**, then **SQL Server**.

![image](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/images/import_SQL_server.png)


2. Type in your Server name, database name and select **OK**.

![image](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/images/Server_name.png)


3. Select and load the cleaned dataset.

![image](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/images/load_powerbi.png)


The DAX formulae used are;

1. Total subscribers
```dax
Total Subscribers (M) = 
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers_2024[total_subscribers])
VAR TotalSubscribers = DIVIDE(sumOfTotalSubscribers, 1000000)

RETURN(TotalSubscribers)
```
2. Total videos
```dax
Total Videos = 
VAR TotalVideos = SUM(view_uk_youtubers_2024[total_videos])

RETURN(TotalVideos)
```
3. Total views
```dax
Total Views (B) = 
VAR billion = 1000000000
VAR sumOfTotalViews = SUM(view_uk_youtubers_2024[total_views])
VAR TotalViews = DIVIDE(sumOfTotalViews,billion)

RETURN(TotalViews)
```
4. Average views per video
```dax
Avg Views per Video (M) = 
VAR sumOfTotalViews = SUM(view_uk_youtubers_2024[total_views])
VAR sumOfTotalVideos = SUM(view_uk_youtubers_2024[total_videos])
VAR avgOfViewsPerVideo = DIVIDE(sumOfTotalViews, sumOfTotalVideos, BLANK())
VAR finalAvgOfViewsPerVideo = DIVIDE(avgOfViewsPerVideo, 1000000, BLANK())

RETURN(finalAvgOfViewsPerVideo)
```
5. Views per subscribers
```dax
Views per Subscriber = 
VAR sumOfTotaViews = SUM(view_uk_youtubers_2024[total_views])
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers_2024[total_subscribers]) 
VAR ViewsPerSubscriber = DIVIDE(sumOfTotaViews, sumOfTotalSubscribers, BLANK())

RETURN(ViewsPerSubscriber)
```

## Visualization

## Power BI Report on Top 100 UK Youtubers

<img src="{{"/assets/Top_UK_youtubers.jpg" | prepend: site.baseurl | prepend: site.url}}" alt="Untitled">

![image](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/images/Top_UK_youtubers.jpg)

---

# Validation

## Total Subscribers Analysis

Here we view the difference in subscribers metrics between Excel and SQL.

The [SQL codes](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/sql/validation%20cheques.sql) used to generate these values are;
```sql
DECLARE @conversionRate FLOAT = 0.02;		--- conversion rate at 2%
DECLARE @productCost MONEY = 5.0;		--- production cost at $5
DECLARE @campaignCost MONEY = 50000.0;	        --- campaign cost at $50,000


---2.
WITH channelData AS (
 SELECT
		channel_name,
		total_views,
		total_videos,
		ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video

	FROM 
		youtube_db.dbo.view_uk_youtubers_2024
)

SELECT
		channel_name,
		rounded_avg_views_per_video,
		(rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
		(rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
		(rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost AS net_profit

	 FROM channelData

WHERE
	channel_name IN ('NoCopyrightSounds', 'DanTDM', 'Dan Rhodes')

ORDER BY
	net_profit DESC
```


![image](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/images/TotalSubAnalysis.png)

---

## Conclusion

From the above analysis it is evident that ```Dan Rhodes``` exhibits the highest returns on investment (USD 1.065M). Looking at the channel's engagement rates (11.15M views per video), ```Dan Rhodes``` depicts high potential for a successful marketing campaign compared to the other youtubers. ```NoCopyrightSounds``` and ```DanTDM``` youtube channels also show a significant return on investment and satisfying channel engagement rates.


## Recommendations

1. ```Dan Rhodes``` appears to be the best youtube channel for the campaign because the channel has a higher engagement rate and it guarantees a higher return on investment compared to the other channels
2. The top 3 channels to form collaborations with are ```NoCopyrightSounds```, ```DanTDM``` and ```Dan Rhodes``` based on this analysis, because they attract the most engagement on their channels consistently.
3. ```Mister Max``` is the best YouTuber to collaborate with if we're interested in maximizing reach, but collaborating with ```DanTDM``` and ```Dan Rhodes``` may be better long-term options considering the fact that they both have large subscriber bases and are averaging significantly high number of views.


## Potential ROI

- Setting up a collaboration deal with ```Dan Rhodes``` would make the client a net profit of $1,065,000 per video
- If we go with a product placement campaign with ```DanTDM```, this could generate the client approximately $484,000 per video.
- ```NoCopyrightSounds``` could profit the client $642,000 per video.
