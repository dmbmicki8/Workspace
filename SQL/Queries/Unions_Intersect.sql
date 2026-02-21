--Find Athletes from Summer or Winter Games
--Write a query to list all athlete names who participated in the Summer or Winter Olympics. Ensure no duplicates appear in the final table using a set theory clause.

SELECT name, 'Summer' AS season
FROM athletes
JOIN summer_games
	ON athletes.id = summer_games.athlete_id
	
UNION

SELECT name, 'Winter' AS season
FROM athletes
JOIN winter_games
	ON athletes.id = winter_games.athlete_id;

--Find Countries Participating in Both Games
--Write a query to retrieve country_id and country_name for countries in the Summer Olympics.
--Add a JOIN to include the country’s 2016 population and exclude the country_id from the SELECT statement.
--Repeat the process for the Winter Olympics.
--Use a set theory clause to combine the results.

SELECT country, 'Summer' AS season
FROM countries
	JOIN summer_games
	ON summer_games.country_id = countries.id
	WHERE year = '2016-01-01'
UNION 
SELECT country, 'Winter' AS season
FROM countries
	JOIN winter_games
	ON winter_games.country_id = countries.id
	WHERE year = '2016-01-01'
ORDER BY country;


(Select country, pop_in_millions
FROM countries
INNER JOIN summer_games
ON countries.id = summer_games.country_id
INNER JOIN country_stats
ON countries.id = country_stats.country_id
where DATE(country_stats.year) = '2016-01-01')
INTERSECT
(Select country, pop_in_millions
FROM countries
INNER JOIN winter_games
ON countries.id = winter_games.country_id
INNER JOIN country_stats
ON countries.id = country_stats.country_id
where country_stats.year = '2016-01-01')

--Identify Countries Exclusive to the Summer Olympics
--Return the country_name and region for countries present in the countries table but not in the winter_games table.
--(Hint: Use a set theory clause where the top query doesn’t involve a JOIN, but the bottom query does.)

SELECT country, region
FROM countries

EXCEPT

SELECT c.country, c.region
FROM countries AS c
	INNER JOIN winter_games 
	ON c.id = winter_games.country_id;














