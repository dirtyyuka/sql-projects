--return second highest salary among the employees, if not then null
WITH SalaryRanked AS (
    SELECT
        id,
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS rank
    FROM
        Employee
)

SELECT
    COALESCE(
        (SELECT salary FROM SalaryRanked WHERE rank = 2 LIMIT 1), --limit 1 explicitly tells to return a row hence able to return null
        NULL
    ) AS SecondHighestSalary;