# 🛒 Retail Sales SQL Analysis Project

## 📌 Project Overview

This project demonstrates SQL skills by performing **data cleaning, exploration, and business analysis** on a retail sales dataset using PostgreSQL.

### Skills Demonstrated

* Database Design
* Data Cleaning
* Data Exploration
* Aggregate Functions
* Window Functions
* Common Table Expressions (CTE)
* Business Analysis
* SQL Query Optimization

---

# 📂 Database Schema

```sql
CREATE TABLE retails_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(20),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale INT
);
```

---

# 🧹 Data Cleaning

## Find NULL Values

```sql
SELECT *
FROM retails_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

## Delete NULL Records

```sql
DELETE FROM retails_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

---

# 📊 Data Exploration

## Total Sales Records

```sql
SELECT COUNT(*)
FROM retails_sales;
```

## Total Unique Customers

```sql
SELECT COUNT(DISTINCT customer_id)
FROM retails_sales;
```

---

# 📈 Business Problems & SQL Solutions

## Q1. Retrieve all sales made on **2022-11-05**

```sql
SELECT *
FROM retails_sales
WHERE sale_date = '2022-11-05';
```

---

## Q2. Retrieve Clothing sales with quantity greater than or equal to 4 in November 2022

```sql
SELECT *
FROM retails_sales
WHERE category = 'Clothing'
AND TO_CHAR(sale_date,'YYYY-MM')='2022-11'
AND quantity >= 4;
```

---

## Q3. Calculate total sales and total orders for each category

```sql
SELECT
category,
SUM(total_sale) AS net_sale,
COUNT(*) AS total_orders
FROM retails_sales
GROUP BY category;
```

---

## Q4. Find the average age of customers purchasing Beauty products

```sql
SELECT ROUND(AVG(age),2) AS average_age
FROM retails_sales
WHERE category='Beauty';
```

---

## Q5. Find all transactions where total sale is greater than 1000

```sql
SELECT *
FROM retails_sales
WHERE total_sale > 1000;
```

---

## Q6. Find total transactions by Gender and Category

```sql
SELECT
category,
gender,
COUNT(*) AS total_transactions
FROM retails_sales
GROUP BY category, gender
ORDER BY category;
```

---

## Q7. Find the best-selling month of each year based on average sales

```sql
SELECT
year,
month,
avg_sale
FROM
(
SELECT
EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT(MONTH FROM sale_date) AS month,
AVG(total_sale) AS avg_sale,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)
ORDER BY AVG(total_sale) DESC
) AS rank
FROM retails_sales
GROUP BY 1,2
) t
WHERE rank = 1;
```

---

## Q8. Find the Top 5 Customers by Total Sales

```sql
SELECT
customer_id,
SUM(total_sale) AS total_sales
FROM retails_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

## Q9. Find the number of unique customers in each category

```sql
SELECT
category,
COUNT(DISTINCT customer_id) AS unique_customers
FROM retails_sales
GROUP BY category;
```

---

## Q10. Create Sales Shifts (Morning, Afternoon, Evening)

```sql
WITH hourly_sales AS
(
SELECT *,
CASE
WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS shift
FROM retails_sales
)

SELECT
shift,
COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;
```

---

# 🛠 SQL Concepts Used

* DDL (CREATE TABLE)
* SELECT
* WHERE
* DELETE
* COUNT()
* SUM()
* AVG()
* DISTINCT
* GROUP BY
* ORDER BY
* CASE
* Common Table Expressions (CTE)
* Window Functions
* RANK()
* EXTRACT()
* TO_CHAR()
* Aggregate Functions

---

# 📚 Project Outcomes

This project demonstrates how SQL can be used to:

* Clean raw data
* Explore datasets
* Answer business questions
* Generate sales insights
* Analyze customer behavior
* Apply PostgreSQL functions
* Use CTEs and Window Functions effectively

---

# 🚀 Future Enhancements

* Build Power BI Dashboard
* Create Tableau Dashboard
* Perform Customer Segmentation
* Conduct Sales Trend Analysis
* Develop Sales Forecasting Models using Python

---

# 💻 Technologies Used

* PostgreSQL
* SQL
* Git
* GitHub

---

# 👨‍💻 Author

**Nitesh Sahani**

⭐ If you found this project useful, please consider starring the repository on GitHub!
