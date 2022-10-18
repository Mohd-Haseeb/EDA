select * from `Portfolio-Project`.covid_deaths
where continent is not null
limit 10;

-- get column names
SELECT `COLUMN_NAME` 
FROM `INFORMATION_SCHEMA`.`COLUMNS` 
WHERE `TABLE_SCHEMA`='Portfolio-Project' 
    AND `TABLE_NAME`='covid_deaths';
    

-- Deaths by country
select location, sum(total_deaths) from `Portfolio-Project`.covid_deaths
group by location
order by sum(total_deaths) desc;

-- Looking at Total Cases VS Total Deaths
	-- shows likelihood of dying if you have covid in a country
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage from
`Portfolio-Project`.covid_deaths
where location = 'India'
order by `date` desc;

-- Looking at Total Cases VS Population

select location, date, total_cases, population, (total_cases/population)*100 as PopulationAffected from
`Portfolio-Project`.covid_deaths
where location = 'India'
order by PopulationAffected desc;


-- Looking at Country's Highest Infection Rate compared to Population
select location,  Max(total_cases) HighestInfectionCount, population, Max((total_cases/population))*100 as PercentPopulationInfected from
`Portfolio-Project`.covid_deaths
group by location, population
order by PercentPopulationInfected desc;


-- Total Death Count Per population
select location, population, Sum(total_deaths)  from
`Portfolio-Project`.covid_deaths
group by location, population
order by population desc;


-- Countries with Highest Death Count Per population
select location, Max(cast(total_deaths as unsigned)) as TotalDeathCount from
`Portfolio-Project`.covid_deaths
where location not in ('Asia', 'Africa', 'Europe', 'North America', 'South Americs', 'Oceania','World')
group by location
order by TotalDeathCount desc;

SELECT `COLUMN_NAME` ,DATA_TYPE from INFORMATION_SCHEMA. COLUMNS where table_schema = 'Portfolio-Project' and table_name = 'covid_deaths' and
`COLUMN_NAME` = 'total_deaths';

select distinct continent from `Portfolio-Project`.covid_deaths;

-- Deaths grouped by Continent
select continent, Max(cast(total_deaths as unsigned)) as TotalDeathCount from
`Portfolio-Project`.covid_deaths
where continent <> ''
group by continent
order by TotalDeathCount desc;

-- Continents with HIghest Death Count
select location, Max(cast(total_deaths as unsigned)) as TotalDeathCount from
`Portfolio-Project`.covid_deaths
where continent = ''
group by location
order by TotalDeathCount desc;


-- GLOBAL NUMBERS

select date, Sum(new_cases) total_cases, Sum(Cast(new_deaths as unsigned)) total_deaths, (Sum(Cast(new_deaths as unsigned))/ Sum(new_cases))*100 DeathPercentage
 from `Portfolio-Project`.covid_deaths
group by date;


-- JOINING DATA
-- Total Population Vs Vaccination
select d.continent, d.location, d.date, d.population, v.new_vaccinations, 
Sum(Cast(v.new_vaccinations as unsigned)) over (partition by d.location order by d.location, d.date) as Total
from `Portfolio-Project`.covid_deaths d
join `Portfolio-Project`.covid_vaccination v
on d.location = v.location and d.date = v.date
where d.continent <> '' 
order by 1,2,3 ;


-- CREATING A VIEW

create view VaccinatedPopulationPercent as 
select d.continent, d.location, d.date, d.population, v.new_vaccinations,
Sum(cast(new_vaccinations as unsigned)) over (partition by d.location order by d.location, d.date) RollingPeoppleVaccinated
from `Portfolio-Project`.covid_deaths d
join `Portfolio-Project`.covid_vaccination v
	on d.date = v.date and d.location = v.location
where d.continent <> ''






Error Code: 1046. No database selected Select the default DB to be used by double-clicking its name in the SCHEMAS list in the sidebar.





































