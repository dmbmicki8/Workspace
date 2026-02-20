--Display Country name, 4-digit year, count of Nobel prize winners (where the count is ≥ 1), and country size:
--Large: Population > 100 million; Medium: Population between 50 and 100 million (inclusive); Small: Population < 50 million
--Sort results so that the country and year with the largest number of Nobel prize winners appear at the top.
--Export the results as a CSV file.
--Use Excel to create a chart effectively communicating the findings.

SELECT countries.country,
		LEFT(year,4) AS calendar_year,
		country_stats.nobel_prize_winners AS nobel_prize_winners,
			CASE
			WHEN country_stats.pop_in_millions::numeric >100 THEN 'large'
			WHEN country_stats.pop_in_millions::numeric BETWEEN 50 AND 100	THEN 'medium'
			ELSE 'small'
			END AS country_size
FROM country_stats
	JOIN countries
		ON countries.id = country_stats.country_id
	WHERE COALESCE(country_stats.nobel_prize_winners, 0) >=1
ORDER BY countries.country DESC, nobel_prize_winners DESC;



--Create the output in example that shows a row for each country and each year. Use COALESCE() to display unknown when the gdp is NULL.

SELECT country,
		LEFT(year,4) AS calendar_year,
		COALESCE(gdp::TEXT::MONEY::TEXT, 'unknown') AS gdp_amount			
FROM country_stats
	JOIN countries
		ON countries.id = country_stats.country_id
		ORDER BY country;












