# Retail Sales & Customer Analytics using PostgreSQL

## 📌 Project Overview

This project focuses on analyzing retail sales and customer data using PostgreSQL. The goal is to extract meaningful insights about sales performance, product performance, customer purchasing behavior, and revenue trends using SQL queries.

## 🎯 Project Objectives

- Analyze overall sales performance and revenue.
- Identify best-selling and high-revenue-generating products.
- Analyze monthly revenue trends.
- Identify repeat customers and customers who have never purchased.
- Understand customer spending patterns.
- Compare product prices with the average product price.

## 🛠️ Tools & Technologies

- **Database:** PostgreSQL
- **SQL Environment:** pgAdmin 4
- **Dataset Format:** CSV

## 🗂️ Database Structure

The project uses three tables:

### 1. Customers
Stores customer information, including customer ID, name, email, city, country, and signup date.

### 2. Products
Stores product details, including product ID, product name, category, price, and available stock.

### 3. Orders
Stores order records, including order ID, customer ID, product ID, order date, quantity, and total amount.

## 📊 SQL Analysis & Business Questions

This project includes 20 SQL queries organized around the following business questions:

- **Sales Fundamentals:** Filter customers by country, find expensive products, identify low-stock products, and calculate sales summaries.
- **Product Performance:** Analyze revenue by category, identify best-selling products, and find products that have never sold.
- **Sales Trends:** Analyze monthly revenue and overall sales performance.
- **Customer Analysis:** Identify top-spending customers, repeat customers, customers who never purchased, and revenue by country.
- **Advanced SQL Practice:** Use subqueries and `CASE WHEN` to compare product prices and categorize customer spending.

## 🧠 SQL Concepts Used

- `SELECT` and `WHERE`
- Aggregate functions: `SUM()`, `AVG()`, `COUNT()`, `MAX()`, `MIN()`
- `ORDER BY` and `LIMIT`
- `GROUP BY` and `HAVING`
- `INNER JOIN` and `LEFT JOIN`
- Subqueries
- `CASE WHEN`
- Date functions: `DATE_TRUNC()` and `TO_CHAR()`
- `DISTINCT`

## 📁 Project Files

- `retail_sales_analysis.sql` — SQL script containing table creation, data import statements, and 20 analysis queries.
- `README.md` — Project documentation.
- CSV dataset files — Source data used for analysis, if included in the repository.

## ▶️ How to Run the Project

1. Install PostgreSQL and pgAdmin 4.
2. Create or select a database.
3. Open the SQL script in pgAdmin's Query Tool.
4. Execute the table creation statements.
5. Update the CSV file paths in the import statements to match your computer.
6. Import the datasets into the respective tables.
7. Execute the analysis queries to explore the results.

**Note:** The CSV import statements use local file paths. These paths must be updated before running the script on another computer.

## 📈 Learning Outcomes

Through this project, I practiced writing SQL queries to solve business-oriented questions, analyze retail sales data, and understand customer purchasing patterns.

This project helped strengthen my PostgreSQL skills and build a foundation for data analytics.

## 👩‍💻 Author

**Sneha Ashok Parishwad**

