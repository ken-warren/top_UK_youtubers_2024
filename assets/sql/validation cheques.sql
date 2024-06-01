/*

VALIDATION CHECKS

1. Define the variables
2. Create a CTE that rounds the avg views per video
3. Select the columns that are appropiate for the analysis
4. Filter results by YT channels with the highest subscriber bases
5. Order by net profit (from highest to lowest)

*/


---1.
DECLARE @conversionRate FLOAT = 0.02;		--- conversion rate at 2%
DECLARE @productCost MONEY = 5.0;		--- production cost at $5
DECLARE @campaignCost MONEY = 50000.0;	--- campaign cost at $50,000


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


---3.
SELECT
		channel_name,
		rounded_avg_views_per_video,
		(rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
		(rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
		(rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost AS net_profit

	 FROM channelData


---4.
WHERE
	channel_name IN ('NoCopyrightSounds', 'DanTDM', 'Dan Rhodes')


---5.
ORDER BY
	net_profit DESC