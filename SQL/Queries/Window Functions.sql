--1--Use a window function to add columns showing:
--a--The maximum population (max_pop) for each county.

SELECT DISTINCT(population.county),
		population,
		MAX(population) OVER (PARTITION BY county) AS max_pop_in_county
FROM population;

--b--The minimum population (min_pop) for each county.

SELECT DISTINCT(population.county),
		population,
		MIN(population) OVER (PARTITION BY county) AS min_pop_in_county
FROM population;

--2--Rank counties from largest to smallest population for each year.

SELECT population.county, 
		year, 
		population, 
	DENSE_RANK()OVER(PARTITION BY county ORDER BY year) AS pop_year
FROM population;

--3--Use the unemployment table:

--a--Calculate the rolling 12-month average unemployment rate using the unemployment table.
--b--Include the current month and the preceding 11 months. Hint: Reference two columns in the ORDER BY argument (county and period).

SELECT county, 
		period,
		AVG(value) OVER(
			PARTITION BY county 
			ORDER BY county, period
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
			) AS rolling_Avg
FROM unemployment;






