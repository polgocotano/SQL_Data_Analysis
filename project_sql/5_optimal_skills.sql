/*
Question: What are the most optimal skills to learn (high demand & high salary)?
 - Identify skills that are in high demand and associated with high salary for data analyst roles
 - Focus on job postings that offer remote work
 - Why? Target skills that offer job security (high demand) and financial benefits (high salary),
    offering strategic insights for career development
*/

with skills_demand as (
    select
        skills_dim.skill_id,
        skills_dim.skills,
        count(*) as demand_count
    from job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
    inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
    where job_title_short = 'Data Analyst'
    and job_postings_fact.salary_year_avg is not NULL
    and job_postings_fact.job_work_from_home = TRUE
    group by skills_dim.skills, skills_dim.skill_id
),

    average_salary as (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        round(avg(salary_year_avg),0) as avg_skill_salary
    from job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
    inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
    where job_postings_fact.job_title_short = 'Data Analyst' 
    and job_postings_fact.salary_year_avg is not NULL
    and job_postings_fact.job_work_from_home = TRUE
    group by skills_dim.skills, skills_dim.skill_id
    order by avg_skill_salary DESC
)

select 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_skill_salary
from skills_demand
inner join average_salary on skills_demand.skill_id=average_salary.skill_id
where demand_count > 10
order by avg_skill_salary DESC, demand_count desc
limit 25;



------rewrite it without using CTEs

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    count(job_postings_fact.job_id) as demand_count,
    round(avg(job_postings_fact.salary_year_avg),0) as avg_Skill_salary
from job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where job_postings_fact.job_title_short = 'Data Analyst' 
    and job_postings_fact.salary_year_avg is not NULL
    and job_postings_fact.job_work_from_home = TRUE
group by skills_dim.skill_id,skills_dim.skills
having count(job_postings_fact.job_id) > 10
order by avg_skill_salary DESC, demand_count desc
limit 25;