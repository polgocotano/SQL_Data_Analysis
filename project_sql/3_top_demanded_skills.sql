/*
Question: What are the most in-demand skills for data analysts?
 - Join job postings to skills tables similar to query 2
 - Identify the top 5 in-demand skills
 - Focus on all job data analyst postings from all locations
 - Why? Retrieve the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers.

*/


select
    skills_dim.skills,
    count(*) as total
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
where job_title_short = 'Data Analyst'
group by skills_dim.skills
order by total DESC
limit 5;


