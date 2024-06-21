	
--- Change date column to date format

alter table "PortofolioProject".covid 
alter column "Date" type DATE
using to_date("Date", 'MM/DD/YYYY')

--- Select All columns

select
	*
from
	"PortofolioProject".covid c
order by
	"Date" asc

--- total cases
	
select 
	"Location",
	Total_kasus,
	Total_kematian,
	concat (((cast ((Total_kematian / Total_kasus) as numeric (10,4)))*100),'%') as persentase_kematian
from
(select
	"Location",
	cast ((max ("Total Cases")) as decimal (10,3)) as Total_kasus,
	cast ((max ("Total Deaths")) as decimal (10,3)) as Total_kematian
from
	"PortofolioProject".covid c 
group by
	1
order by 
	1 asc)
group by 1,2,3
order by 1

--- top 5 highest cases

select
	"Location",
	max("Total Cases") as "Max Total Cases"
from
	"PortofolioProject".covid c 
where 
	"Location" <> 'Indonesia'
group by
	1
order by
	2 desc
limit 5

--- total cases, death count, and death percentage

select 
	"Total Cases in Indonesia",
	"Total Deaths in Indonesia",
	cast(("Total Deaths in Indonesia"/"Total Cases in Indonesia")*100 as numeric (10,4)) as "Death Percentage"

from
(select 
	cast ((sum ("Max Total Cases")) as decimal (10,3)) as "Total Cases in Indonesia",
	cast ((sum ("Death Count")) as decimal (10,3)) as "Total Deaths in Indonesia"
from
(
select
	"Location",
	max("Total Cases") as "Max Total Cases",
	max ("Total Deaths") as "Death Count"
from
	"PortofolioProject".covid c 
where 
	"Location" <> 'Indonesia'
group by
	1
))

group by
	1,2
	
--- daily cases and daily recovered
	
select 
	"Date",
	sum ("New Cases") as "Daily Cases in Indonesia",
	sum ("New Recovered") as "Daily Recovered in Indonesia"
from
	"PortofolioProject".covid c 
group by
	1
order by 
	1 asc

	
