# Employee Resignation Analytics

## Project Overview

This project analyzes 5,000 employee resignation records to identify patterns and trends across departments, age groups, resignation reasons, employee tenure, performance ratings, and resignation years.

The objective is to transform raw employee resignation data into meaningful insights using Excel, Python, SQL, and Power BI.

## Business Objectives

- Analyze resignation patterns across different departments.
- Identify the most frequently recorded resignation reasons.
- Examine resignation trends across age groups and years.
- Analyze employee tenure and performance ratings.
- Build an interactive Power BI dashboard to present key findings.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| Microsoft Excel | Data analysis and visualization |
| Python (Pandas) | Data cleaning, manipulation, and analysis |
| MySQL | Data querying and business analysis |
| Power BI | Interactive dashboard and data visualization |

## Dataset Overview

- **Total Records:** 5,000
- **Total Columns:** 16
- **Departments:** 6
- **Job Roles:** 13
- **Resignation Reasons:** 5

### Key Features

The dataset includes employee information such as:

- Employee ID, Name, Gender, and Age
- Department and Job Role
- Date of Joining and Date of Exit
- Performance Rating
- Resignation Reason
- Employee Tenure
- Age Group and Tenure Band
- Exit Year and Exit Month

## Project Workflow

### 1. Excel Analysis
- Explored and analyzed employee resignation data.
- Used Excel formulas and analytical features to summarize resignation patterns.
- Created summaries and visualizations.

### 2. Python Analysis (Pandas)
- Inspected dataset structure and data types.
- Checked for missing values and duplicate records.
- Performed exploratory data analysis (EDA).
- Analyzed resignation patterns using grouping and aggregation.
- Generated summary tables for further analysis.

### 3. SQL Analysis (MySQL)
- Created a database and imported the cleaned dataset.
- Performed data validation.
- Used aggregate functions, GROUP BY, and HAVING.
- Applied subqueries and correlated subqueries.
- Used window functions such as RANK(), LAG(), and running totals.
- Analyzed department-wise, year-wise, and reason-wise resignation patterns.

### 4. Power BI Dashboard
- Created KPI cards for key metrics.
- Developed department-wise and age-group visualizations.
- Analyzed yearly resignation trends.
- Visualized resignation reasons using a donut chart.
- Added interactive slicers for Department, Gender, Resignation Reason, and Exit Year.

## Key Findings

- **Total Resignation Records:** 5,000
- **Highest Department Count:** Finance (878)
- **Most Frequently Recorded Resignation Reason:** Better Opportunity (1,017)
- **Highest Resignation Count by Age Group:** 41–50 years (1,325)
- **Highest Resignation Year:** 2024 (611)
- **Average Recorded Employee Tenure:** 6.47 years
- **Average Performance Rating:** 2.97

## Dashboard

The Power BI dashboard provides an interactive overview of employee resignation patterns through KPI cards, charts, and slicers.

Dashboard screenshots are available in the `powerbi_dashboard/dashboard_screenshots/` folder.

## Project Structure

```text
Employee-Resignation-Analytics/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── excel_analysis/
│
├── pandas_analysis/
│   ├── Employee_Resignation_Analysis.ipynb
│   └── analysis_results/
│
├── sql_analysis/
│   ├── 01_database_setup.sql
│   └── 02_business_analysis.sql
│
├── powerbi_dashboard/
│   ├── Employee_Resignation_Dashboard.pbix
│   └── dashboard_screenshots/
│
├── README.md
└── requirements.txt
```

## Important Data Limitation

This dataset contains only employees who resigned. Total workforce data is unavailable; therefore, actual employee attrition rates cannot be calculated.

The findings represent patterns among the 5,000 recorded resignation cases and should not be interpreted as evidence of causation or individual employee resignation risk.

## Conclusion

This project demonstrates an end-to-end data analytics workflow, combining Excel, Python, SQL, and Power BI to explore employee resignation patterns and communicate data-driven findings through an interactive dashboard.

## Author

**Ritesh Raj**

- GitHub: https://github.com/RiRa-si
- LinkedIn: https://www.linkedin.com/in/ritesh-raj-6259b9328/


