# AI SaaS Analytics Using MySQL

> A relational database and business analytics project for analyzing AI SaaS customers, subscriptions, revenue, AI platform usage, payments, and customer support operations using MySQL.

---

## 📌 Project Overview

**AI SaaS Analytics Using MySQL** is a database-driven analytics project designed to simulate a modern Artificial Intelligence Software-as-a-Service (AI SaaS) business environment.

The system stores and analyzes data related to:

- Customers and companies
- SaaS subscription plans
- Customer subscriptions
- Payments and revenue
- AI platform usage
- Customer support tickets

The project demonstrates how **MySQL and advanced SQL** can be used to transform structured business data into meaningful insights for decision-making.

---

## 🎯 Project Objectives

The main objectives of this project are to:

- Design a normalized relational database for an AI SaaS business.
- Manage customer and company information.
- Track SaaS subscription plans and customer subscriptions.
- Analyze payment transactions and revenue.
- Measure AI platform usage and customer engagement.
- Analyze customer support activity.
- Implement advanced SQL analytics.
- Improve database performance using indexes.
- Maintain data integrity using constraints and triggers.
- Create reusable analytical views and stored procedures.
- Build a professional database structure suitable for real-world analytics scenarios.

---

## 💼 Business Problem

AI SaaS platforms generate large volumes of operational data from customers, subscriptions, payments, AI usage, and support activities.

Without a structured database and analytical layer, it becomes difficult to answer important business questions such as:

- Who are the highest-value customers?
- Which subscription plan generates the most revenue?
- Which industries use AI services the most?
- How much revenue does the company generate?
- Which customers have the highest AI engagement?
- What are the most common support issues?
- Which customers generate multiple support tickets?
- What is the payment success rate?
- Which industry contains the highest-revenue customer?
- How effectively are customers using the AI platform?

This project addresses these questions using a structured MySQL database and business-focused SQL analysis.

---

# 🏗️ System Architecture

The database consists of six core entities:

