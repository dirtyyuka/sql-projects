--select distinct cities which starts with vowels and end with vowels
SELECT DISTINCT
    City
FROM
    Station
WHERE
    (City LIKE 'a%' OR
    City LIKE 'e%' OR
    City LIKE 'i%' OR
    City LIKE 'o%' OR
    City LIKE 'u%') 
AND
    (City LIKE '%a' OR
    City LIKE '%e' OR
    City LIKE '%i' OR
    City LIKE '%o' OR
    City LIKE '%u');


--select japanese cities only
SELECT 
    id,
    name,
    countrycode,
    district,
    population
FROM   
    City
WHERE 
    countrycode = 'JPN';

--select two cities, one with minimum length and other with maximum length
SELECT
    City,
    LENGTH(City)
FROM
    Station
ORDER BY
    LENGTH(City), city
LIMIT 1;
SELECT
    City,
    LENGTH(City)
FROM
    Station
ORDER BY
    LENGTH(City) DESC, city
LIMIT 1;



