# Profit Behind the Views: Strategic ROI Assessment of UK YouTube Influencers 

[Article](https://ken-warren.github.io/top_UK_youtubers_2024/)

---

## Table of Contents

- [Overview](#overview)
- [Statement of Problem](#statement-of-problem)
- [Objectives](#objectives)
- [Scope of the Study](#scope-of-the-study)
- [Limitations and Gaps](limitations-and-gaps)
- [Data Source](#data-source)
- [Tools](#Tools)
- [Methodology](#methodology)
- [SQL Data Analysis](#sql-data-analysis)
- [Findings](#findings)
- [Validation](#validation)
- [Conclusion](#conclusion)
- [Recommendations](#recommendations)


## Overview

This report presents a comparative analysis of the potential return on investment (ROI) for a product-based influencer marketing campaign targeting Top 100 UK-based YouTube creators. Using SQL for modeling and Excel for cross-validation, the study calculates the financial impact of collaborating with three prominent YouTubers: Dan Rhodes, NoCopyrightSounds, and DanTDM.

The findings identify Dan Rhodes as the most commercially viable partner, with a projected net profit of $1.065 million per campaign video, driven by exceptionally high average viewership and strong engagement. The report also highlights the profitability of the other two channels and provides a data-informed foundation for campaign planning and influencer selection.
 

## Statement of Problem

In influencer marketing, allocating resources to the wrong creator can lead to poor engagement, low conversions, and a negative ROI. With YouTube offering a diverse pool of high-profile content creators, the key challenge is identifying which influencer delivers the greatest commercial return based on audience engagement, conversion potential, and cost-effectiveness.

This research addresses the problem of optimizing influencer selection by quantifying and comparing the financial viability of partnering with top UK-based YouTube channels, using data-driven metrics.
 

## Objectives

The goal of this study is not merely to model influencer metrics but to generate outputs that directly answer the research problem. By calculating and comparing average views, projected conversions, revenue potential, and campaign profitability across selected influencers, the report delivers:
- Evidence-based estimates of sales impact and financial gain for each creator
- A comparative framework for prioritizing high-ROI influencer partnerships
- Validation of SQL-modeled data through Excel to ensure reliability and transparency

These outputs inform a rational, performance-driven influencer strategy, optimizing both reach and revenue.


## Scope of the Study

This analysis is confined to a campaign simulation involving three high-performing UK YouTube channels (Dan Rhodes, NoCopyrightSounds, and DanTDM) with the goal of estimating the financial impact of influencer collaborations under standardized assumptions. The scope includes:
- **Conversion Rate:** 2% of total views
- **Product Cost:** $5 per unit
- **Fixed Campaign Cost:** $50,000 per influencer per video
- **Data Tools:** SQL for simulation and Excel for cross-validation
- **Key Metrics Evaluated:** Average views per video, estimated product conversions, revenue projections, and net profit


## Limitations and Gaps
While the analysis offers quantitative clarity, it does not account for several important contextual variables, including:
- Audience demographics (e.g., age, location, language)
- Content-type alignment (e.g., creator niche vs. product relevance)
- Brand sentiment or reputation risk
- Engagement quality (e.g., comments, likes, shares vs. views alone)
- Platform algorithm changes or volatility

Furthermore, the analysis is time-bound to the most recent available data snapshot from the youtube_db.dbo.view_uk_youtubers_2024 dataset. This reflects aggregated performance as of early 2024 and does not account for seasonal trends, recent subscriber surges, or campaign timing (e.g., Q4 holiday periods or trending content cycles).


## Data Source

The data on top 100 U.K Youtubers contrywise is available on [Kaggle](https://www.kaggle.com/datasets/bhavyadhingra00020/top-100-social-media-influencers-2024-countrywise). Since the data is in a different language, you can download the Python-translated dataset that gets the total subscribers, total videos and total views [here](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/datasets/youtube_data_from_python.csv).


## Tools
1. [Excel](https://www.microsoft.com/en-us/microsoft-365/excel) - For exploring and viewing the dataset.
2. [SQL](https://aka.ms/ssmsfullsetup) - For data manipulation and cleaning
3. [Power BI](https://aka.ms/pbidesktopstore) - For vusualizing the top 100 UK Youtubers

---

## Methodology

## 1. SQL Modeling
The SQL query used to derive the core financial metrics is publicly available [here](https://github.com/ken-warren/top_UK_youtubers_2024/blob/main/assets/sql). Key features of the query include:

```sql
Copy
Edit
DECLARE @conversionRate FLOAT = 0.02;
DECLARE @productCost MONEY = 5.0;
DECLARE @campaignCost MONEY = 50000.0;

WITH channelData AS (
  SELECT 
    channel_name,
    total_views,
    total_videos,
    ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
  FROM youtube_db.dbo.view_uk_youtubers_2024
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
ORDER BY net_profit DESC;
```

This logic estimates the sales volume, revenue, and net profit by multiplying average views by the assumed conversion rate and product cost, then subtracting the campaign expense.

## 2. Excel Validation
A parallel analysis was conducted in Excel using the TotalSubAnalysis worksheet. Metrics from SQL and Excel were reconciled to ensure internal consistency and accuracy.

## SQL Data Analysis
## Data Cleaning

Data cleaning steps;
1. Removing unnecessary columns/select needed columns only
2. Extracting of youtube channel names from 1st column
3. Renaming of the column names


## Data Quality Checks

This includes;
- Checking row and column counts
- Assessing the data types
- Checking for any duplicates

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


For the next phase (**Validation**),the variables channel_name, total_videos and total_views were used in Total Subscribers Analysis to assess the ROI. The following scenarios were exemplified;

|Scenario|value|
|---|---|
|campaigns budget|$ 50,000|
|cost per product|$ 5|
|conversion rate|0.02|


## Validation

### Total Subscribers Analysis

Here, the difference in subscribers metrics between Excel and SQL was assessed.

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