```text
Customers
    |
    ├────────────── Subscriptions ────────────── Plans
    |                       |
    |                       |
    |                    Payments
    |
    ├────────────── AI Usage
    |
    └────────────── Support Tickets
````

### Relationship Overview

* One customer can have multiple subscriptions.
* One subscription belongs to one customer.
* One subscription is associated with one subscription plan.
* One subscription can have multiple payment records.
* One customer can have multiple AI usage records.
* One customer can create multiple support tickets.

---

# 🗄️ Database Schema

## Customers

Stores customer and company information.

| Column        | Description                          |
| ------------- | ------------------------------------ |
| customer_id   | Unique customer identifier           |
| customer_name | Customer name                        |
| email         | Customer email                       |
| company_name  | Company associated with the customer |
| industry      | Customer industry                    |
| country       | Customer country                     |
| signup_date   | Customer registration date           |

---

## Plans

Stores available SaaS subscription plans.

| Column        | Description                      |
| ------------- | -------------------------------- |
| plan_id       | Unique plan identifier           |
| plan_name     | Subscription plan name           |
| billing_cycle | Billing frequency                |
| monthly_price | Monthly subscription price       |
| user_limit    | Maximum supported users          |
| ai_features   | AI features included in the plan |

---

## Subscriptions

Tracks customer subscription activity.

| Column              | Description                    |
| ------------------- | ------------------------------ |
| subscription_id     | Unique subscription identifier |
| customer_id         | Customer reference             |
| plan_id             | Subscription plan reference    |
| start_date          | Subscription start date        |
| end_date            | Subscription end date          |
| subscription_status | Current subscription status    |

---

## Payments

Stores customer payment transactions.

| Column          | Description               |
| --------------- | ------------------------- |
| payment_id      | Unique payment identifier |
| subscription_id | Subscription reference    |
| payment_date    | Payment transaction date  |
| amount          | Payment amount            |
| payment_method  | Payment method            |
| payment_status  | Payment result            |

---

## AI Usage

Stores AI platform usage metrics.

| Column       | Description                   |
| ------------ | ----------------------------- |
| usage_id     | Unique usage record           |
| customer_id  | Customer reference            |
| usage_date   | Usage date                    |
| ai_requests  | Number of AI requests         |
| active_users | Number of active users        |
| api_calls    | Number of API calls           |
| hours_saved  | Estimated working hours saved |

---

## Support Tickets

Stores customer support activity.

| Column                | Description                      |
| --------------------- | -------------------------------- |
| ticket_id             | Unique support ticket identifier |
| customer_id           | Customer reference               |
| ticket_date           | Ticket creation date             |
| issue_category        | Support issue category           |
| priority              | Ticket priority                  |
| resolution_time_hours | Resolution duration              |
| ticket_status         | Current ticket status            |

---

# 📊 Dataset

The project uses a **synthetic dataset created for portfolio and SQL analytics purposes**.

The company names are realistic fictional names and do not represent actual company records.

| Table           | Records |
| --------------- | ------: |
| Customers       |     500 |
| Plans           |       4 |
| Subscriptions   |     650 |
| Payments        |   1,200 |
| AI Usage        |   3,500 |
| Support Tickets |     900 |

### Dataset Characteristics

* Realistic SaaS business structure
* Multiple industries
* Multiple countries
* Multiple subscription plans
* Active, cancelled and paused subscriptions
* Successful and failed payment transactions
* AI usage metrics
* Customer support activity
* Foreign-key relationships between entities

---

# 🔍 SQL Analysis

The project contains **30+ business-focused SQL queries** designed to demonstrate practical SQL analytics.

### SQL concepts covered

* SELECT
* WHERE
* ORDER BY
* GROUP BY
* HAVING
* LIMIT
* INNER JOIN
* LEFT JOIN
* CASE
* COALESCE
* Aggregate Functions
* Subqueries
* Common Table Expressions
* Window Functions
* RANK
* DENSE_RANK
* ROW_NUMBER
* PARTITION BY
* Date Functions
* Revenue Analysis
* Customer Analysis
* Subscription Analysis
* AI Usage Analysis
* Support Analytics
* Payment Analytics

---

# 📈 Business Analytics

The SQL analysis focuses on several important business areas.

### Customer Analytics

* Total customer count
* Customer distribution by country
* Customer distribution by industry
* Customers with multiple subscriptions
* Customer revenue ranking
* Customer engagement classification

### Revenue Analytics

* Total revenue
* Revenue by subscription plan
* Revenue by payment method
* Monthly revenue
* Average revenue per customer
* Top revenue-generating customers

### Subscription Analytics

* Active subscriptions
* Cancelled subscriptions
* Paused subscriptions
* Subscription distribution by plan
* Subscription status analysis

### AI Usage Analytics

* Total AI requests
* API call analysis
* Active user analysis
* AI usage by industry
* Customers with high AI usage
* Hours saved through AI usage

### Support Analytics

* Support tickets by category
* Support tickets by priority
* Average resolution time
* Customers with the highest number of tickets
* Unresolved ticket analysis

### Payment Analytics

* Payment success rate
* Failed payment analysis
* Payment method performance
* Monthly payment trends

---

# 👁️ Database Views

The project includes reusable analytical views.

### Customer Revenue View

Provides customer-level revenue information.

### Plan Performance View

Analyzes subscription count and revenue by SaaS plan.

### AI Usage Performance View

Provides customer-level AI usage metrics.

### Support Performance View

Analyzes customer support activity and resolution performance.

### Subscription Overview View

Combines customers, plans, and subscription information into a single analytical view.

---

# ⚙️ Stored Procedures

Stored procedures are implemented to provide reusable business analysis.

### Procedures include:

* Customer revenue analysis
* Industry revenue analysis
* Customer AI usage analysis
* Subscription status analysis
* Customer support ticket analysis

Stored procedures allow commonly required analytical operations to be executed using parameters.

---

# 🛡️ Database Triggers

Triggers are implemented to improve data integrity and enforce business rules.

### Implemented validations

#### Payment Validation

Prevents payment records with zero or negative amounts.

#### AI Usage Validation

Prevents negative values for:

* AI requests
* API calls
* Active users
* Hours saved

#### Subscription Date Validation

Prevents an end date from being earlier than the subscription start date.

---

# ⚡ Performance Optimization

Database indexes are implemented on frequently queried columns.

### Indexed areas include:

* Customer industry
* Customer country
* Subscription customer
* Subscription plan
* Subscription status
* Payment date
* Payment status
* Payment subscription
* AI usage customer
* AI usage date
* Support customer
* Support ticket date

These indexes help improve query performance when filtering, joining, and analyzing frequently accessed data.

---

# 🧪 Data Validation

The project includes dedicated data quality checks.

Validation includes:

* NULL value detection
* Duplicate email detection
* Invalid payment amount detection
* Subscription date validation
* Payment status validation
* Subscription status validation
* AI usage validation
* Support ticket validation
* Record count verification

---

# 🖼️ Project Screenshots

## ER Diagram

The ER diagram represents the relationships between customers, subscriptions, plans, payments, AI usage, and support tickets.

![ER Diagram](screenshots/ER_Diagram.png)

---

## Database Tables

![Database Tables](screenshots/Tables.png)

---

## Database Views

![Database Views](screenshots/Views.png)

---

## Stored Procedures

![Stored Procedures](screenshots/Stored_Procedures.png)

---

## Database Triggers

![Database Triggers](screenshots/Triggers.png)

---

## Business Analytics

![Business Analytics](screenshots/Final_Analytics.png)

---

## Advanced SQL Analysis

### Customer Revenue Ranking

![Customer Revenue Ranking](screenshots/Top_Query_One.png)

### Top Revenue Customer by Industry

![Top Revenue Customer by Industry](screenshots/Top_Query_Two.png)

### Customer Business Profile

![Customer Business Profile](screenshots/Top_Query_Three.png)

---

# 🛠️ Technologies Used

* **MySQL**
* **MySQL Workbench**
* **SQL**
* **Relational Database Management**
* **ER Modelling**
* **GitHub**

---

# 📁 Project Structure

```text
AI-SaaS-Analytics-Using-MySQL/
│
├── README.md
│
├── sql/
│   ├── Create_Database.sql
│   ├── Database_Schema.sql
│   ├── Insert_Data.sql
│   ├── Data_Count_Check.sql
│   ├── Data_Validation.sql
│   ├── Business_Analytics.sql
│   ├── Top_Analytics.sql
│   ├── Analytics_Views.sql
│   ├── Business_Procedures.sql
│   ├── Data_Integrity_Triggers.sql
│   ├── Performance_Indexes.sql
│   └── Final_Database_Test.sql
│
├── dataset/
│   ├── customers.csv
│   ├── plans.csv
│   ├── subscriptions.csv
│   ├── payments.csv
│   ├── ai_usage.csv
│   └── support_tickets.csv
│
├── er-diagram/
│   └── AI_SaaS_Analytics_ER_Diagram.mwb
│
└── screenshots/
    ├── ER_Diagram.png
    ├── Tables.png
    ├── Views.png
    ├── Stored_Procedures.png
    ├── Triggers.png
    ├── Final_Analytics.png
    ├── Top_Query_One.png
    ├── Top_Query_Two.png
    └── Top_Query_Three.png
