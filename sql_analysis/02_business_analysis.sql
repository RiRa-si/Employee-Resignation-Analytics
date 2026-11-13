
-- -- Q1. Overall Resignation Summary
-- Calculate total resignations, average age,
-- average tenure, and average performance rating.

SELECT
    COUNT(EmployeeID) AS Total_Resignations,
    ROUND(AVG(Age), 2) AS Average_Age,
    ROUND(AVG(Tenure_Years), 2) AS Average_Tenure,
    ROUND(AVG(PerformanceRating), 2) AS Average_Performance_Rating
FROM employees;


-- Q2. Department-wise Resignation Analysis
-- Calculate total resignations, average age,
-- average tenure, and average performance rating
-- for each department.

SELECT
    Department,
    COUNT(EmployeeID) AS Total_Resignations,
    ROUND(AVG(Age), 2) AS Average_Age,
    ROUND(AVG(Tenure_Years), 2) AS Average_Tenure,
    ROUND(AVG(PerformanceRating), 2) AS Average_Performance_Rating
FROM employees
GROUP BY Department
ORDER BY Total_Resignations DESC;


-- Q3. Resignation Reason Analysis
-- Calculate the number and percentage of resignations
-- associated with each resignation reason.

SELECT
    ResignationReason,
    COUNT(EmployeeID) AS Total_Resignations,
    ROUND(
        COUNT(EmployeeID) * 100.0 /
        (SELECT COUNT(*) FROM employees), 2
    ) AS Resignation_Percentage
FROM employees
GROUP BY ResignationReason
ORDER BY Total_Resignations DESC;


-- Q4. Age Group-wise Resignation Analysis
-- Calculate total resignations and average performance
-- for each age group.

SELECT
    AgeGroup,
    COUNT(EmployeeID) AS Total_Resignations,
    ROUND(AVG(Age), 2) AS Average_Age,
    ROUND(AVG(PerformanceRating), 2) AS Average_Performance_Rating
FROM employees
GROUP BY AgeGroup
ORDER BY Total_Resignations DESC;


-- Q5. Tenure Band-wise Resignation Analysis
-- Calculate total resignations and average age
-- and performance rating for each tenure band.

SELECT
    TenureBand,
    COUNT(EmployeeID) AS Total_Resignations,
    ROUND(AVG(Age), 2) AS Average_Age,
    ROUND(AVG(PerformanceRating), 2) AS Average_Performance_Rating
FROM employees
GROUP BY TenureBand
ORDER BY Total_Resignations DESC;

-- Q6. Department-wise Resignation Reason Analysis
-- Count resignations for each combination of
-- department and resignation reason.

SELECT
    Department,
    ResignationReason,
    COUNT(EmployeeID) AS Total_Resignations
FROM employees
GROUP BY
    Department,
    ResignationReason
ORDER BY
    Department,
    Total_Resignations DESC;

-- Q7. Department-wise Performance Analysis
-- Count employees with high performance ratings (4 or 5)
-- and low performance ratings (below 3).

SELECT
    Department,

    SUM(
        CASE
            WHEN PerformanceRating IN (4, 5) THEN 1
            ELSE 0
        END
    ) AS High_Performers,

    SUM(
        CASE
            WHEN PerformanceRating < 3 THEN 1
            ELSE 0
        END
    ) AS Low_Performers,

    COUNT(EmployeeID) AS Total_Resignations

FROM employees
GROUP BY Department
ORDER BY Department;


-- Q8. Percentage of High Performers by Department
-- Calculate the percentage of employees with
-- performance ratings of 4 or 5 in each department.

