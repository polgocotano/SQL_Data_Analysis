/*
Question: What are the top skills based on salary?
 - Look at the average salary associated with each skill for data analyst positions
 - Focus on roles with specified salaries regardless of location
 - Focus on job postings that offer remote work
 - Why? It reveals how different skills impact salary levels for data analysts, 
    identifying the most financially rewarding skills to acquire
*/


SELECT
    skills_dim.skills,
    round(avg(salary_year_avg),0) as avg_skill_salary
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
where job_postings_fact.job_title_short = 'Data Analyst' 
    and job_postings_fact.salary_year_avg is not NULL
    and job_postings_fact.job_work_from_home = TRUE
group by skills_dim.skills
order by avg_skill_salary DESC
limit 25;

/*
Insights into Top-Paying Skills for Data Analysts
Based on the salary data, several key trends emerge regarding the highest-paying skills for data analysts:

- Big Data, AI/ML, and Cloud Skills Lead Salaries – High-paying roles demand expertise in PySpark, Databricks, Watson, and GCP, reflecting the industry's shift toward large-scale data processing and AI-driven analytics.
- DevOps, Automation, and Workflow Tools Are Critical – Bitbucket, GitLab, Airflow, Kubernetes, and Jenkins highlight the growing need for data pipeline automation, version control, and cloud-native workflows.
- Programming and Database Skills Remain Valuable – Knowledge of Python libraries (Pandas, NumPy, Scikit-learn), NoSQL databases (Couchbase, Elasticsearch), and functional languages (Scala, Golang, Swift) continues to drive competitive salaries.