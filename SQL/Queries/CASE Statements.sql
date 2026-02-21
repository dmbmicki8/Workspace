SELECT COUNT (county)
FROM ecd;

SELECT COUNT (company)
from ecd;

SELECT COUNT (company)
FROM ecd
WHERE ed = null;

SELECT SUM(capital_investment)
FROM ecd; 

SELECT SUM (capital_investment) AS fjtap_cap_invest_mil
FROM ecd;

SELECT county_tier, count (*)
FROM ecd
GROUP BY county_tier;

SELECT new_jobs, county_tier 
FROM ecd;

SELECT AVG (new_jobs), county_tier
FROM ecd
GROUP BY county_tier;

SELECT COUNT(DISTINCT company) AS llc_companies
FROM ecd
WHERE company ILIKE '%LLC%';

SELECT county, population, year,
	CASE
		WHEN population >=500000 THEN 'high population'
		WHEN population >100000 AND population < 500000 THEN 'medium population'
		WHEN population <=100000 THEN 'low population'
		END AS pop_category
FROM population
WHERE year = 2017;

SELECT project_type
FROM ecd;

SELECT company, new_jobs, project_type,
	CASE 
	WHEN new_jobs <50 THEN 'small startup'
	WHEN new_jobs >50 and new_jobs <100 THEN 'midsize startup'
	WHEN new_jobs >=100 THEN 'large startup'
	END AS new_startup_jobs
FROM ecd
WHERE project_type = 'New Startup';


SELECT 
	SUM(CASE WHEN year = 2010 THEN population ELSE 0 END) AS Total_Pop_2010,
	SUM(CASE WHEN year = 2017 THEN population ELSE 0 END) AS Total_Pop_2017
FROM population; 
	
	

	
	










