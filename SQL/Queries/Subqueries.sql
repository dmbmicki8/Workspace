--Find which county had the most months with unemployment rates above the state average:
--Write a query to calculate the state average unemployment rate.

SELECT year,period, county, AVG(value) AS state_unemployment
FROM unemployment
GROUP BY year,period, county;

--Use this query in the WHERE clause of an outer query to filter for months above the average.

SELECT county, COUNT(period)AS months_above_avg
FROM unemployment
WHERE value >(
		SELECT AVG(value)
		FROM unemployment
		WHERE year = unemployment.year
		AND period = unemployment.period)
	GROUP BY county
	ORDER BY months_above_avg DESC;

--Use Select to count the number of months each county was above the average. Which country had the most?
SELECT county, COUNT(*)AS months_above_avg
FROM unemployment
WHERE value >(
		SELECT AVG(value)
		FROM unemployment
		WHERE year = unemployment.year
		AND period = unemployment.period)
	GROUP BY county
	ORDER BY months_above_avg DESC
	LIMIT 1;

--Find the average number of jobs created for each county based on projects involving the largest capital investment by each company:
SELECT county, ecd.company, AVG(new_jobs) AS jobs
FROM ecd
	JOIN(
		SELECT company, MAX(capital_investment) AS largest_investment
		FROM ecd
		GROUP BY company) AS max_company
	ON ecd.company = max_company.company
	AND ecd.capital_investment = max_company.largest_investment
	GROUP BY county, ecd.company 
	ORDER BY county, jobs DESC;


--Write a query to find each company’s largest capital investment, returning the company name along with the relevant capital investment amount for each.

SELECT company, MAX(capital_investment) AS max_comp
FROM ecd
GROUP BY company;

	
	
--Use this query in the FROM clause of an outer query, alias it, and join it with the original table.

SELECT 
	county,
	ROUND(AVG(new_jobs),2) AS total_jobs
FROM (SELECT 
	company, 
	MAX(capital_investment) AS company_max_invest
	FROM ecd
	GROUP BY company) AS max_company
INNER JOIN ecd ON (max_company.company = ecd.company) AND (max_company.company_max_invest = ecd.capital_investment)
GROUP BY county;

	

--Adjust the SELECT clause to calculate the average number of jobs created by county.

SELECT county, AVG(new_jobs) AS jobs
FROM ecd
	JOIN (
	SELECT company, MAX(capital_investment) AS largest_investment
	FROM ecd
	GROUP BY ecd.company) AS max_company
	ON ecd.company = max_company.company
	AND ecd.capital_investment = max_company.largest_investment
GROUP BY ecd.county
ORDER BY jobs DESC;


