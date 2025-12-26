# Data Quality & Business Health Monitoring Dashboard

## Project Overview
In many organizations, business decisions rely heavily on reports and dashboards. However, if the underlying data is inconsistent or unreliable, even well-designed reports can lead to poor decisions. To understand this problem better, I worked on a Data Quality & Business Health Monitoring project.

This project focuses on **data quality assessment** by identifying issues in customer and order data that can impact reporting, revenue analysis, and decision-making.

---

## Objective
The main objectives of this project are:
- To evaluate the **reliability of business-critical data**
- To detect **missing, invalid, and inconsistent records**
- To classify data issues based on **business risk**
- To present findings in a **business-friendly dashboard**

---

## Datasets Used
The project uses two datasets:

### 1️⃣ Customers Dataset
Contains customer-level information such as:
- Customer ID  
- Email  
- Phone number  
- Country  
- Signup date  
- Customer status  

### 2️⃣ Orders Dataset
Contains transactional data such as:
- Order ID  
- Customer ID  
- Order date  
- Order amount  
- Payment method  
- Order status  

> These datasets intentionally include **data quality issues** to simulate real-world scenarios.

---

## Business Rules & Data Quality KPIs
Business rules were defined to determine what constitutes **valid data**.

### Key Data Quality Checks:
- Missing values  
- Invalid values  
- Duplicate records  
- Referential integrity issues (orders without valid customers)  
- Logical validations (future dates, negative amounts)  

Each issue was classified into:
- **High Risk** – Direct impact on revenue and financial reporting  
- **Medium Risk** – Impacts analysis, trends, and operations  
- **Low Risk** – Minimal or no immediate business impact  

---

## SQL Analysis
SQL (MySQL) was used to:
- Validate data against defined business rules  
- Calculate issue counts for each KPI  
- Identify high-impact data quality problems  


---

## Excel Dashboard
An interactive dashboard was created using **Excel (Web version)** to visualize:
- Total data quality issues  
- Issues by risk level  
- Table-wise impact (Customers vs Orders)  
- KPI-level breakdown of data problems  

The dashboard is designed for **non-technical stakeholders** to easily understand data health without reading SQL queries.

---

## Key Insights
- The **Orders dataset contains the highest number of High-Risk issues**
- Orders with **invalid customer IDs** pose a serious business risk as they:
  - Distort revenue calculations  
  - Break customer-order relationships  
  - Lead to unreliable financial and performance reports  

---

## Business Value
This project helps organizations:
- Identify **where data issues originate**
- Prioritize **which data problems to fix first**
- Improve **trust in reports and dashboards**
- Reduce the risk of **poor business decisions**

---

## Tools Used
- **SQL (MySQL)** – Data validation & KPI calculation  
- **Excel (Web)** – Pivot tables, charts, and dashboard visualization  

---

## Dashboard Preview
![Data Quality Dashboard](Data%20Quality%20Project/Data%20Quality%20Dashboard/Data%20Quality%20Dashboard.png)

---


