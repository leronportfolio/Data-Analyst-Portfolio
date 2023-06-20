--SELECT *
--FROM PortfolioProject..CovidDeaths
--ORDER by 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccination
--ORDER by 3,4

--Select Data that we are going to be using

--set as float for numbers to be calculated
update CovidDeaths
    set population = try_convert(float, population);

update CovidDeaths
    set total_cases = try_convert(float, total_cases);

alter table CovidDeaths alter column total_cases float;

alter table CovidDeaths alter column population float;

update CovidVaccination
    set population = try_convert(float, population);

update CovidVaccination
    set total_cases = try_convert(float, total_cases);

update CovidVaccination
    set total_deaths = try_convert(float, total_deaths);

alter table CovidVaccination alter column total_cases float;

alter table CovidVaccination alter column population float;

alter table CovidVaccination alter column total_deaths float;


SELECT location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
ORDER BY 1,2

-- Looking at total_cases vs total_deaths
--Shows likelihood of dying if contracted Covid-19 based on country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2

--Shows what percentage of population has gotten Covid
SELECT location, date, population, total_cases, (total_cases/population)*100 as PerentagePopInfected
From PortfolioProject..CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2

--Looking at Countries with Highest Infection Rate compared to Population
SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100.0 as PercentPopInfected
From PortfolioProject..CovidDeaths
--WHERE location like '%states%'
Group by location, population
ORDER BY PercentPopInfected desc

--Showing countries with the highest death count per population
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
Group by location
ORDER BY TotalDeathCount desc

--Lets break things down by continent
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
Group by continent
ORDER BY TotalDeathCount desc

SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
Group by location
ORDER BY TotalDeathCount desc

SELECT *
From PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 3,4

--Showing continents with the highest death count per population

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
Group by continent
ORDER BY TotalDeathCount desc

--Global Numbers

update CovidVaccination
    set new_cases = try_convert(float, new_cases);

alter table CovidVaccination alter column new_cases float;

update CovidVaccination
    set new_deaths = try_convert(float, new_deaths);

alter table CovidVaccination alter column new_deaths float;

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
--total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidVaccination
--WHERE location like '%states%'
WHERE continent is not null
--Group By date
ORDER BY 1,2

--Looking at total population vs vaccinations
SELECT * 
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int, vac.new_vaccinations)) OVER (Partition by dea.location)
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location)
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
AND vac.new_vaccinations is not null
ORDER BY 2,3

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location)
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
AND vac.new_vaccinations is not null
ORDER BY 2,3

--USE CTE to perform calculations on partition by in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

--TEMP Table

DROP TABLE if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

SELECT*
FROM PercentPopulationVaccinated

--Showing countries with the highest death count per population
Create View CountriesHighestDeathCount as
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
Group by location
--ORDER BY TotalDeathCount desc

--Lets break things down by continent
Create View ContinentsHighestDeathCount as
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
Group by continent
--ORDER BY TotalDeathCount desc
