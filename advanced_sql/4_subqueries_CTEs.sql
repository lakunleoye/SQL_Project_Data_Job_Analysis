SELECT 
    company_id,
    name AS company_name
    FROM company_dim
    WHERE company_id IN 
(
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY
        company_id
)        


/*
Find the companies that have the most job openings.
- Get the total number of job postings per company id
- Return the total number of jobs with the company name
*/

WITH company_job_count AS (
SELECT
    company_id,
    COUNT (*) AS total_jobs
FROM
    job_postings_fact
GROUP BY
    company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id=company_dim.company_id 
ORDER BY
    total_jobs DESC





With job_skills_count AS
(
    SELECT
    skill_id,
    COUNT (*) skills_count
FROM
    skills_job_dim
GROUP BY
    skill_id
)


SELECT 
    skills_dim.skills AS skills,
    job_skills_count.skills_count
FROM
    skills_dim
LEFT JOIN
    job_skills_count ON job_skills_count.skill_id = skills_dim.skill_id



SELECT 
    jobs_count,
    CASE
        WHEN jobs_count < 10 THEN 'small'
        WHEN jobs_count BETWEEN 10 AND 50 THEN 'medium'
        ELSE 'large'
    END AS company_category
FROM (
    SELECT 
        company_id,
        COUNT(company_id) AS jobs_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
    ORDER BY
        jobs_count
) AS subquery;
