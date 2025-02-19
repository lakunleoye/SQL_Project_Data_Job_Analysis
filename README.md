# Introduction
This project investigated the data job market with a focus on data analyst roles in the UK. In particular, the top-paying jobs, in-demand skills, and optimal skills were explored.

See my SQL queries here: [project_sql folder](/project_sql/)

# Background
This project is a product of my quest to understand the Data Analytics job market, research the top-paid and in-demand skills, and ultimately land an optimal role. The data used for the project was sourced from [SQL course](https://www.lukebarousse.com/sql).It contains information about job titles, salaries, locations, and essential skills.

### Research Questions:
1. What are the top-paying data analyst job?
2. What skills are required for the top-paying jobs?
3. What skills are most in-demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools Employed
- **SQL:** As the main tool used for this study, SQL allowed me to query the database and pullout critical insight.  
- **PostgreSQL:**  is my chosen database management system (DBMS)
- **Visual Studio Code:** This is my choice for database management and query execution
- **Git & GitHub:** I used this for version cotrol and SQL scripts & analysis sharing, ensuring collaboration and project tracking.

# Analysis

### 1. Top Paying Data Analyst Jobs
To achieve this, I filtered data analyst positions by average yearly salary and location, with a focus on jobs in the United Kingdom. This query highligts the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'United Kingdom' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10
```
Findings for the top data analysts job in the UK in 2023:
- **Wide Salary Range:** Top 10 data analyst roles span from $75000 to $180000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like Deutsche Bank, Shell, and Syngenta Group are among the highest paying, showing a broad interest across industries.
- **Job Title Variety:** High diversity in job title, from Market Data Lead Analyst to Global IT Data Analytics Solutions Expert, reflecting varied roles and specialisations within data analytics.

![output](https://github.com/user-attachments/assets/2e2da651-0fd1-46a8-b55f-59a5ecfd733d)
*Bar graph visualising the salary for the top 10 salaries for data analysts in the UK in 2023; The graph was generated using Matplotlib on Python using a code written by ChatGPT for my SQL query results*

### 2. Skills for Top Paying Jobs
To answer this question, I combined the job postings with the skills data to provide insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'United Kingdom' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT
        10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```


This is the breakdown of the most demanded skills for the top 10 highest paying data analysts jobs in the UK in 2023:

- **Python** is leading with a count of 5.
- **Excel** is also tied with Python at 5.
- **Tableau** is highly sought after at 3.
- **SQL** is tied with Tableau at 3.


![output_2](https://github.com/user-attachments/assets/a29491b2-eb5e-45ce-a836-fe0155f9ec1d)
*Bar graph visualising the count of skills for top 10 paying data analysts jobs in the UK in 2023; The graph was generated using Matplotlib on Python using a code written by ChatGPT for my SQL query results*



### 3. In-Demand Skills for Data Analysts
This query was used to extract information about the most frequently requested skills in job postings for Data Analyst jobs in the UK in 2023.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'United Kingdom'
GROUP BY  
    skills
ORDER BY
    demand_count DESC
LIMIT
    5
```
This is the breakdown of the most demanded skills for Data Analysts in the UK in 2023.

- **Data Processing Tools** like **SQL** and **Excel** are the  most demanded skills showing the importance of this foundational skills.

- **Programming** and **Visualisation Tools** like **Power BI**, **Python**, and **Tableau** are also in high demand, showing the increasing importance of technical skills in data storytelling and decision support. 



| Skills    | Demand Count |
|-----------|--------------|
| sql       | 867          |
| excel     | 776          |
| power bi  | 557          |
| python    | 455          |
| tableau   | 361          |
*Table showing top 5 in-demand skills in data analyst job postings in the UK in 2023*


### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed the highest paying skills.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'United Kingdom'
GROUP BY  
    skills
ORDER BY
    avg_salary DESC
LIMIT
    10;
```

- **Software Development and Deployment Proficiency:** Highest salaries are commanded by analysts skilled in software development tools like Flow and Shell. Those skilled in Express, Git, and Unify also command fairly high salaries thus indicating a lucrative crossover between Analysis and Engineering roles.
- **Data Integration, Analysis, and Reporting** Familiarity with analysing, visualisation and advanced statistical tools like SAS and Looker can also lead to higher compensations.
- **Big Data & ML** and **Cloud Computing Expertise:** knowlegde of Large Data Transformation & Machine Learning tools and Cloud-based technologies like Jupyter, Azure, and SAP can also significantly boost earning potentials in data analytics.



| Skills   | Average Salary ($) |
|----------|----------------|
| flow     | 156500         |
| shell    | 156500         |
| looker   | 118140         |
| sas      | 109000         |
| express  | 104757         |
| jupyter  | 103620         |
| git      | 89100          |
| unify    | 89100          |
| azure    | 86400          |
| sap      | 86400          |
*Table showing average salaries for top 10 paying skills for data analysts in the UK in 2023.*

### 5. Most Optimal Skills to Learn
This query was used to identify skills that are both in high demand and have high salaries, to offer a guide on skill development pathway for Data Analysts.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL AND
    job_postings_fact.job_location = 'United Kingdom'
GROUP BY  
    skills_dim.skill_id, skills_dim.skills
ORDER BY   
    demand_count DESC, avg_salary DESC
LIMIT 10
```

| Skill ID | Skills    | Demand Count | Average Salary |
|----------|-----------|--------------|----------------|
| 181      | Excel     | 11           | $82,494        |
| 1        | Python    | 8            | $83,968        |
| 0        | SQL       | 8            | $65,818        |
| 182      | Tableau   | 5            | $78,428        |
| 183      | Power BI  | 3            | $74,563        |
| 188      | Word      | 3            | $46,171        |
| 198      | Outlook   | 3            | $46,171        |
| 141      | Express   | 2            | $104,757       |
| 102      | Jupyter   | 2            | $103,620       |
| 5        | R         | 2            | $81,709        |
*Table showing the most optimal skills sorted by salary for Data Analysts in the UK in 2023*

These are the most optimal skills for Data Analysts in the UK in 2023: 

- **High-Demand data processing Tools:** Excel amd SQL stand out with their high demand of 11 and 8. Despite being high demand these skills still attract average salaries around $82,494 and $65,818 - an indication that these skills are highly valued.

- **High-Demand Programming Languages:** Although Python and R made the top ten, the former has higher demand and higher salary of 11 and $83,968 compare to the latters 2 and $81,709. The high demand and high salaries are indications that these languages are highly valued but also widely available.

- **Business Intelligence and Visualisation Tools:** Tableau and Power BI are also in high demand, with counts of 5 and 3, and average salaries of $78,428 and 74,563. This highlights the critical and valuable role of data business intelligence and data visualisaion in deriving actionale insights from data.


# What I Learned
Through this project, I developed my SQL skills to high level. 

- **Complex Query Crafting:** Mastered the act of Advanced SQL, merging tables and using WITH clauses for high-level temporary table manipulation. 
- **Data Aggregation:** Proficient use of GROUP BY for turning aggregate functions like COUNT () and AVG () into my frequent data-summarisers.
- **Analytical Skills:**  I developed advanced critical thinking skills and was able to turn questions into actionable, insightful SQL queries.


# Conclusions
### insights
1. **Top-Paying Data Analyst Jobs**: Highest paying Data Analyst jobs in the UK offer wide range of salary, with the highest at $180,000.
2. **Skills for Top-Paying Jobs**: High-paying Data Analyst jobs in the UK require advance proficiency, mostly in Python and Excel, and to some extent, SQL and Tableau.
3. **Most In-Demand Skills**: SQL is the most demanded skill in the UK's Data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Software Development and Deployment Proficiency tools like Flow and Shell are associated with highest average salries, indicating a premium on crossover skills.
5. **Optimal Skills for Job Market Value**: Excel and Python are the most optimal skills as they lead when demand and average salaries are considered. Hence, data analysts must learn these skills to maximise their value.


