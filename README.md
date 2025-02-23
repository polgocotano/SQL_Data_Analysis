# Introduction
📊 Dive in to the data job market. This project explores top paying jobs, in-demand skills, and where high demand meets high salary in Data Analytics. 

🔍 SQL Queries? Check them out here: [project_sql folder](/project_sql/)

# Background
To navigate the data analytics job market effectively, this project helps pinpoint the top-paid and in-demand skills to find optimal jobs.

Data is from an online [SQL course](https://lukebarousse.com/sql) that includes insights on job titles, salaries, locations, and essential skills.

### The questions asked that were answered through the SQL queries were:

1. What are the top-paying Data Analyts jobs?
2. What are the skills required for these top-paying jobs?
3. What skills are most in-demand for Data Analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools Used
To dive into the Data Analyst job market, I've learned to use the following tools:

- **SQL** - the main tool for the analysis, allowing me to query the database and uncover insights.
- **Postgres** - the chosen database management system, ideal for handling job posting data.
- **Visual Studio Code** - code editor for executing SQL queries.
- **Github / Git** - for version control and for sharing the SQL queries and analysis online.

# The Analysis
Each query for this project aimed at investigating specific aspects of the Data Analyst job market.  Here's how the following questions were approached:

### 1. Top-paying Data Analyts jobs
To identify the top paying roles, I filtered Data Analyst positions by location and average yearly salary, focusing on remote jobs. 

```sql
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
```

Here's the breakdown of the top Data Analyst jobs in 2023:
- Director and senior roles command higher salaries, while analyst roles have a wide salary range between $184,000 to $650,000.
- A significant number of jobs were posted in mid-to-late 2023, suggesting a steady demand for data professionals.
- Data analysis and leadership roles remain in high demand, with positions posted throughout 2023.



### 2. Skills required for these top-paying jobs
3. What skills are most in-demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Insights and Learnings
# Conclusion 
