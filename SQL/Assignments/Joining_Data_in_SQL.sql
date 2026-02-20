--How many rows are in the athletes table? How many distinct athlete ids?
SELECT COUNT(*)
FROM athletes
--4216

SELECT COUNT(DISTINCT id)
FROM athletes
--4215 (means there is one duplicate)

--Which years are represented in the summer_games, winter_games, and country_stats tables?
SELECT DISTINCT(year)
FROM summer_games
ORDER BY year DESC;
--2016-01-01

SELECT DISTINCT(year)
FROM winter_games
ORDER BY year DESC;
--2014-01-01

SELECT DISTINCT(year)
FROM country_stats
ORDER BY year DESC;
--17 different rows/years

SELECT DISTINCT summer_games.year, winter_games.year, country_stats.year
FROM summer_games
FULL JOIN winter_games
USING (year)
FULL JOIN country_stats
ON winter_games.year = country_stats.year::DATE;

--How many distinct countries are represented in the countries and country_stats table?

SELECT COUNT(DISTINCT country)
FROM countries;
--203

SELECT COUNT(DISTINCT country_id)
FROM country_stats;
--203

--How many distinct events are in the winter_games and summer_games table?

SELECT COUNT(DISTINCT event)
FROM winter_games;
--32

SELECT COUNT(DISTINCT event)
FROM summer_games;
--95


--Count the number of athletes who participated in the summer games for each country. Your output should have country name and number of athletes in their own columns. Did any country have no athletes?

SELECT country, COUNT(DISTINCT athlete_id) AS total_athletes
FROM countries
LEFT JOIN summer_games
	ON countries.id = summer_games.country_id
	GROUP BY country
	ORDER BY total_athletes DESC;


--Write a query to list countries by total bronze medals, with the highest totals at the top and nulls at the bottom.

SELECT country, SUM(bronze) AS total_bronze
FROM countries
LEFT JOIN summer_games
	ON countries.id = summer_games.country_id
GROUP BY country
ORDER BY total_bronze DESC NULLS LAST;



SELECT
	c.country, 
	(s.summer_bronze + w.winter_bronze) AS total_bronze
FROM countries c
LEFT JOIN (
	SELECT country_id, SUM(bronze) AS summer_bronze
	FROM summer_games
	GROUP by country_id)
	s
	on c.id = s.country_id
LEFT JOIN (
	SELECT country_id, SUM(bronze) AS winter_bronze
	FROM winter_games
	GROUP BY country_id)
	w
	ON c.id=w.country_id
ORDER BY total_bronze DESC NULLS LAST;

----Adjust the query to only return the country with the most bronze medals
SELECT
	c.country, 
	(s.summer_bronze + w.winter_bronze) AS total_bronze
FROM countries c
LEFT JOIN (
	SELECT country_id, SUM(bronze) AS summer_bronze
	FROM summer_games
	GROUP by country_id)
	s
	on c.id = s.country_id
LEFT JOIN (
	SELECT country_id, SUM(bronze) AS winter_bronze
	FROM winter_games
	GROUP BY country_id)
	w
	ON c.id=w.country_id
ORDER BY total_bronze DESC NULLS LAST
LIMIT 1;
--Canada (although USA also had 22)

--Calculate the average population in the country_stats table for countries in the winter_games. This will require 2 joins.---First query gives you country names and the average population.---Second query returns only countries that participated in the winter_games.

SELECT country, AVG(pop_in_millions::numeric) AS avg_pop
FROM winter_games
INNER JOIN countries
	ON winter_games.country_id = countries.id
INNER JOIN country_stats
	ON countries.id = country_stats.country_id
GROUP BY country
ORDER BY avg_pop DESC;



SELECT
  c.country,
  AVG(cs.pop_in_millions::numeric) AS avg_population
FROM country_stats cs
JOIN winter_games wg
  ON cs.country_id = wg.country_id
JOIN countries c
  ON cs.country_id = c.id
GROUP BY c.country;

--First got an error then added the ::numeric)

--Identify countries where the population decreased from 2000 to 2006.



SELECT country, a.year, a.pop_in_millions, b.year, b.pop_in_millions
FROM country_stats AS a
INNER JOIN country_stats AS b
	ON a.country_id = b.country_id
INNER JOIN countries
	ON a.country_id = countries.id
WHERE a.year = '2000-01-01' AND b.year = '2006-01-01'
	AND a.pop_in_millions::numeric >b.pop_in_millions::numeric;


SELECT
  c.country,
  cs2000.pop_2000,
  cs2006.pop_2006
FROM (
  SELECT country_id, pop_in_millions::numeric AS pop_2000
  FROM country_stats
  WHERE year = '2000'
) cs2000
JOIN (
  SELECT country_id, pop_in_millions::numeric AS pop_2006
  FROM country_stats
  WHERE year = '2006'
) cs2006
  ON cs2000.country_id = cs2006.country_id
JOIN countries c
  ON cs2000.country_id = c.id
WHERE cs2006.pop_2006 < cs2000.pop_2000;