SELECT
    Department,
    COUNT(EmployeeID) AS Total_Resignations,

    SUM(
        CASE
            WHEN PerformanceRating IN (4, 5) THEN 1
            ELSE 0
        END
    ) AS High_Performers,

    ROUND(
        SUM(
            CASE
                WHEN PerformanceRating IN (4, 5) THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(EmployeeID),
        2
    ) AS High_Performer_Percentage

FROM employees
GROUP BY Department
ORDER BY High_Performer_Percentage DESC;

-- Q9. Departments with Above-Average Tenure
-- Find departments whose average employee tenure
-- is greater than the overall average tenure.

SELECT
    Department,
    ROUND(AVG(Tenure_Years), 2) AS Average_Tenure
FROM employees
GROUP BY Department
HAVING AVG(Tenure_Years) > (
    SELECT AVG(Tenure_Years)
    FROM employees
)
ORDER BY Average_Tenure DESC;


-- Q10. Employees with Above-Average Tenure
-- Find employees whose tenure is greater than
-- the overall average tenure.

SELECT
    EmployeeID,
    Name,
    Department,
    Tenure_Years
FROM employees
WHERE Tenure_Years > (
    SELECT AVG(Tenure_Years)
    FROM employees
)
ORDER BY Tenure_Years DESC;


-- Q11. Employees with Above-Department-Average Tenure

SELECT
    e.EmployeeID,
    e.Name,
    e.Department,
    e.Tenure_Years
FROM employees AS e
WHERE e.Tenure_Years > (
    SELECT AVG(e2.Tenure_Years)
    FROM employees AS e2
    WHERE e2.Department = e.Department
)
ORDER BY
    e.Department,
    e.Tenure_Years DESC;
    
    
    
    -- Q12. Rank Departments by Resignation Count
-- Use a CTE to calculate department-wise resignation counts.
-- Then rank departments from highest to lowest.

WITH Department_Summary AS (
    SELECT
        Department,
        COUNT(*) AS Total_Resignations
    FROM employees
    GROUP BY Department
)
SELECT
    Department,
    Total_Resignations,
    RANK() OVER (
        ORDER BY Total_Resignations DESC
    ) AS Department_Rank
FROM Department_Summary;
    
    
-- Q13. Year-wise Resignation Trend

WITH Yearly_Summary AS (
    SELECT
        ExitYear,
        COUNT(*) AS Total_Resignations
    FROM employees
    GROUP BY ExitYear
)
SELECT
    ExitYear,
    Total_Resignations,
    ROUND(
        Total_Resignations * 100.0 /
        SUM(Total_Resignations) OVER (),
        2
    ) AS Resignation_Percentage
FROM Yearly_Summary
ORDER BY ExitYear;    


-- Q14. Month-wise Resignation Ranking
-- Count resignation records for each month.
-- Rank months by total resignations, highest first.

WITH Monthly_Summary AS (
    SELECT
        ExitMonth,
        COUNT(*) AS Total_Resignations
    FROM employees
    GROUP BY ExitMonth
)
SELECT
    ExitMonth,
    Total_Resignations,
    DENSE_RANK() OVER (
        ORDER BY Total_Resignations DESC
    ) AS Month_Rank
FROM Monthly_Summary
ORDER BY Month_Rank;

-- Q15. Top 3 Employees by Tenure in Each Department

WITH Employee_Ranking AS (
    SELECT
        EmployeeID,
        Name,
        Department,
        Tenure_Years,
        ROW_NUMBER() OVER (
            PARTITION BY Department
            ORDER BY Tenure_Years DESC
        ) AS Employee_Rank
    FROM employees
)
SELECT
    EmployeeID,
    Name,
    Department,
    Tenure_Years,
    Employee_Rank
FROM Employee_Ranking
WHERE Employee_Rank <= 3
ORDER BY Department, Employee_Rank;


-- Q16. Compare Employee Tenure Using LAG()

SELECT
    EmployeeID,
    Name,
    Department,
    Tenure_Years,
    LAG(Tenure_Years) OVER (
        PARTITION BY Department
        ORDER BY Tenure_Years
    ) AS Previous_Employee_Tenure
FROM employees
ORDER BY Department, Tenure_Years;


-- Q17. Yearly Running Total of Resignations

WITH Yearly_Summary AS (
    SELECT
        ExitYear,
        COUNT(*) AS Total_Resignations
    FROM employees
    GROUP BY ExitYear
)
SELECT
    ExitYear,
    Total_Resignations,
    SUM(Total_Resignations) OVER (
        ORDER BY ExitYear
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS Running_Total
FROM Yearly_Summary
ORDER BY ExitYear;



-- Q18. Year-over-Year Resignation Change

WITH Yearly_Summary AS (
    SELECT
        ExitYear,
        COUNT(*) AS Total_Resignations
    FROM employees
    GROUP BY ExitYear
),
Yearly_Comparison AS (
    SELECT
        ExitYear,
        Total_Resignations,
        LAG(Total_Resignations) OVER (
            ORDER BY ExitYear
        ) AS Previous_Year_Resignations
    FROM Yearly_Summary
)
SELECT
    ExitYear,
    Total_Resignations,
    Previous_Year_Resignations,
    Total_Resignations - Previous_Year_Resignations
        AS Yearly_Change,
    ROUND(
        (Total_Resignations - Previous_Year_Resignations)
        * 100.0 / Previous_Year_Resignations,
        2
    ) AS YoY_Change_Percentage
FROM Yearly_Comparison
ORDER BY ExitYear;



-- Q19. Top Department by Resignations Each Year

WITH Department_Yearly AS (
    SELECT
        ExitYear,
        Department,
        COUNT(*) AS Total_Resignations
    FROM employees
    GROUP BY ExitYear, Department
),
Ranked_Departments AS (
    SELECT
        ExitYear,
        Department,
        Total_Resignations,
        RANK() OVER (
            PARTITION BY ExitYear
            ORDER BY Total_Resignations DESC
        ) AS Department_Rank
    FROM Department_Yearly
)
SELECT
    ExitYear,
    Department,
    Total_Resignations
FROM Ranked_Departments
WHERE Department_Rank = 1
ORDER BY ExitYear;


-- Q20. Department Resignation Contribution Analysis

WITH Department_Summary AS (
    SELECT
        Department,
        COUNT(*) AS Total_Resignations
    FROM employees
    GROUP BY Department
),
Department_Percentage AS (
    SELECT
        Department,
        Total_Resignations,
        ROUND(
            Total_Resignations * 100.0 /
            SUM(Total_Resignations) OVER (),
            2
        ) AS Contribution_Percentage
    FROM Department_Summary
)
SELECT
    Department,
    Total_Resignations,
    Contribution_Percentage,
    CASE
        WHEN Contribution_Percentage >= 18 THEN 'High'
        WHEN Contribution_Percentage >= 16 THEN 'Medium'
        ELSE 'Low'
    END AS Contribution_Category
FROM Department_Percentage
ORDER BY Contribution_Percentage DESC;