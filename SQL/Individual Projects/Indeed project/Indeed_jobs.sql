-- How many rows are in the data_analyst_jobs table?
SELECT COUNT(*)
FROM data_analyst_jobs;
--1793

--Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10;
-- ExxonMobil

--How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN';
--21


--How many postings in Tennessee have a star rating above 4?
SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location ='TN' OR location = 'KY';
--27

--How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(location)
FROM data_analyst_jobs
WHERE star_rating >=4 AND location = 'TN';
--4


--Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
SELECT COUNT(review_count)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
--151


--Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT AVG(star_rating) AS avg_rating, location AS state
FROM data_analyst_jobs
GROUP BY location;

--How many unique job titles are there for California companies?
SELECT AVG(star_rating) AS avg_rating, location AS state
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC
LIMIT 1;

--NE 4.19


SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

--881

--
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';
--230

--Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT COUNT(company), AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count >=5000;
--184

SELECT 
	AVG(star_rating) AS avg_rating, 
	company
FROM data_analyst_jobs
WHERE review_count >=5000
	AND star_rating IS NOT NULL
GROUP BY company
ORDER BY avg_rating DESC;
--6 way tie btw GM, Unilever, MS, Nike, AmEX, Kaiser Perm
	4.199999809
--Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

--Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%';
--774

--How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT DISTINCT title AS title_count
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' 
	AND title NOT ILIKE '%Analytics%';

--4, They are all tableau based jobs


--BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
--Disregard any postings where the domain is NULL.
--Order your results so that the domain with the greatest number of hard to fill jobs is at the top.

SELECT 
	domain,
	COUNT(*) AS job_count
FROM data_analyst_jobs
WHERE domain IS NOT NULL
	AND skill ILIKE '%SQL%'
	AND days_since_posting > 21
GROUP BY domain
ORDER BY job_count DESC;

--Which three industries are in the top 4 on this list? 
SELECT 
	domain,
	COUNT(*) AS job_count
FROM data_analyst_jobs
WHERE domain IS NOT NULL
	AND skill ILIKE '%SQL%'
	AND days_since_posting > 21
GROUP BY domain
ORDER BY job_count DESC
LIMIT 4;

--How many jobs have been listed for more than 3 weeks for each of the top 4?
SELECT SUM(job_count) AS total_jobs
FROM (
	SELECT domain, 
		COUNT(*) AS job_count
	FROM data_analyst_jobs
	WHERE domain IS NOT NULL
		AND skill ILIKE '%SQL%'
		AND days_since_posting > 21
	GROUP BY domain
	ORDER BY job_count DESC
	LIMIT 4
)sub;












































