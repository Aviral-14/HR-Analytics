select*
from hrdata;


SELECT SUM(employee_count) AS Employee_Count FROM hrdata;

-- Attrition Count:
SELECT COUNT(*) FROM hrdata WHERE attrition='Yes';

-- Active Employee:
SELECT SUM(employee_count) - (SELECT COUNT(*) FROM hrdata WHERE attrition='Yes') AS active_employees FROM hrdata;

-- Average Age:
SELECT ROUND(AVG(age), 0) AS average_age FROM hrdata;

-- Attrition by Gender
SELECT gender, COUNT(*) AS attrition_count 
FROM hrdata
WHERE attrition='Yes'
GROUP BY gender
ORDER BY COUNT(*) DESC;

-- No of Employee by Age Group
SELECT age, SUM(employee_count) AS employee_count 
FROM hrdata
GROUP BY age
ORDER BY age;

-- Education Field wise Attrition:
SELECT education_field, COUNT(*) AS attrition_count 
FROM hrdata
WHERE attrition='Yes'
GROUP BY education_field
ORDER BY COUNT(*) DESC;

--  Dept-Wise Attrition Rate:
WITH AttritionCounts AS (
    SELECT 
        department, 
        COUNT(*) AS attrition_count
    FROM hrdata
    WHERE attrition = 'Yes'
    GROUP BY department
),
TotalAttrition AS (
    SELECT COUNT(*) AS total_attrition
    FROM hrdata
    WHERE attrition = 'Yes'
)
SELECT 
    ac.department, 
    ac.attrition_count,
    ROUND((ac.attrition_count / ta.total_attrition) * 100, 2) AS pct
FROM AttritionCounts ac
CROSS JOIN TotalAttrition ta
ORDER BY ac.attrition_count DESC;



SELECT 
ROUND(((SELECT COUNT(*) FROM hrdata WHERE attrition='Yes') / 
SUM(employee_count)) * 100, 2) AS attrition_rate
FROM hrdata;


WITH AttritionCounts AS (
    SELECT 
        age_band, 
        gender, 
        COUNT(*) AS attrition_count
    FROM hrdata
    WHERE attrition = 'Yes'
    GROUP BY age_band, gender
),
TotalAttrition AS (
    SELECT COUNT(*) AS total_attrition
    FROM hrdata
    WHERE attrition = 'Yes'
)
SELECT 
    ac.age_band, 
    ac.gender, 
    ac.attrition_count AS attrition,
    ROUND((ac.attrition_count / ta.total_attrition) * 100, 2) AS pct
FROM AttritionCounts ac
CROSS JOIN TotalAttrition ta
ORDER BY ac.age_band, ac.gender DESC;

-- Job Satisfaction Rating
SELECT 
    job_role,
    SUM(CASE WHEN job_satisfaction = 1 THEN employee_count ELSE 0 END) AS one,
    SUM(CASE WHEN job_satisfaction = 2 THEN employee_count ELSE 0 END) AS two,
    SUM(CASE WHEN job_satisfaction = 3 THEN employee_count ELSE 0 END) AS three,
    SUM(CASE WHEN job_satisfaction = 4 THEN employee_count ELSE 0 END) AS four
FROM hrdata
GROUP BY job_role
ORDER BY job_role;





