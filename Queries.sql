USE health;
/*verifying everything is ok with the tables*/
SELECT * FROM wdi;
SELECT * FROM ghs;

/* Change the collumn names*/
ALTER TABLE wdi CHANGE `TIME` `year` INT,
 CHANGE Country_Name Countries VARCHAR(255), 
  CHANGE Current_health_expenditure_per_capita Exp_pc DOUBLE,
  CHANGE Domestic_general_government_health_expenditure_per_capita Gov_exp_pc DOUBLE,
  CHANGE Current_health_expenditure Exp DOUBLE,
  CHANGE Life_expectancy_at_birth_total Life_expectancy DOUBLE,
  CHANGE Population_total Population INT;
  
ALTER TABLE ghs CHANGE `OVERALL SCORE` Ghs_index DOUBLE,
	 CHANGE ï»¿Country Country TEXT;

/*Create the table with the National Healthcare systems, used python to help populate the table*/
CREATE TABLE health_care_systems (
Countries VARCHAR(255) PRIMARY KEY,
NHS_system VARCHAR(255)
);

INSERT INTO health_care_systems (Countries, NHS_system)
VALUES
('Australia', 'universal government-funded health system'),
('Bahrain', 'universal government-funded health system'),
('Bhutan', 'universal government-funded health system'),
('Botswana', 'universal government-funded health system'),
('Brazil', 'universal government-funded health system'),
('Brunei', 'universal government-funded health system'),
('Canada', 'universal government-funded health system'),
('Cuba', 'universal government-funded health system'),
('Denmark', 'universal government-funded health system'),
('Finland', 'universal government-funded health system'),
('Georgia', 'universal government-funded health system'),
('Greece', 'universal government-funded health system'),
('Iceland', 'universal government-funded health system'),
('Ireland', 'universal government-funded health system'),
('Italy', 'universal government-funded health system'),
('Kuwait', 'universal government-funded health system'),
('Malaysia', 'universal government-funded health system'),
('Maldives', 'universal government-funded health system'),
('Malta', 'universal government-funded health system'),
('New Zealand', 'universal government-funded health system'),
('North Korea', 'universal government-funded health system'),
('Norway', 'universal government-funded health system'),
('Oman', 'universal government-funded health system'),
('Portugal', 'universal government-funded health system'),
('San Marino', 'universal government-funded health system'),
('Saudi Arabia', 'universal government-funded health system'),
('South Africa', 'universal government-funded health system'),
('Spain', 'universal government-funded health system'),
('Sri Lanka', 'universal government-funded health system'),
('Sweden', 'universal government-funded health system'),
('Taiwan', 'universal government-funded health system'),
('Trinidad and Tobago', 'universal government-funded health system'),
('Ukraine', 'universal government-funded health system'),
('United Kingdom', 'universal government-funded health system'),
('Albania', 'universal public insurance system'),
('Andorra', 'universal public insurance system'),
('Belgium', 'universal public insurance system'),
('Bulgaria', 'universal public insurance system'),
('China', 'universal public insurance system'),
('Hong Kong', 'universal public insurance system'),
('Macau', 'universal public insurance system'),
('Colombia', 'universal public insurance system'),
('Croatia', 'universal public insurance system'),
('Czech Republic', 'universal public insurance system'),
('Estonia', 'universal public insurance system'),
('France', 'universal public insurance system'),
('Hungary', 'universal public insurance system'),
('Iran', 'universal public insurance system'),
('India', 'universal public insurance system'),
('Japan', 'universal public insurance system'),
('Latvia', 'universal public insurance system'),
('Lithuania', 'universal public insurance system'),
('Luxembourg', 'universal public insurance system'),
('Monaco', 'universal public insurance system'),
('Moldova', 'universal public insurance system'),
('Montenegro', 'universal public insurance system'),
('Poland', 'universal public insurance system'),
('Qatar', 'universal public insurance system'),
('Romania', 'universal public insurance system'),
('Russia', 'universal public insurance system'),
('Serbia', 'universal public insurance system'),
('Singapore', 'universal public insurance system'),
('Slovakia', 'universal public insurance system'),
('Slovenia', 'universal public insurance system'),
('South Korea', 'universal public insurance system'),
('Abu Dhabi', 'universal public insurance system'),
('Dubai', 'universal public insurance system'),
('Algeria', 'public-private insurance system'),
('Austria', 'public-private insurance system'),
('Argentina', 'public-private insurance system'),
('Chile', 'public-private insurance system'),
('Cyprus', 'public-private insurance system'),
('Germany', 'public-private insurance system'),
('Mexico', 'public-private insurance system'),
('Peru', 'public-private insurance system'),
('Turkey', 'public-private insurance system'),
('Israel', 'universal government-funded health system'),
('Liechtenstein', 'universal government-funded health system'),
('Netherlands', 'universal government-funded health system'),
('Switzerland', 'universal government-funded health system'),
('Bangladesh', 'non-universal insurance system'),
('Burundi', 'non-universal insurance system'),
('Democratic Republic of Congo', 'non-universal insurance system'),
('Egypt', 'non-universal insurance system'),
('Ethiopia', 'non-universal insurance system'),
('Indonesia', 'non-universal insurance system'),
('Jordan', 'non-universal insurance system'),
('Kenya', 'non-universal insurance system'),
('Nigeria', 'non-universal insurance system'),
('Paraguay', 'non-universal insurance system'),
('Ajman', 'non-universal insurance system'),
('Fujairah', 'non-universal insurance system'),
('Ras al-Khaimah', 'non-universal insurance system'),
('Sharjah', 'non-universal insurance system'),
('Umm al-Quwain', 'non-universal insurance system'),
('Tanzania', 'non-universal insurance system'),
('Uganda', 'non-universal insurance system'),
('United States', 'non-universal insurance system'),
('American Samoa', 'non-universal insurance system'),
('Guam', 'non-universal insurance system'),
('Northern Mariana Islands', 'non-universal insurance system'),
('Puerto Rico', 'non-universal insurance system'),
('United States Virgin Islands', 'non-universal insurance system'),
('Yemen', 'non-universal insurance system');

