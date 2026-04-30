# Car-Sales-Analysis
This project is meant to provide key insights for the Head of Sales
https://brightwatch-chronicles.lovable.app/

👤 Lesego Putsoa
👤 Title: Data Analyst
🌐 Digital CV: https://bright-glow-showcase.lovable.app
🔗 LinkedIn: https://linkedin.com/in/lesego-putsoa-6ab3792b
🐙 GitHub: https://github.com
📧 Email: llputsoa@gmail.com
📞 Mobile: 073 507 8499

## 🚗 Bright Motors – Car Sales Analysis Dashboard
📌 Project Overview
This project analyses historical vehicle sales data for Bright Motors to support decision-making for a newly appointed Head of Sales.
The goal is to uncover revenue drivers, customer preferences, and sales trends, and present them through an interactive dashboard and an executive-ready presentation.

🎯 Objectives

Identify top-performing car makes and models
Understand customer preferences by vehicle body type
Analyse sales performance over time (yearly & monthly)
Explore the relationship between price, mileage, and manufacture year
Provide actionable recommendations to improve revenue, profitability, and inventory planning

🗂 Dataset

Source: Bright Motors Car Sales Dataset
Granularity: Vehicle-level transactional data
Key fields:

VIN, Sale Date, Make, Model
Manufacture Year, Body Type, Region
Selling Price, Cost Price (MMR), Odometer

🛠 Tools & Technologies

Databricks SQL – Data cleaning, transformation, and calculations
Google Looker Studio – Interactive dashboard and visual analytics
PowerPoint – Executive presentation of insights
GitHub – Version control and project documentation


⚙️ Data Preparation (Databricks SQL)
Key steps performed:

Validated record counts and removed duplicates using VIN
Handled missing values and inconsistent data
Converted text fields to numeric types (prices, mileage)
Extracted time dimensions (sale year, sale month)
Created analytical fields:

total_revenue
total_profit
profit_margin_percentage
profit_margin_tier (High / Medium / Low)

The resulting dataset is dashboard-ready and optimised for analysis.

📊 Key Insights

Revenue Concentration: A small number of car makes generate the majority of total revenue
Customer Preferences: Sedans dominate demand, followed by SUVs
Seasonality: Sales peak strongly in December, indicating clear seasonal behaviour
Product Focus: Specific models outperform others and drive most revenue


✅ Recommendations

Prioritise top revenue car makes and models for dealership expansion
Align inventory planning with dominant body types (Sedan & SUV)
Prepare stock and marketing campaigns ahead of peak seasonal demand
Replicate pricing strategies from high-margin vehicles
Use insights to improve regional and operational efficiency

📈 Deliverables

📊 Interactive Google Looker Studio Dashboard
📑 Executive PowerPoint Presentation with insights and recommendations
🧾 SQL scripts for data cleaning and analysis
