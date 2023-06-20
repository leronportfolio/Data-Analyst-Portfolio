# Data-Analyst-Portfolio

Welcome to my Data Analyst Portfolio! This repository contains a collection of SQL queries and analyses related to COVID-19 data. I have utilized SQL to extract insights and visualize various aspects of the pandemic, including infection rates, death rates, vaccination progress, and more.

## Table of Contents

1. [Data Analysis](#data-analysis)
   - [Total Cases and Deaths by Country](#total-cases-and-deaths-by-country)
   - [Likelihood of Death if Contracting COVID-19](#likelihood-of-death-if-contracting-covid-19)
   - [Percentage of Population Infected](#percentage-of-population-infected)
   - [Countries with Highest Infection Rate](#countries-with-highest-infection-rate)
   - [Countries with Highest Death Count](#countries-with-highest-death-count)
   - [Death Count by Continent](#death-count-by-continent)
   - [Continents with Highest Death Count](#continents-with-highest-death-count)
   - [Global COVID-19 Statistics](#global-covid-19-statistics)
   - [Population vs. Vaccinations](#population-vs-vaccinations)

2. [Views](#views)
   - [PercentPopulationVaccinated](#percentpopulationvaccinated)
   - [CountriesHighestDeathCount](#countrieshighestdeathcount)
   - [ContinentsHighestDeathCount](#continentshighestdeathcount)

## Data Analysis

### Total Cases and Deaths by Country
- The query provides the total cases, total deaths, and death percentage for each country.
- It helps identify the likelihood of dying if contracting COVID-19 based on the country.

### Likelihood of Death if Contracting COVID-19
- This query focuses on countries with "states" in their names.
- It calculates the death percentage based on the total cases and total deaths.
- The results show the likelihood of death if contracting COVID-19 in each country.

### Percentage of Population Infected
- This query calculates the percentage of the population that has contracted COVID-19 in countries with "states" in their names.
- It provides insights into the extent of infection within the population.

### Countries with Highest Infection Rate
- The query identifies countries with the highest infection rates compared to their populations.
- It calculates the highest infection count and the percentage of the population infected in each country.

### Countries with Highest Death Count
- This query determines the countries with the highest death count per population.
- It helps understand the severity of the pandemic in different countries.

### Death Count by Continent
- The query presents the total death count for each country grouped by continent.
- It offers insights into the impact of COVID-19 on different continents.

### Continents with Highest Death Count
- This query highlights continents with the highest death count.
- It provides a broader view of the pandemic's impact at a continental level.

### Global COVID-19 Statistics
- The query calculates global COVID-19 statistics, including the total cases, total deaths, and death percentage.
- It provides an overview of the pandemic's global impact.

### Population vs. Vaccinations
- This query analyzes the relationship between the population and the number of vaccinations administered.
- It helps understand the vaccination progress in different countries.

## Views

### PercentPopulationVaccinated
- This view stores data for later visualizations.
- It includes information about continents, locations, dates, populations, new vaccinations, and rolling people vaccinated.

### CountriesHighestDeathCount
- This view lists countries with the highest death count per population.
- It is useful for further analysis and comparisons.

### ContinentsHighestDeathCount
- This view presents continents with the highest death count.
- It provides insights into the severity of the pandemic on a continental
- 

# Cleaning Data in SQL Queries

This repository contains a collection of SQL queries for cleaning and transforming data in the "PortfolioProject.dbo.NashvilleHousing" table. The provided SQL queries address various data cleaning tasks, including standardizing date formats, populating missing values, splitting address columns, replacing values, removing duplicates, and deleting unused columns. Below is a summary of each task along with the corresponding SQL query.

## Standardize Date Format
The query aims to standardize the date format in the "SaleDate" column of the table. It converts the "SaleDate" column to the date data type using the CONVERT function.

## Populate Property Address Data
The query identifies records with missing values in the "PropertyAddress" column and populates them by matching the "ParcelID" with non-null "PropertyAddress" values in other records.

## Breaking out Address into Individual Columns (Address, City, State)
This query splits the "PropertyAddress" column into separate columns for address, city, and state, creating new columns "PropertySplitAddress" and "PropertySplitCity" in the table.

## Splitting Owner Address into Individual Columns (Address, City, State)
The query splits the "OwnerAddress" column into separate columns for owner address, city, and state, creating new columns "OwnerSplitAddress," "OwnerSplitCity," and "OwnerSplitState" in the table.

## Change "Y" and "N" to "Yes" and "No" in "Sold as Vacant" field
The query converts the values in the "SoldAsVacant" column from "Y" to "Yes" and from "N" to "No" for improved readability.

## Remove Duplicates
This query removes duplicate records from the table based on specific columns ("ParcelID," "PropertyAddress," "SalePrice," "SaleDate," and "LegalReference").

## Delete Unused Columns
The query deletes unused columns ("OwnerAddress," "TaxDistrict," "PropertyAddress," and "SaleDate") from the table.

Please note that you should adjust the table and column names as per your specific database setup.
