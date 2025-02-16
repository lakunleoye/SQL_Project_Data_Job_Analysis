SELECT
    COUNT(job_id) AS job_count,
    --job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
   -- EXTRACT(MONTH FROM job_posted_date) AS date_month 
FROM
    job_postings_fact;
--GROUP BY
    date_month
--ORDER BY
    --date_month;



-- January
CREATE TABLE january_jobs AS
    SELECT *
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE february_jobs AS
    SELECT *
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
    SELECT *
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

