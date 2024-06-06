# Analysis of Top 100 UK Youtubers

![Top_UK_youtubers](https://github.com/ken-warren/top_UK_youtubers_2024/assets/134076996/4b27a4cb-c069-47e0-8a3b-9bf2c7f293ac)
---
## Table of Contents

- [Overview](#overview)
- [Objectives](#objectives)
- [Statement of Problem](#statement-of-problem)
- [Data Source](#data-source)
- [Tools](#Tools)
- [SQL Data Analysis](#sql-data-analysis)
- [Power BI Report](#power-bi-report)
- [Visualization](#visualization)
- [Findings](#findings)
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
1. [Excel](https://www.microsoft.com/en-us/microsoft-365/excel) - For exploring and viewing the dataset.
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

![import_dataset](https://github.com/ken-warren/top_UK_youtubers_2024/assets/134076996/fb6a5fb7-5b29-40c1-b1e3-d95fd2afb6e6)


Expand on the created database, and you'll see the imported dataset. Right click on it and select top 1000 rows to view the dataset.

![Load_data](https://github.com/ken-warren/top_UK_youtubers_2024/assets/134076996/b2f1ed76-61c9-421a-9e59-4a1af32c0d5a)


The dataset should appear as shown below.

![loaded_db_table](https://github.com/ken-warren/top_UK_youtubers_2024/assets/134076996/24fba6cb-75dc-457e-868d-7250469e72c9)

---

Now, let's carry on with the data cleaning;

### 1. Remove unnecessary columns/select needed columns only

```sql
SELECT 
	NOMBRE,
	total_subscribers,
	total_views,
	total_videos
FROM
  top_uk_youtubers_2024
```

### 2. Extract youtube channel names from 1st column

```sql
SELECT
  CHARINDEX ('@', NOMBRE), NOMBRE
FROM
  top_uk_youtubers_2024
```

### 3. Rename the column names and create a new view

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

![view_cleaned](https://github.com/ken-warren/top_UK_youtubers_2024/assets/134076996/bd06933b-5df7-4607-a26e-be21859e83e9)

The output should show this.

![loaded_view_cleaned](https://github.com/ken-warren/top_UK_youtubers_2024/assets/134076996/dd8f0e65-4aed-48ef-9f68-67e08a08e5de)


## Data Quality Checks

This will include;
- Checking row and column counts
- Assessing the data types
- Checking for any duplicates

### 1. Row and column counts check

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

### 2. Assessing the Data Type

```sql
SELECT
	COLUMN_NAME,
	DATA_TYPE
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME = 'view_uk_youtubers_2024'
```

### 3. Checking for any duplicates

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
The expected results are highlighted in the tables below.

| Variable   | count |
|------------|-------|
|no_of_rows  | 100   |
|column_count|   4   |
|duplicate_counts|(blank) *meaning no duplicates|

| Variable   |data type|
|------------|---------|
|channel_name| VARCHAR |
|total_subscribers|INT |
|total_videos|     INT |
|total_views |  BIGINT |


## Power BI Report

Load the cleaned dataset from the SQL Server into Power BI using the following steps;

1. Open blank report. From the **Home** tab, select **Get data**, then **SQL Server**.

![import_SQL_server](https://github.com/ken-warren/top_UK_youtubers_2024/assets/134076996/ab32fe89-3a2c-47b3-9ff7-c30eb33fe9a3)


2. Type in your Server name, database name and select **OK**.

![Server_name](https://github.com/ken-warren/top_UK_youtubers_2024/assets/134076996/a0ea1acc-9d4f-459f-9a9d-7fdd8efe1842)


3. Select and load the cleaned dataset.

![load_powerbi](https://github.com/ken-warren/top_UK_youtubers_2024/assets/134076996/c3cd7141-03a4-4bac-9d19-6a407818e745)


The DAX formulae used are;

### 1. Total subscribers

```dax
Total Subscribers (M) = 
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers_2024[total_subscribers])
VAR TotalSubscribers = DIVIDE(sumOfTotalSubscribers, 1000000)
RETURN(TotalSubscribers)
```

### 2. Total videos

```dax
Total Videos = 
VAR TotalVideos = SUM(view_uk_youtubers_2024[total_videos])
RETURN(TotalVideos)
```

### 3. Total views

```dax
Total Views (B) = 
VAR billion = 1000000000
VAR sumOfTotalViews = SUM(view_uk_youtubers_2024[total_views])
VAR TotalViews = DIVIDE(sumOfTotalViews,billion)
RETURN(TotalViews)
```

### 4. Average views per video

```dax
Avg Views per Video (M) = 
VAR sumOfTotalViews = SUM(view_uk_youtubers_2024[total_views])
VAR sumOfTotalVideos = SUM(view_uk_youtubers_2024[total_videos])
VAR avgOfViewsPerVideo = DIVIDE(sumOfTotalViews, sumOfTotalVideos, BLANK())
VAR finalAvgOfViewsPerVideo = DIVIDE(avgOfViewsPerVideo, 1000000, BLANK())
RETURN(finalAvgOfViewsPerVideo)
```

### 5. Views per subscribers

```dax
Views per Subscriber = 
VAR sumOfTotaViews = SUM(view_uk_youtubers_2024[total_views])
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers_2024[total_subscribers]) 
VAR ViewsPerSubscriber = DIVIDE(sumOfTotaViews, sumOfTotalSubscribers, BLANK())
RETURN(ViewsPerSubscriber)
```

## Visualization

## Power BI Report on Top 100 UK Youtubers

![Top_UK_youtubers](https://github.com/ken-warren/top_UK_youtubers_2024/assets/134076996/6dc99b77-dd4d-4dd6-b376-8f8d7ec6bbb8)

You can access the interactive Power BI report [here](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/powerBI/Top_UK_youtubers.pbix)

## Findings

### 1. Who are the top 10 YouTubers with the most subscribers?

| Rank | Channel Name         | Subscribers (M) |
|------|----------------------|-----------------|
| 1    | NoCopyrightSounds    | 33.60           |
| 2    | DanTDM               | 28.60           |
| 3    | Dan Rhodes           | 26.50           |
| 4    | Miss Katy            | 24.50           |
| 5    | Mister Max           | 24.40           |
| 6    | KSI                  | 24.10           |
| 7    | Jelly                | 23.50           |
| 8    | Dua Lipa             | 23.30           |
| 9    | Sidemen              | 21.00           |
| 10   | Ali-A                | 18.90           |


### 2. Which 3 channels have uploaded the most videos?

| Rank | Channel Name    | Videos Uploaded |
|------|-----------------|-----------------|
| 1    | GRM Daily       | 14,696          |
| 2    | Manchester City | 8,248           |
| 3    | Yogscast        | 6,435           |



### 3. Which 3 channels have the most views?


| Rank | Channel Name | Total Views (B) |
|------|--------------|-----------------|
| 1    | DanTDM       | 19.78           |
| 2    | Dan Rhodes   | 18.56           |
| 3    | Mister Max   | 15.97           |


### 4. Which 3 channels have the highest average views per video?

| Channel Name | Averge Views per Video (M) |
|--------------|-----------------|
| Mark Ronson  | 32.27           |
| Jessie J     | 5.97            |
| Dua Lipa     | 5.76            |


### 5. Which 3 channels have the highest views per subscriber ratio?

| Rank | Channel Name       | Views per Subscriber        |
|------|-----------------   |---------------------------- |
| 1    | GRM Daily          | 1185.79                     |
| 2    | Nickelodeon        | 1061.04                     |
| 3    | Disney Junior UK   | 1031.97                     |



### 6. Which 3 channels have the highest subscriber engagement rate per video uploaded?

| Rank | Channel Name    | Subscriber Engagement Rate  |
|------|-----------------|---------------------------- |
| 1    | Mark Ronson     | 343,000                     |
| 2    | Jessie J        | 110,416.67                  |
| 3    | Dua Lipa        | 104,954.95                  |


For the next phase (Validation),the variables channel_name,total_videos and total_videos will be used in Total Subscribers Analysis to assess the ROI. The following scenario will be used;

|    Scenario    |  value |
|----------------|--------|
|campaigns budget|$ 50,000|
|cost per product| $ 5    |
|conversion rate |  0.02  |


## Validation

### Total Subscribers Analysis

Here we view the difference in subscribers metrics between Excel and SQL.

The [SQL codes](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/sql/validation%20cheques.sql) used to generate these values are;

```sql
DECLARE @conversionRate FLOAT = 0.02;		--- conversion rate at 2%
DECLARE @productCost MONEY = 5.0;		--- production cost at $5
DECLARE @campaignCost MONEY = 50000.0;	        --- campaign cost at $50,000
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

The Excel worksheet below shows the subscribers comparison metrics between SQL and Excel for the top 3 YouTube channels and the findings on:
- Average views per video
- Potential product sales
- Potential revenue
- Potential Net Profit


![TotalSubAnalysis](https://github.com/ken-warren/top_UK_youtubers_2024/assets/134076996/fd5d394c-675e-4165-a6e1-ff6472a9d1f1)


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
