--Winter Olympics Gold Medals
--Write a CTE called top_gold_winter to find the top 5 gold-medal-winning countries for Winter Olympics.
--Query the CTE to select countries and their medal counts where gold medals won are ≥ 5.
SELECT country, COUNT(gold) AS total_gold
FROM winter_games
INNER JOIN countries
ON winter_games.country_id = countries.id
GROUP BY country
ORDER BY total_gold DESC
LIMIT 5;

--Look only at Winter Olympics results, count gold medals by country, rank them, keep the top 5. 


--A table that shows each country and how many gold medals it won in the Winter Olympics, limited to the top 5 countries.

WITH top_gold_winter AS (
	SELECT 
		country_id, SUM(gold) AS gold_medals
	FROM winter_games
	GROUP BY country_id
	ORDER BY gold_medals DESC
)
SELECT 
	countries.country,
	gold_medals
FROM top_gold_winter
	JOIN countries
		ON top_gold_winter.country_id = countries.id
	WHERE gold_medals >=5;

--Tall Athletes
--Write a CTE called tall_athletes to find athletes taller than the average height for athletes in the database.

WITH tall_athletes AS (
	SELECT
		name, 
		gender, 
		height
	FROM athletes
	WHERE height > (SELECT AVG(height)
					FROM athletes)
)
SELECT *
FROM tall_athletes;

--Query the CTE to return only female athletes over age 30 who meet the criteria.
WITH tall_athletes AS (
	SELECT
		name, 
		gender, 
		age,
		height
	FROM athletes
	WHERE gender = 'F' AND age >=30 AND height > (SELECT AVG(height)
					FROM athletes)
)
SELECT *
FROM tall_athletes;

--Average Weight of Female Athletes

--Write a CTE called tall_over30_female_athletes for the results of Exercise 2.
WITH tall_over30_female_athletes AS (
	SELECT
		name, 
		gender, 
		age,
		height
	FROM athletes
	WHERE gender = 'F' 
	AND age >=30 
	AND height > (SELECT AVG(height)
					FROM athletes)
)
SELECT *
FROM tall_over30_female_athletes;

--Query the CTE to find the average weight of these athletes.
WITH tall_over30_female_athletes AS (
	SELECT
		*
	FROM athletes
	WHERE gender = 'F' 
	AND age >30 
	AND height > (SELECT AVG(height)
					FROM athletes)
)
SELECT 
	ROUND(AVG(weight),2) AS avg_weight
FROM tall_over30_female_athletes;