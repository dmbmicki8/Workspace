--1a--Which prescriber had the highest total number of claims (totaled over all drugs)? Report the npi and the total number of claims.
SELECT prescriber.npi, 
	nppes_provider_last_org_name, 
	prescription.npi, 
	SUM(total_claim_count) AS total_claims
FROM prescriber
JOIN prescription 
	ON prescriber.npi = prescription.npi
GROUP BY prescriber.npi, nppes_provider_last_org_name, prescription.npi
ORDER BY total_claims DESC
LIMIT 1;

--1b--Repeat the above, but this time report the nppes_provider_first_name, nppes_provider_last_org_name, specialty_description, and the total number of claims.
SELECT prescriber.npi, 
	nppes_provider_first_name,
	nppes_provider_last_org_name, 
	specialty_description, 
	prescription.npi, 
	SUM(total_claim_count) AS total_claims
FROM prescriber
JOIN prescription 
	ON prescriber.npi = prescription.npi
GROUP BY prescriber.npi, nppes_provider_first_name, nppes_provider_last_org_name,specialty_description, prescription.npi
ORDER BY total_claims DESC
LIMIT 1;


--2a--Which specialty had the most total number of claims (totaled over all drugs)?
SELECT  
	specialty_description AS specialty,
	SUM(total_claim_count) AS total_claims
FROM prescriber
JOIN prescription 
	ON prescriber.npi = prescription.npi
GROUP BY specialty
ORDER BY total_claims DESC
LIMIT 10;


--2b--Which specialty had the most total number of claims for opioids?
SELECT  
	specialty_description AS specialty,
	SUM(total_claim_count) AS total_opioid_claims
FROM prescriber
JOIN prescription 
	ON prescriber.npi = prescription.npi
JOIN drug
	ON prescription.drug_name = drug.drug_name
WHERE drug.opioid_drug_flag = 'Y'
GROUP BY specialty 
ORDER BY total_opioid_claims DESC
LIMIT 10;


--2c--Challenge Question: Are there any specialties that appear in the prescriber table that have no associated prescriptions in the prescription table?-15

--IN CLASS--
SELECT specialty_description, COUNT(prescription.*) AS total_prescriptions
FROM prescriber
FULL JOIN prescription
USING (npi)
GROUP BY specialty_description
HAVING COUNT(prescription.*) = 0;
--


SELECT  
	specialty_description AS specialty,
	SUM(total_claim_count) AS total_claims
FROM prescriber
LEFT JOIN prescription 
	ON prescriber.npi = prescription.npi
WHERE prescription.total_claim_count IS NULL
GROUP BY specialty;


--2d--Difficult Bonus: Do not attempt until you have solved all other problems! For each specialty, report the percentage of total claims by that specialty which are for opioids. Which specialties have a high percentage of opioids?

SELECT  
	specialty_description AS specialty,
	ROUND(SUM(
		CASE WHEN  drug.opioid_drug_flag = 'Y'
			THEN total_claim_count
			END) * 100.0 / 
	NULLIF(SUM(total_claim_count),0),2) AS opioid_percent
	FROM prescriber
JOIN prescription 
	ON prescriber.npi = prescription.npi
JOIN drug
	ON prescription.drug_name = drug.drug_name
GROUP BY specialty
ORDER BY opioid_percent DESC NULLS LAST;

--3a--Which drug (generic_name) had the highest total drug cost?

SELECT SUM(total_drug_cost) AS total_cost,
		generic_name
FROM prescription
	JOIN drug
		ON prescription.drug_name = drug.drug_name
WHERE total_drug_cost IS NOT NULL 
	GROUP BY generic_name
	ORDER BY total_cost DESC;

--3b--Which drug (generic_name) has the hightest total cost per day? Bonus: Round your cost per day column to 2 decimal places. Google ROUND to see how this works.

SELECT generic_name, 
		ROUND(SUM(total_drug_cost) / SUM(total_day_supply), 2) AS drug_total		
FROM prescription
	JOIN drug
		ON prescription.drug_name = drug.drug_name
	GROUP BY generic_name
	ORDER BY drug_total DESC;

select drug.generic_name, round((rx.total_drug_cost/rx.total_day_supply),2) as per_day
from prescription as rx
join drug
using(drug_name)
order by per_day DESC;

--4a. For each drug in the drug table, return the drug name and then a column named 'drug_type' which says 'opioid' for drugs which have opioid_drug_flag = 'Y', says 'antibiotic' for those drugs which have antibiotic_drug_flag = 'Y', and says 'neither' for all other drugs. Hint: You may want to use a CASE expression for this.

SELECT drug_name,
	CASE
		WHEN opioid_drug_flag = 'Y' THEN 'opioid'
		WHEN antibiotic_drug_flag = 'Y' THEN 'anticiotic'
		ELSE 'neither'
	END AS drug_type
FROM drug;

--4b--Building off of the query you wrote for part a, determine whether more was spent (total_drug_cost) on opioids or on antibiotics. Hint: Format the total costs as MONEY for easier comparision.

SELECT 
	CASE
		WHEN opioid_drug_flag = 'Y' THEN 'opioid'
		WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
		ELSE 'neither'
	END AS drug_type,
	SUM(total_drug_cost)::MONEY AS total_spent
