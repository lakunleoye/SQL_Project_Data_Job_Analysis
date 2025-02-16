SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY   
    location_category;

/*
Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' as 'Local'
- Otherwise 'Onsite'
*/


SELECT
    salary_year_avg,
    CASE
        WHEN salary_year_avg < 100000 THEN 'low salary'
        WHEN salary_year_avg BETWEEN 100000 AND 200000 THEN 'standard salary'
        ELSE 'high salary'
    END AS
        salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;


/*
Label new column as follows:
- 'salary < 100000' jobs as 'low salary'
- 'salary between 100000 and 200000' as 'standard salary'
- Otherwise 'high salary'
*/