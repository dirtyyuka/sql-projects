/*Note: There are multiple ways to perform these queries so if you come up with another way, do try it */

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

Input:
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

--query to find employees who have the highest salary in each of the departments
Create table Employee (id int, name varchar(255), salary int, departmentId int);
Create table Department (id int, name varchar(255));
insert into Employee (id, name, salary, departmentId) values ('1', 'Joe', '70000', '1');
insert into Employee (id, name, salary, departmentId) values ('2', 'Jim', '90000', '1');
insert into Employee (id, name, salary, departmentId) values ('3', 'Henry', '80000', '2');
insert into Employee (id, name, salary, departmentId) values ('4', 'Sam', '60000', '2');
insert into Employee (id, name, salary, departmentId) values ('5', 'Max', '90000', '1');
insert into Department (id, name) values ('1', 'IT');
insert into Department (id, name) values ('2', 'Sales');

With RankedEmployees AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (PARTITION BY d.name ORDER BY e.salary DESC) AS rank
    FROM
        Employee e
    LEFT JOIN
        Department d ON e.departmentId = d.id
    GROUP BY
        d.name,
        e.name,
        e.salary
)
SELECT 
    Department,
    Employee,
    Salary
FROM
    RankedEmployees
WHERE
    rank = 1; 

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+

