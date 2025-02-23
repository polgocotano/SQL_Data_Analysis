/*
Question: What skills are required for the top paying data analyst jobs?
 - Use the top 10 highest paying jobs from the first query
 - Identify the specific skills required for these roles
 - Why? It provides a detailed look on which high paying jobs require certain skills,
    helping job seekers identify the skills to develop that alight with top salaries.

*/


with top_jobs as (
    select 
        job_id,
        name as company_name,
        job_location,
        salary_year_avg
    from job_postings_fact
    left JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id
    where 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg is not null
    order by salary_year_avg DESC
    limit 10
)

select
    top_jobs.*,
    skills_dim.skills
from top_jobs
inner join skills_job_dim on top_jobs.job_id=skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
order by salary_year_avg DESC


/*
Breakdown of the most demanded skills for data analyst in 2023, based on job postings:
- SQL is the most in-demand skill, appearing in 8 job postings.
- Python, Tableau, and R are also highly sought after, each appearing at 4-7 times.
- Excel, Pandas, and Snowflake have moderate demand, showing up in 3 job postings.
- AWS, Azure, Power Bi, Jupyter appear less frequently, indicating they are required for fewer roles.
- A mix of programming, cloud, and BI tools is essential for top-paying data analyst roles.
*/