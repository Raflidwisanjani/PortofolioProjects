
--- daily total sessions, average bounce rate, and total unique visitor in Q4 2018
select 
	to_date("date",'YYYY-MM-DD') as date,
	sum ("Sessions") as Total_Sessions,
	avg ("Bounce Rate") as Average_Bounce_Rate,
	sum ("# of Visitors") as Total_Visitors
from
	(select
		"Sessions",
		"Bounce Rate",
		"# of Visitors",
		substring("Date",1,10) as date
	from
		"PortofolioProject".lacity_org_website_traffic lowt)
where 
	date >= '2018-10-01' and date <= '2018-12-31'
group by 1
order by date asc

--- daily total sesions, average bounce rate, and total unique visitor in Q3 2018 (for comparison)

select 
	to_date("date",'YYYY-MM-DD') as date,
	sum ("Sessions") as Total_Sessions,
	avg ("Bounce Rate") as Average_Bounce_Rate,
	sum ("# of Visitors") as Total_Visitors
from
	(select
		"Sessions",
		"Bounce Rate",
		"# of Visitors",
		substring("Date",1,10) as date
	from
		"PortofolioProject".lacity_org_website_traffic lowt)
where 
	date >= '2018-07-01' and date <= '2018-09-30'
group by 1
order by date asc

--- total sessions, average bounce rate, and total unique visitor in Q4 2018
select 
	sum(Total_Sessions) as Total_Sessions_Q4_2018,
	sum(Total_Visitors) as Total_Visitors_Q4_2018,
	avg(Average_Bounce_Rate) as Bounce_Rate_Q4_2018
from
(select 
	to_date("date",'YYYY-MM-DD') as date,
	sum ("Sessions") as Total_Sessions,
	avg ("Bounce Rate") as Average_Bounce_Rate,
	sum ("# of Visitors") as Total_Visitors
from
	(select
		"Sessions",
		"Bounce Rate",
		"# of Visitors",
		substring("Date",1,10) as date
	from
		"PortofolioProject".lacity_org_website_traffic lowt)
where 
	date >= '2018-10-01' and date <= '2018-12-31'
group by 1
order by date asc)

--- total sessions, average bounce rate, and total unique visitor in Q3 2018 (for comparison)
select 
	sum(Total_Sessions) as Total_Sessions_Q4_2018,
	sum(Total_Visitors) as Total_Visitors_Q4_2018,
	avg(Average_Bounce_Rate) as Bounce_Rate_Q4_2018
from
(select 
	to_date("date",'YYYY-MM-DD') as date,
	sum ("Sessions") as Total_Sessions,
	avg ("Bounce Rate") as Average_Bounce_Rate,
	sum ("# of Visitors") as Total_Visitors
from
	(select
		"Sessions",
		"Bounce Rate",
		"# of Visitors",
		substring("Date",1,10) as date
	from
		"PortofolioProject".lacity_org_website_traffic lowt)
where 
	date >= '2018-07-01' and date <= '2018-09-30'
group by 1
order by date asc)

--- total sessions, average bounce rate, and total unique visitor per device category in Q4 2018
select 
	"Device Category",
	sum("Sessions") as Total_Sessions,
	sum("# of Visitors") as Total_Visitors,
	avg("Bounce Rate") as Bounce_Rate
from
(select 
	to_date("date",'YYYY-MM-DD') as date,
	"Device Category",
	"Sessions",
	"Bounce Rate",
	"# of Visitors"
from
	(select
		"Device Category",
		"Sessions",
		"Bounce Rate",
		"# of Visitors",
		substring("Date",1,10) as date
	from
		"PortofolioProject".lacity_org_website_traffic lowt)
where 
	date >= '2018-10-01' and date <= '2018-12-31'
order by date asc)
group by 1
