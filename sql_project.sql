 
CREATE TABLE RETAILS_SALES (
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT ,
gender VARCHAR(10),
age INT,
category VARCHAR(20),
quantity INT,
price_per_unit	FLOAT,
cogs	FLOAT,
total_sale INT
);
select*from retails_sales;
select count(*) from retails_sales
-- DATA CLEANING

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
delete FROM retails_sales
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
-- DATA EXPLORATIONS   

--how many we sales have?
SELECT COUNT(*) FROM retails_sales;
--how many unique customers we have
SELECT COUNT(DISTINCT customer_id)AS TOTAL_SALES from  retails_sales;
-- DATA ANALYSIS & BUSINESS PROBLEMS SOLVING & ANSWERS


-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT *FROM retails_sales WHERE sale_date = '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT  * FROM retail_sales WHERE category = 'Clothing' AND  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantity >= 4


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT  category, SUM(total_sale) as net_sale, COUNT(*) as total_orders FROM retail_sales GROUP BY category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT ROUND(AVG(age), 2) as avg_age FROM retail_sales WHERE category = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000

SELECT * FROM retail_sales WHERE total_sale > 1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT  category, gender, COUNT(*) as total_trans FROM retail_sales GROUP  BY  category,gender ORDER BY 1


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT  year, month,avg_sale FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
    
-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id, SUM(total_sale) as total_sales FROM retail_sales GROUP BY customer_id ORDER BY sum(total_sale) DESC LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category
select category,count(distinct customer_id) as unique_customer from retails_sales group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select*from retails_sales

with hourly_sales
as 
(select*,
case
when extract(hour from sale_time)<12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'evening'
end as shift from retails_sales
)
select shift,count(*) as total_orders from hourly_sales group by shift
select sale_time from retails_sales
