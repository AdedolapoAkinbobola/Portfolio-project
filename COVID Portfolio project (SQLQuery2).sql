/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [iso_code]
      ,[continent]
      ,[location]
      ,[date]
      ,[total_cases]
      ,[new_cases]
      ,[new_cases_smoothed]
      ,[total_deaths]
      ,[new_deaths]
      ,[new_deaths_smoothed]
      ,[total_cases_per_million]
      ,[new_cases_per_million]
      ,[new_cases_smoothed_per_million]
      ,[total_deaths_per_million]
      ,[new_deaths_per_million]
      ,[new_deaths_smoothed_per_million]
      ,[reproduction_rate]
      ,[icu_patients]
      ,[icu_patients_per_million]
      ,[hosp_patients]
      ,[hosp_patients_per_million]
      ,[weekly_icu_admissions]
      ,[weekly_icu_admissions_per_million]
      ,[weekly_hosp_admissions]
      ,[weekly_hosp_admissions_per_million]
      ,[new_tests]
      ,[total_tests]
      ,[total_tests_per_thousand]
      ,[new_tests_per_thousand]
      ,[new_tests_smoothed]
      ,[new_tests_smoothed_per_thousand]
      ,[positive_rate]
      ,[tests_per_case]
      ,[tests_units]
      ,[total_vaccinations]
      ,[people_vaccinated]
      ,[people_fully_vaccinated]
      ,[new_vaccinations]
      ,[new_vaccinations_smoothed]
      ,[total_vaccinations_per_hundred]
      ,[people_vaccinated_per_hundred]
      ,[people_fully_vaccinated_per_hundred]
      ,[new_vaccinations_smoothed_per_million]
      ,[stringency_index]
      ,[population]
      ,[population_density]
      ,[median_age]
      ,[aged_65_older]
      ,[aged_70_older]
      ,[gdp_per_capita]
      ,[extreme_poverty]
      ,[cardiovasc_death_rate]
      ,[diabetes_prevalence]
      ,[female_smokers]
      ,[male_smokers]
      ,[handwashing_facilities]
      ,[hospital_beds_per_thousand]
      ,[life_expectancy]
      ,[human_development_index]
  FROM [portofolio project].[dbo].[CovidDeaths$]

  SELECT count (*)
  FROM [portofolio project].[dbo].CovidVaccinations

  SELECT count(*)
  FROM [portofolio project].[dbo].CovidDeaths
 
 SELECT *
 FROM [portofolio project]..CovidDeaths
 order by 3,4

 SELECT *
 FROM [portofolio project]..CovidDeaths
 Where continent is not null
 order by 3,4

 SELECT *
 FROM [portofolio project]..CovidVaccinations
 order by 3,4

 Select location, date, total_cases, new_cases, total_deaths, population
 FROM [portofolio project]..CovidDeaths
 order by 1,2

 ----Total Cases vs Total Death
 ----Shows Likelihood of dying if you contract covid in United Kingdom and Germany
 Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 FROM [portofolio project]..CovidDeaths
 order by 1,2

 Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 FROM [portofolio project]..CovidDeaths
 Where location like '%United Kingdom%'
 order by 1,2

 Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 FROM [portofolio project]..CovidDeaths
 Where location like '%Germany%'
 order by 1,2

 -----Total Cases vs Population
 -----Shows what percentage of population got Covid

 Select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
 FROM [portofolio project]..CovidDeaths
 Where location like '%United Kingdom%'
 order by 1,2

 Select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
 FROM [portofolio project]..CovidDeaths
 Where location like '%Germany%'
 order by 1,2

 ---Countries with Highest infection rate compared to population

 Select location,population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
 FROM [portofolio project]..CovidDeaths
 -----Where location like '%States%'
 Group by Location,population
 order by 1,2

 Select location,population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
 FROM [portofolio project]..CovidDeaths
 -----Where location like '%States%'
 Group by Location,population
 order by PercentPopulationInfected desc


 -----Showing Countries with Highest Death Count per Population

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
 FROM [portofolio project]..CovidDeaths
 -----Where location like '%States%'
 Group by Location
 order by TotalDeathCount desc

 Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
 FROM [portofolio project]..CovidDeaths
 -----Where location like '%States%'
 Where continent is not null
 Group by Location
 order by TotalDeathCount desc

 ----- Continent
 Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
 FROM [portofolio project]..CovidDeaths
 -----Where location like '%States%'
 Where continent is not null
 Group by continent
 order by TotalDeathCount desc

 Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
 FROM [portofolio project]..CovidDeaths
 -----Where location like '%States%'
 Where continent is not null
 Group by location
 order by TotalDeathCount desc

 ----Global Numbers

 Select date,SUM(new_cases)
 FROM [portofolio project]..CovidDeaths
 Where continent is not null
 Group by date
 order by 1,2

 Select date,SUM(new_cases) as total_cases, SUM (cast(new_deaths as int)) as total_deaths, SUM (cast(New_deaths as int))/SUM (New_Cases)*100 as DeathPercentage
 FROM [portofolio project]..CovidDeaths
 Where continent is not null
 Group by date
 order by 1,2

 Select SUM(new_cases) as total_cases, SUM (cast(new_deaths as int)) as total_deaths, SUM (cast(New_deaths as int))/SUM (New_Cases)*100 as DeathPercentage
 FROM [portofolio project]..CovidDeaths
 Where continent is not null
 order by 1,2

 ----- Total Population Vs Vaccinations

 Select *
 From [portofolio project]..CovidDeaths D
 Join [portofolio project]..CovidVaccinations V
 on D.location = V.location
 and D.date = V.date

  Select D.continent,D.location, D.date, D.population, V.new_vaccinations
 From [portofolio project]..CovidDeaths D
 Join [portofolio project]..CovidVaccinations V
 on D.location = V.location
 and D.date = V.date
 Where D.continent is not null
 order by 1,2,3

 Select D.continent,D.location, D.date, D.population, V.new_vaccinations
 From [portofolio project]..CovidDeaths D
 Join [portofolio project]..CovidVaccinations V
 on D.location = V.location
 and D.date = V.date
 Where D.continent is not null
 order by 2,3

 Select D.continent,D.location, D.date, D.population, V.new_vaccinations, SUM(Cast(V.new_vaccinations as int)) OVER (Partition by D.Location)
 From [portofolio project]..CovidDeaths D
 Join [portofolio project]..CovidVaccinations V
 on D.location = V.location
 and D.date = V.date
 Where D.continent is not null
 order by 2,3

  Select D.continent,D.location, D.date, D.population, V.new_vaccinations, SUM(CONVERT(int, V.new_vaccinations)) OVER (Partition by D.Location)
 From [portofolio project]..CovidDeaths D
 Join [portofolio project]..CovidVaccinations V
 on D.location = V.location
 and D.date = V.date
 Where D.continent is not null
 order by 2,3

 Select D.continent,D.location, D.date, D.population, V.new_vaccinations, SUM(CONVERT(int, V.new_vaccinations)) OVER (Partition by D.Location Order by D.Location, D.Date) as RollingPeopleVaccinated
 From [portofolio project]..CovidDeaths D
 Join [portofolio project]..CovidVaccinations V
 on D.location = V.location
 and D.date = V.date
 Where D.continent is not null
 order by 2,3

 ------USE CTE

