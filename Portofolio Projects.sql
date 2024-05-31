
--- delete all rows that has a location that's not a country

delete
from
	"PortofolioProject".owid_covid_data ocd 
where
	length(continent) = 0

--- show all country

select 
	distinct location
from
	"PortofolioProject".owid_covid_data ocd 
order by
	location
	
--- country with the highest death count

select 
	*
from 

(select
	location,
	population,
	max (total_deaths) as death_count
from
	"PortofolioProject".owid_covid_data ocd
group by
	1,2)
where death_count is not null
order by
	death_count desc
	
--- country with the highest infection rate and infection by population percentage

select
	*
from 

(select
	location,
	population, 
	max (total_cases) as highest_infection_rate,
	max (total_cases/population)*100 as infection_by_population_percentage
from
	"PortofolioProject".owid_covid_data ocd 
group by
	1,2)

where
	highest_infection_rate is not null and 
	infection_by_population_percentage is not null
order by 
	highest_infection_rate  desc

--- Total cases vs Total deaths in Indonesia

select
	location,
	date,
	total_cases,
	total_deaths,
	concat (cast((total_deaths/total_cases)*100 as numeric(10,2)), '%') as death_percentages
from
	"PortofolioProject".owid_covid_data ocd 
where
	total_cases is not null and
	total_deaths is not null and
	location = 'Indonesia'
order by
	1,2

--- death percentages in the most recent in every country
	
with CTE_A as 

(select
		location,
		max(date) as recent_date
	from
		"PortofolioProject".owid_covid_data ocd 
	group by 
		1
	order by
		1,2)

select
	distinct A.location,
	A.recent_date,
	B.total_cases,
	B.total_deaths,
	concat (cast((B.total_deaths/B.total_cases)*100 as numeric(10,2)), '%') as death_percentages
from
CTE_A A left join "PortofolioProject".owid_covid_data B on A.recent_date = B.date and A.location = B.location

order by
	1

---
	
