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
- **Power BI** - a desktop application that can create visualizations such as graphs.


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

![Top Paying Roles](Assets\salary_top_10_jobs.png)


### 2. Skills required for these top-paying jobs
To identify the skills associated with the top paying jobs for Data Analytics in 2023, I joined the job postings with the skills data, providing insights as to what employers value for high compensation roles. 

```sql
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
```

Here's the breakdown of the skills required for these top paying jobs:
- SQL is the most in-demand skill, appearing in 8 job postings.
- Python, Tableau, and R are also highly sought after, each appearing at 4-7 times.
- Excel, Pandas, and Snowflake have moderate demand, showing up in 3 job postings.
- AWS, Azure, Power Bi, Jupyter appear less frequently, indicating they are required for fewer roles.
- A mix of programming, cloud, and BI tools is essential for top-paying data analyst roles.

![Skills from Top Paying Roles](Assets\top_paying_skills.png)



## 3. Top 5 skills most in-demand for data analysts
To identify the skills across all the Data Analyst job postings, I joined the job postings with the skills job and the skills table, grouping the results by skill name.

```sql
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
```

| Skills   | Total  |
|----------|--------|
| SQL      | 92,628 |
| Excel    | 67,031 |
| Python   | 57,326 |
| Tableau  | 46,554 |
| Power BI | 39,468 |



## 4. Skills that are associated with higher salaries
To identify the skills associated with higher salaries, I filtered Data Analyst positions from all locations offering remote jobs that includes salary information. Results were grouped by skills and the yearly salary averaged.

```sql
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
```

Based on the salary data, several key trends emerge regarding the highest-paying skills for data analysts:

- Advanced Tools & Programming Languages: Higher salaries are associated with specialized data processing tools (e.g., PySpark, DataRobot) and programming languages (e.g., Bitbucket, Swift).
- Data Processing & Analysis Skills: Proficiency in data analysis libraries (e.g., Pandas, Jupyter) and version control systems (e.g., GitLab, Bitbucket) is well-compensated.
- Big Data, Cloud Platforms, & Database Management: Knowledge of big data platforms (e.g., Databricks), cloud platforms (e.g., GCP), and database management systems (e.g., Couchbase, PostgreSQL) leads to competitive salaries.

![Top Paying Roles](Assets\skills_associated_high_salary.png)


## 5. Most optimal skills to learn as a Data Analyst
Combining insights from demanded skills and salary data, this query shows skills that are both in high demand and high salary, offering a strategic focus for skill development.

| skill_id | skills     | demand_count | avg_skill_salary |
|----------|------------|--------------|------------------|
| 8        | Go         | 27           | 115320           |
| 234      | Confluence | 11           | 114210           |
| 97       | Hadoop     | 22           | 113193           |
| 80       | Snowflake  | 37           | 112948           |
| 74       | Azure      | 34           | 111225           |
| 77       | Bigquery   | 13           | 109654           |
| 76       | Aws        | 32           | 108317           |
| 4        | Java       | 17           | 106906           |
| 194      | Ssis       | 12           | 106683           |
| 233      | Jira       | 20           | 104918           |
| 79       | Oracle     | 37           | 104534           |
| 185      | Looker     | 49           | 103795           |
| 2        | Nosql      | 13           | 101414           |
| 1        | Python     | 236          | 101397           |
| 5        | R          | 148          | 100499           |

Here'sa breakdown of the optimal skills for Data Analysts in 2023.
- High Demand, High Salary: Go, Snowflake, Azure. These skills have both high demand and salaries, indicating strong market value.
- High Demand, Moderate Salary: Python, R, Looker. These skills are highly in demand but have moderate salaries, possibly due to widespread use and availability of skilled professionals.
- Low Demand, High Salary: Confluence, Bigquery, SSIS. These skills have lower demand but command high salaries, suggesting they are specialized and less common.
- Moderate Demand, Competitive Salary: Java, Jira, Hadoop. These skills have moderate demand and competitive salaries, reflecting their stable market presence.

Overall, skills like Python and R are extremely popular, while specialized skills like Go and Confluence command higher salaries. Balancing market demand with salary potential can help guide career decisions effectively.

# Learnings gained from this project

Throughout this project, I've enhanced my SQL skills and learned to use other applications to add in my toolkit as a future Data Analyst.

- **Intermediate to advance query crafting:** creating advance SQL queries, merging up to three tables using join statements, utilizing with clauses to create temporary tables.

- **Data Aggregation:** comfortably utilizing count() and avg() along with group by to summarize data.

- **Data analysis:** developed problem solving skills, turning questions into actionable and insightful queries.

# Closing Thoughts
This project enhanced by SQL skills, learned how to use Visual Studio Code along with Postgres, as well as Github/Git to make this project available online for collaboration purposes. It also helped me gain insight into the Data Analyst job market, gaining knowledge on the skills to learn which are in high demand and offers high salary. This exploration shows the importance of continuous learning and adaptation to emerging trends in the field of data analytics.