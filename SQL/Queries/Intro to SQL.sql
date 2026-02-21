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