/* Joining the 3 tables togheter to obtain the GHS index and NHS Systems 
on the same table as the rest of the information*/

CREATE TABLE all_info AS
SELECT w.Countries, w.`year`, w.Exp_pc, w.Gov_exp_pc, w.`Exp`,
w.Life_expectancy, w.Population, w.GDP_per_capita, g.Ghs_index, h.NHS_system
FROM wdi AS w
LEFT JOIN ghs AS g
ON w.Countries = g.Country AND w.`year` = g.`Year`
LEFT JOIN health_care_systems AS h
ON w.Countries = h.Countries;

/*Deleting the record without information about the National Health care systems*/
DELETE FROM all_info
WHERE NHS_system IS NULL;

/*If there are still a lot of null values from the healthcare systems table eliminate some data to have
a more robust dataset*/

SELECT * FROM all_info;

DELETE FROM all_info
WHERE NHS_system IS NULL;

SELECT 
	COUNT( IF (Exp_pc IS NULL, 1, NULL)) AS null_count_Exp_pc,
	COUNT( IF (Gov_exp_pc IS NULL, 1, NULL)) AS null_count_Gov_Exp_pc,
	COUNT(IF (Exp IS NULL, 1, NULL)) AS null_count_Exp,
	COUNT(IF (Life_expectancy IS NULL, 1, NULL)) AS null_count_Life_Expectancy,
	COUNT(IF (Population IS NULL, 1, NULL)) AS null_count_pop,
	COUNT(IF (GDP_per_capita IS NULL, 1, NULL)) AS null_count_GDP_pc,
	COUNT(IF (Ghs_index IS NULL, 1, NULL)) AS null_count_GHS,
	COUNT(IF (NHS_system IS NULL, 1, NULL)) AS null_count_NHS_system
FROM all_info;

/*To know the countries without GHS index*/
SELECT Countries
FROM all_info
GROUP BY Countries
HAVING COUNT(DISTINCT Ghs_index) = 0;

/*Creating a new collum with the lagged life expectancy*/
ALTER TABLE all_info
ADD COLUMN lag_Life_exp FLOAT;

UPDATE all_info AS a
LEFT JOIN all_info AS b ON a.Countries = b.Countries AND a.`year` = b.`year` + 1
SET a.lag_Life_exp = b.Life_expectancy;

-- Creating a new variable with the personal expense on health per capita
ALTER TABLE all_info
ADD COLUMN personal_exp_pc FLOAT;

UPDATE all_info
SET personal_exp_pc = Exp_pc - Gov_exp_pc ;

/* Create a new table with new variables based on the data collected so far, in this new table the goal
is to create new indicators such as the total cost (total cost, government cost and private cost) */

CREATE TABLE New_indicators AS 
SELECT Countries, `year`, (Life_expectancy - lag_Life_exp) AS dif_Life_exp, (Exp_pc / GDP_per_capita)*100 AS rlt_exp, 
(Gov_exp_pc / GDP_per_capita)*100 AS rlt_gov_exp,   (personal_exp_pc / GDP_per_capita)*100 AS rlt_pers_exp, (Gov_exp_pc / Exp_pc)*100 AS gov_share, 
(personal_exp_pc / Exp_pc)*100 AS pers_share
FROM all_info;

DELETE FROM New_indicators
WHERE `year`=2000;

-- Create another table with only one metric by country (2012-2019)
-- difference from 2012 (coming out of sub-prime recession) to 2019 (start covid)

CREATE TABLE metrics AS
SELECT a.Countries, a.diff, c.Avg_rlt_exp, c.Avg_rlt_gov, c.avg_rltv_pers_exp, c.Avg_gov_share, c.Avg_pers_share
FROM (
  SELECT a.Countries, a.Life_expectancy - b.Life_expectancy AS diff
  FROM all_info AS a
  JOIN all_info AS b ON a.Countries = b.Countries
  WHERE a.`year` = 2019 AND b.`year` = 2012
) AS a
JOIN (
  SELECT a.Countries, AVG(c.rlt_exp) AS Avg_rlt_exp, AVG(c.rlt_gov_exp) AS Avg_rlt_gov,
    AVG(c.rlt_pers_exp) AS avg_rltv_pers_exp, AVG(c.gov_share) AS Avg_gov_share, AVG(c.pers_share) AS Avg_pers_share
  FROM all_info AS a
  JOIN New_indicators AS c ON a.Countries = c.Countries
  WHERE a.`year` = 2019
  GROUP BY a.Countries
) AS c ON a.Countries = c.Countries;





