FROM prescription
JOIN drug
		ON prescription.drug_name = drug.drug_name
WHERE total_drug_cost IS NOT NULL 
	GROUP BY drug_type
	ORDER BY total_spent;



--5a--How many CBSAs are in Tennessee? Warning: The cbsa table contains information for all states, not just Tennessee.

SELECT 
	COUNT(DISTINCT cbsa) AS tn_cbsa, 
	state
FROM fips_county
	JOIN cbsa
 	ON fips_county.fipscounty = cbsa.fipscounty
WHERE state = 'TN'
GROUP BY state;

--5b--Which cbsa has the largest combined population? Which has the smallest? Report the CBSA name and total population. - Nashville-Davidson--Murfreesboro--Franklin, TN; 1830410::MIN Morristown TN; 116352.
SELECT
    cbsa.cbsaname,
    SUM(population.population) AS total_population
FROM cbsa 
JOIN fips_county 
    ON cbsa.fipscounty = fips_county.fipscounty
JOIN population 
    ON fips_county.fipscounty = population.fipscounty
WHERE fips_county.state = 'TN'
GROUP BY cbsa.cbsaname
ORDER BY total_population DESC;


--5c--What is the largest (in terms of population) county which is not included in a CBSA? Report the county name and population. -- Largest is Shelby 937847

SELECT population,
		fips_county.fipscounty,
		county
FROM population
	JOIN fips_county
		ON population.fipscounty = fips_county.fipscounty
WHERE fipscounty IS NOT-

--6a--Find all rows in the prescription table where total_claims is at least 3000. Report the drug_name and the total_claim_count.

SELECT drug_name,
		(SUM(total_claim_count) + SUM(total_claim_count_ge65)) AS total_claims
FROM prescription
WHERE total_claim_count > 3000 OR total_claim_count_ge65 >3000
GROUP BY drug_name;

--6b--or each instance that you found in part a, add a column that indicates whether the drug is an opioid.

SELECT prescription.drug_name,
		(SUM(total_claim_count) + SUM(total_claim_count_ge65)) AS total_claims,
		opioid_drug_flag
FROM prescription
	JOIN drug
		ON prescription.drug_name = drug.drug_name
WHERE total_claim_count > 3000 
	OR total_claim_count_ge65 >3000
	AND opioid_drug_flag = 'Y'
GROUP BY prescription.drug_name, opioid_drug_flag;

--6c--Add another column to you answer from the previous part which gives the prescriber first and last name associated with each row.

SELECT prescription.drug_name,
		(SUM(total_claim_count) + SUM(total_claim_count_ge65)) AS total_claims,
		opioid_drug_flag, 
		nppes_provider_last_org_name, 
		nppes_provider_first_name
FROM prescription
	JOIN drug
		ON prescription.drug_name = drug.drug_name
	JOIN prescriber
		ON prescription.npi = prescriber.npi
WHERE total_claim_count > 3000 
	OR total_claim_count_ge65 >3000
	AND opioid_drug_flag = 'Y'
GROUP BY prescription.drug_name, 
		opioid_drug_flag, 
		nppes_provider_last_org_name, 
		nppes_provider_first_name
ORDER BY nppes_provider_last_org_name;

--7--The goal of this exercise is to generate a full list of all pain management specialists in Nashville and the number of claims they had for each opioid. Hint: The results from all 3 parts will have 637 rows.

--7a--First, create a list of all npi/drug_name combinations for pain management specialists (specialty_description = 'Pain Management) in the city of Nashville (nppes_provider_city = 'NASHVILLE'), where the drug is an opioid (opiod_drug_flag = 'Y'). Warning: Double-check your query before running it. You will only need to use the prescriber and drug tables since you don't need the claims numbers yet.

SELECT 
	prescriber.npi,
	drug.drug_name
FROM prescriber
	JOIN prescription
		ON prescriber.npi = prescription.npi
	JOIN drug
		ON prescription.drug_name = drug.drug_name
WHERE specialty_description = 'Pain Management' 
		OR opioid_drug_flag ='Y' 
		AND nppes_provider_city = 'NASHVILLE'
ORDER BY prescriber.npi, drug.drug_name;

--7b--Next, report the number of claims per drug per prescriber. Be sure to include all combinations, whether or not the prescriber had any claims. You should report the npi, the drug name, and the number of claims (total_claim_count).
--7c--Finally, if you have not done so already, fill in any missing values for total_claim_count with 0. 


SELECT 
	prescriber.npi,
	drug.drug_name, 
	COALESCE(SUM(total_claim_count)+ SUM(total_claim_count_ge65), 0) AS all_total_claims
FROM prescriber
	CROSS JOIN drug
	LEFT JOIN prescription
		ON prescription.npi = prescriber.npi
		AND prescription.drug_name = drug.drug_name
WHERE specialty_description = 'Pain Management' 
		AND nppes_provider_city = 'NASHVILLE'
		AND opioid_drug_flag ='Y' 
GROUP BY prescriber.npi, drug.drug_name
ORDER BY prescriber.npi, drug.drug_name;


--BONUS--






















