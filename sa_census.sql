-- Create a new database
CREATE DATABASE census_data;

-- Use the new database
USE census_data;

-- Create table to hold the census data
CREATE TABLE sa_census (
    id INT PRIMARY KEY,
    full_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    education_level VARCHAR(50),
    employment_status VARCHAR(20),
    household_income FLOAT,
    province VARCHAR(50)
);

-- Create table for household data
CREATE TABLE households (
    household_id INT PRIMARY KEY,
    household_size INT,
    province VARCHAR(50),
    household_type VARCHAR(50), -- (e.g., nuclear, extended)
    household_income FLOAT
);

-- Create table for employment information
CREATE TABLE employment (
    emp_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    occupation VARCHAR(50),
    industry VARCHAR(50), -- (e.g., healthcare, education)
    salary FLOAT,
    status VARCHAR(20), -- (Employed, Unemployed, Self-Employed, Retired)
    date_of_employment DATE
);

-- Create table for education details
CREATE TABLE education (
    edu_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    highest_qualification VARCHAR(50),
    institution_name VARCHAR(100),
    graduation_year INT,
    qualification_type VARCHAR(50) -- (e.g., diploma, degree, certificate)
);

-- Create table for housing data
CREATE TABLE housing (
    housing_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    dwelling_type VARCHAR(50), -- (e.g., house, apartment, shack)
    ownership_status VARCHAR(20), -- (e.g., Owned, Rented, Freehold)
    monthly_rent FLOAT,
    number_of_rooms INT
);

-- Create table for healthcare details
CREATE TABLE healthcare (
    health_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    has_health_insurance BIT, -- 1 for Yes, 0 for No
    visits_doctor_regularly BIT, -- 1 for Yes, 0 for No
    chronic_conditions VARCHAR(100) -- (e.g., diabetes, hypertension)
);


-- Insert mock data into the table
INSERT INTO sa_census (id, full_name, age, gender, education_level, employment_status, household_income, province) VALUES
(1, 'Lebo Mokoena', 28, 'Male', 'Tertiary', 'Employed', 12000, 'Gauteng'),
(2, 'Thabo Dlamini', NULL, 'male', 'High School', 'Employed', 8500, 'KwaZulu-Natal'),
(3, 'Nomsa Khumalo', 35, 'FEMALE', 'High School', NULL, 10000, 'Western Cape'),
(4, 'Sipho Mahlangu', 40, 'Male', 'None', 'Unemployed', NULL, 'Eastern Cape'),
(5, 'Naledi Sithole', 19, 'female', 'Tertiary', 'Student', 0, 'Gauteng'),
(6, 'Anonymous', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'Zanele Ntuli', 29, 'Female', 'Tertiary', 'Employed', 12500, 'Gauteng'),
(8, 'Thabo Dlamini', NULL, 'male', 'High School', 'Employed', 8500, 'KwaZulu-Natal');


-- Insert mock data into households
INSERT INTO households (household_id, household_size, province, household_type, household_income) VALUES
(1, 5, 'Gauteng', 'Nuclear', 24000),
(2, 7, 'KwaZulu-Natal', 'Extended', 18000),
(3, 3, 'Western Cape', 'Nuclear', 15000),
(4, 4, 'Eastern Cape', 'Single Parent', 8000);

-- Insert mock data into employment
INSERT INTO employment (emp_id, full_name, occupation, industry, salary, status, date_of_employment) VALUES
(1, 'Lebo Mokoena', 'Software Developer', 'Technology', 18000, 'Employed', '2020-06-01'),
(2, 'Thabo Dlamini', 'Teacher', 'Education', 12000, 'Employed', '2017-03-15'),
(3, 'Nomsa Khumalo', 'Nurse', 'Healthcare', 15000, 'Employed', '2016-07-22'),
(4, 'Sipho Mahlangu', 'Construction Worker', 'Construction', 7000, 'Unemployed', NULL);

-- Insert mock data into education
INSERT INTO education (edu_id, full_name, highest_qualification, institution_name, graduation_year, qualification_type) VALUES
(1, 'Lebo Mokoena', 'Bachelor''s Degree', 'University of Pretoria', 2018, 'Degree'),
(2, 'Thabo Dlamini', 'Matric', 'Durban High School', 2010, 'High School'),
(3, 'Nomsa Khumalo', 'Diploma in Nursing', 'University of Cape Town', 2015, 'Diploma'),
(4, 'Sipho Mahlangu', 'None', 'N/A', NULL, 'None');

-- Insert mock data into housing
INSERT INTO housing (housing_id, full_name, dwelling_type, ownership_status, monthly_rent, number_of_rooms) VALUES
(1, 'Lebo Mokoena', 'House', 'Owned', 0, 3),
(2, 'Thabo Dlamini', 'Apartment', 'Rented', 5000, 2),
(3, 'Nomsa Khumalo', 'Flat', 'Owned', 0, 2),
(4, 'Sipho Mahlangu', 'Shack', 'Freehold', 2000, 1);

-- Insert mock data into healthcare
INSERT INTO healthcare (health_id, full_name, has_health_insurance, visits_doctor_regularly, chronic_conditions) VALUES
(1, 'Lebo Mokoena', 1, 1, 'None'),
(2, 'Thabo Dlamini', 0, 0, 'Hypertension'),
(3, 'Nomsa Khumalo', 1, 1, 'None'),
(4, 'Sipho Mahlangu', 0, 0, 'Diabetes');

