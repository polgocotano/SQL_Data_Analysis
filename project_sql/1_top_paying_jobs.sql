/*
Question: What are the top paying data analyst jobs?
 - Identify the top 10 highest paying Data Analyst roles that are available remotely.
 - Focus on job postings with specified salaries (remove nulls).
 - Why? Highlight the top paying opportunities for Data Analysts
*/

select 
    job_id,
    job_title,
    name as company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
from job_postings_fact
left JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id
where 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg is not null
order by salary_year_avg DESC
limit 10;

