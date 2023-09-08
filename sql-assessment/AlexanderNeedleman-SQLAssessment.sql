create table marketing_data (
 date datetime,
 campaign_id varchar(50),
 geo varchar(50),
 cost float,
 impressions float,
 clicks float,
 conversions float
);

create table website_revenue (
 date datetime,
 campaign_id varchar(50),
 state varchar(2),
 revenue float
);

create table campaign_info (
 id int not null primary key ,
 name varchar(50),
 status varchar(50),
 last_updated_date datetime
);



-- Query One - Sum of Impressions by day
SELECT 
	sum(impressions) as "Total Impressions" 
FROM 
	marketing_data
ORDER BY 
	"Total Impressions" DESC;

-- Query Two - Top Three Revenue-Generating States
SELECT 
	state, 
	sum(revenue) as "Revenue by State" 

FROM
	website_revenue
GROUP BY 
	state	
ORDER BY 
	'Revenue by State' desc;


-- Query Three - Campaign Metrics
SELECT 
	name as 'Campaign Name', 
	sum(cost) as 'Campaign Cost', 
	sum(impressions) as 'Total Impressions', 
	sum(clicks) as 'Total Clicks', 
	sum(revenue) as 'Total Revenue'
FROM 
	marketing_data m
JOIN 
	campaign_info c on c.id = m.campaign_id
JOIN 
	website_revenue w on w.campaign_id = m.campaign_id
GROUP BY 
	c.name;


-- Query Four - Campaign5 Conversions
SELECT
	RIGHT(geo, 3)  as "State",
	sum(conversions) as 'Total Conversions'
FROM 
	marketing_data m
JOIN
	campaign_info c on c.id = m.campaign_id
WHERE
	c.name = 'Campaign5'
GROUP BY 
	geo;

-- Query Five - Campaign Efficiency
SELECT 
	name as 'Campaign Name', 
	sum(revenue) as 'Total Revenue', 
	sum(conversions) as 'Total Conversions',
	sum(cost) as 'Total Cost', 
	ROUND(sum(conversions)/sum(cost), 2) as 'Conversions Per Dollar Spent', 
	ROUND(sum(revenue)/sum(cost), 2) as 'Revenue Amount Per Dollar Spent'
FROM 
	marketing_data m
JOIN
	campaign_info c ON c.id = m.campaign_id
JOIN
	website_revenue w ON w.campaign_id = m.campaign_id
GROUP BY
	name
ORDER BY
	'Total Cost' ASC;

-- Answer: It would appear that while Campaign3 produced the more website revenue, Campaign4 had the most conversions per dollar spent and still earned the most revenue dollars per dollar spent.



-- Bonus Query - Best Ad Day
SELECT
	WEEKDAY(date) as 'Day of the Week',
	sum(impressions) as 'Total Impressions',
	sum(cost) as 'Total Cost'
FROM
	marketing_data
GROUP BY
	WEEKDAY(DATE)
ORDER BY
	WEEKDAY(DATE)