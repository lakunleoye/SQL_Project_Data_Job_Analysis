-- Get jobs and companies from January
SELECT 
    job_title_short,
    company_id,
    job_location
FROM   
    january_jobs

UNION

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

-- Get jobs and companies from March
UNION
    
SELECT   
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs


--UNION ALL
-- Get jobs and companies from January
SELECT 
    job_title_short,
    company_id,
    job_location
FROM   
    january_jobs

UNION ALL

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

-- Get jobs and companies from March

UNION ALL
    
SELECT   
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs



-- PRACTICE PROBLEM
WITH q1_jobs_postings AS (
    -- Get jobs and salaries from January
    SELECT 
        job_title_short,
        job_id,
        salary_year_avg
    FROM   
        january_jobs
    WHERE
        salary_year_avg > 70000

    UNION ALL

    -- Get jobs and salaries from February
    SELECT
        job_title_short,
        job_id,
        salary_year_avg
    FROM
        february_jobs
    WHERE
        salary_year_avg > 70000

    -- Get jobs and salaries from March

    UNION ALL

    SELECT   
        job_title_short,
        job_id,
        salary_year_avg
    FROM
        march_jobs
    WHERE
        salary_year_avg > 70000
),

q1_jobs_skills AS (
    SELECT
        skills_job_dim.job_id,
        skills_dim.type AS skills_type,
        skills_dim.skills
    FROM
        skills_dim
    LEFT JOIN skills_job_dim ON skills_job_dim.skill_id = skills_dim.skill_id
)


SELECT
    q1_jobs_postings.job_title_short,
    salary_year_avg,
    q1_jobs_skills.skills,
    q1_jobs_skills.skills_type
FROM   
    q1_jobs_postings
LEFT JOIN q1_jobs_skills ON q1_jobs_skills.job_id = q1_jobs_postings.job_id
ORDER BY
    salary_year_avg;