With PopvsV (Continent, Location, Date, Population, new_Vaccinations, RollingPeopleVaccinated)
as
(
 Select D.continent,D.location, D.date, D.population, V.new_vaccinations, SUM(CONVERT(int, V.new_vaccinations)) OVER (Partition by D.Location Order by D.Location, D.Date) as RollingPeopleVaccinated
 From [portofolio project]..CovidDeaths D
 Join [portofolio project]..CovidVaccinations V
 on D.location = V.location
 and D.date = V.date
 Where D.continent is not null
 )
 select *, (RollingPeopleVaccinated/Population)*100
 From PopvsV

 ----- TEMP Table

 Create Table #PercentPopulationVaccinated
 (
 Continent nvarchar(255),
 Location nvarchar (255),
 Date datetime,
 Population numeric,
 New_vaccinations numeric,
 RollingPeopleVaccinated numeric
 )

 Insert into #PercentPopulationVaccinated
 Select D.continent,D.location, D.date, D.population, V.new_vaccinations, SUM(CONVERT(int, V.new_vaccinations)) OVER (Partition by D.Location Order by D.Location, D.Date) as RollingPeopleVaccinated
 From [portofolio project]..CovidDeaths D
 Join [portofolio project]..CovidVaccinations V
 on D.location = V.location
 and D.date = V.date
 Where D.continent is not null

 select *, (RollingPeopleVaccinated/Population)*100
 From #PercentPopulationVaccinated

 DROP Table if exists #PercentPopulationVaccinated
  Create Table #PercentPopulationVaccinated
 (
 Continent nvarchar(255),
 Location nvarchar (255),
 Date datetime,
 Population numeric,
 New_vaccinations numeric,
 RollingPeopleVaccinated numeric
 )

 Insert into #PercentPopulationVaccinated
 Select D.continent,D.location, D.date, D.population, V.new_vaccinations, SUM(CONVERT(int, V.new_vaccinations)) OVER (Partition by D.Location Order by D.Location, D.Date) as RollingPeopleVaccinated
 From [portofolio project]..CovidDeaths D
 Join [portofolio project]..CovidVaccinations V
 on D.location = V.location
 and D.date = V.date

 select *, (RollingPeopleVaccinated/Population)*100
 From #PercentPopulationVaccinated


 ----- Creating view

 Create View PercentPopulationVaccinated as
 Select D.continent,D.location, D.date, D.population, V.new_vaccinations, SUM(CONVERT(int, V.new_vaccinations)) OVER (Partition by D.Location Order by D.Location, D.Date) as RollingPeopleVaccinated
 From [portofolio project]..CovidDeaths D
 Join [portofolio project]..CovidVaccinations V
 on D.location = V.location
 and D.date = V.date
 where D.continent is not null

 Select *
 From PercentPopulationVaccinated

 
 
