```

---

# 🚀 How to Run the Project

## Step 1 — Create Database

Open MySQL Workbench and execute:

```sql
CREATE DATABASE ai_saas_analytics;

USE ai_saas_analytics;
```

---

## Step 2 — Create Tables

Run:

```text
sql/Database_Schema.sql
```

This creates the six relational tables.

---

## Step 3 — Insert Dataset

Run:

```text
sql/Insert_Data.sql
```

This loads the complete synthetic dataset into the database.

---

## Step 4 — Validate Data

Run:

```text
sql/Data_Count_Check.sql
```

and:

```text
sql/Data_Validation.sql
```

to verify record counts and data quality.

---

## Step 5 — Run Business Analytics

Run:

```text
sql/Business_Analytics.sql
```

This contains the 30+ SQL business analysis queries.

---

## Step 6 — Create Views

Run:

```text
sql/Analytics_Views.sql
```

---

## Step 7 — Create Stored Procedures

Run:

```text
sql/Business_Procedures.sql
```

---

## Step 8 — Create Triggers

Run:

```text
sql/Data_Integrity_Triggers.sql
```

---

## Step 9 — Create Indexes

Run:

```text
sql/Performance_Indexes.sql
```

---

## Step 10 — Final Testing

Run:

```text
sql/Final_Database_Test.sql
```

to verify that the database components are working correctly.

---

# 📌 Key Outcomes

This project demonstrates practical experience with:

* Relational database design
* SQL data manipulation
* Database normalization concepts
* Foreign key relationships
* Complex SQL joins
* Business intelligence queries
* Revenue analysis
* Customer analytics
* AI usage analytics
* Support analytics
* Window functions
* CTEs
* Views
* Stored procedures
* Triggers
* Indexing
* Data validation
* MySQL Workbench
* ER modelling

---

# 🎓 Skills Demonstrated

### Database Skills

* MySQL
* Database Design
* Relational Data Modelling
* ER Diagram
* Primary Keys
* Foreign Keys
* Constraints
* Indexes

### SQL Skills

* Complex Queries
* Joins
* Aggregations
* Subqueries
* CTEs
* Window Functions
* Ranking
* Conditional Logic
* Date Functions

### Analytics Skills

* Revenue Analysis
* Customer Segmentation
* Subscription Analytics
* AI Usage Analysis
* Payment Analytics
* Support Analytics
* Business Performance Analysis

---

# 🔮 Future Enhancements

Possible future improvements include:

* Building an interactive Power BI dashboard
* Adding automated ETL pipelines
* Connecting the database to Python analytics workflows
* Adding predictive customer churn analysis
* Developing revenue forecasting models
* Adding customer lifetime value analysis
* Implementing automated reporting

---

# 👨‍💻 Author

**Thariq Arsath J**

B.Sc. Artificial Intelligence & Machine Learning

### Areas of Interest

* Machine Learning
* Data Analytics
* SQL
* Python
* Artificial Intelligence
* Data-driven Applications

---

## ⭐ Project Highlights

> **Designed a complete AI SaaS relational database and performed 30+ business-focused SQL analyses covering revenue, subscriptions, customer engagement, AI usage, payments, and support operations.**

---

## 📄 License

This project is created for educational, portfolio, and demonstration purposes.

The dataset is synthetic and does not contain real customer or company records.