-- 1. Checking for NULL Values
-- Check for NULL values in the census table
SELECT * 
FROM sa_census 
WHERE full_name IS NULL OR age IS NULL OR gender IS NULL OR education_level IS NULL OR employment_status IS NULL OR household_income IS NULL OR province IS NULL;

-- Check for NULL values in the households table
SELECT * 
FROM households 
WHERE household_size IS NULL OR province IS NULL OR household_type IS NULL OR household_income IS NULL;

-- Check for NULL values in the employment table
SELECT * 
FROM employment 
WHERE full_name IS NULL OR occupation IS NULL OR industry IS NULL OR salary IS NULL OR status IS NULL OR date_of_employment IS NULL;

-- Check for NULL values in the education table
SELECT * 
FROM education 
WHERE full_name IS NULL OR highest_qualification IS NULL OR institution_name IS NULL OR graduation_year IS NULL OR qualification_type IS NULL;

-- Check for NULL values in the housing table
SELECT * 
FROM housing 
WHERE full_name IS NULL OR dwelling_type IS NULL OR ownership_status IS NULL OR monthly_rent IS NULL OR number_of_rooms IS NULL;

-- Check for NULL values in the healthcare table
SELECT * 
FROM healthcare 
WHERE full_name IS NULL OR has_health_insurance IS NULL OR visits_doctor_regularly IS NULL OR chronic_conditions IS NULL;


--2. Handling Duplicates
-- Check for duplicate entries in the census table based on "full_name"
SELECT full_name, COUNT(*)
FROM sa_census
GROUP BY full_name
HAVING COUNT(*) > 1;

-- Check for duplicate entries in the households table based on 'household_id'
SELECT household_id, COUNT(*)
FROM households
GROUP BY household_id
HAVING COUNT(*) > 1;

-- Check for duplicate entries in the employment table based on 'full_name'
SELECT full_name, COUNT(*)
FROM employment
GROUP BY full_name
HAVING COUNT(*) > 1;

-- Check for duplicate entries in the education table based on 'full_name'
SELECT full_name, COUNT(*)
FROM education
GROUP BY full_name
HAVING COUNT(*) > 1;

-- Check for duplicate entries in the housing table based on 'full_name'
SELECT full_name, COUNT(*)
FROM housing
GROUP BY full_name
HAVING COUNT(*) > 1;

-- Check for duplicate entries in the healthcare table based on 'full_name'
SELECT full_name, COUNT(*)
FROM healthcare
GROUP BY full_name
HAVING COUNT(*) > 1;

--3. Handling Outliers
-- Check for outliers in household income in the census table
SELECT *
FROM sa_census
WHERE household_income < 1000 or household_income > 1000000;

-- Check for outliers in salary in the employment table
SELECT *
FROM employment
WHERE salary < 1000 or salary > 1000000;

-- Check for outliers in monthly rent in the housing table
SELECT *
FROM housing
WHERE monthly_rent < 100 OR monthly_rent > 50000;

-- 4. Identifying Missing or Inconsistent data
-- Identifying individuals who are unemployed but still have a salary record
SELECT e.full_name, e.salary, e.status
FROM employment e
JOIN sa_census s ON e.full_name = s.full_name
WHERE e.status = 'Unemployed' AND e.salary > 0;

-- Identifying individuals who have a high slary but are marked as unemployed
SELECT e.full_name, e.salary, e.status
FROM employment e
JOIN sa_census s ON e.full_name = s.full_name
WHERE e.salary > 50000 AND e.status = 'Unemployed';

--5. Checking data integrity
-- Ensure individuals from the sa_census table match the province in the household table
SELECT s.full_name, s.province AS census_province, h.province AS household_province
FROM sa_census s
JOIN households h ON s.province = h.province
WHERE s.province <> h.province;

--6.Data Transformation
-- Categorize household income into different income brackets
SELECT full_name, household_income,
	CASE
		WHEN household_income < 10000 THEN 'Low Income'
		WHEN household_income BETWEEN 10000 AND 50000 THEN 'Middle Income'
		ELSE 'High Income'
	END AS income_category
FROM sa_census

-- 7. Aggregation & Grouping Data
-- Calculate the average household income by province
SELECT province, AVG(household_income) AS avg_household_income
FROM sa_census
GROUP BY province;

-- Count the number of people with and without health insurance
SELECT
	CASE WHEN has_health_insurance = 1 THEN 'Has Insurance' ELSE 'No Insurance' END AS insurance_status,
	COUNT(*) AS number_of_people
FROM healthcare
GROUP BY has_health_insurance;

-- 8. Joining Tables for Insights
-- Census Information and Employment Status
SELECT s.full_name, s.age, s.gender, s.education_level, e.occupation, e.salary
FROM sa_census s
JOIN employment e ON s.full_name = e.full_name;

-- Household income and Health insurance Status
SELECT h.full_name, h.household_income, hc.has_health_insurance
FROM sa_census h
JOIN healthcare hc ON h.full_name = hc.full_name;

-- Education and Employment
SELECT e.full_name, e.highest_qualification, emp.occupation, emp.salary
FROM education e
JOIN employment emp ON e.full_name = emp.full_name;