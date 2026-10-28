-- =====================================================
-- RETAIL SALES & CUSTOMER ANALYTICS
-- POSTGRESQL PROJECT
-- =====================================================

-- =====================================================
-- PART 1: CREATE TABLES
-- =====================================================

CREATE TABLE Customers(
    customer_id Serial Primary Key,
    customer_name varchar(100) Not Null,
    email varchar(100),
    city Varchar(50),
    country Varchar(50),
    signup_date Date
);

CREATE TABLE Products(
    product_id Serial Primary Key,
    product_name varchar(100) Not Null,
    category Varchar(50),
    price Decimal(10,2),
    stock Int
);

CREATE TABLE Orders(
    order_id Serial Primary Key,
    customer_id Int references Customers(customer_id),
    product_id Int references Products(product_id),
    order_date Date,
    quantity Int,
    total_amount Decimal(10,2)
);


-- =====================================================
-- PART 2: IMPORT DATA
-- =====================================================

COPY
Customers(customer_id,customer_name,email,city,country,signup_date)
FROM 'E:\Data Analyst projects by satish dhawale\Sql project\retail_analytics_csv_files\customers.csv'
WITH (FORMAT CSV, HEADER);

COPY
Products(product_id,product_name,category,price,stock)
FROM 'E:\Data Analyst projects by satish dhawale\Sql project\retail_analytics_csv_files\products.csv'
WITH (FORMAT CSV, HEADER);

COPY
Orders(order_id,customer_id,product_id,order_date,quantity,total_amount)
FROM 'E:\Data Analyst projects by satish dhawale\Sql project\retail_analytics_csv_files\orders.csv'
WITH (FORMAT CSV, HEADER);


-- =====================================================
-- PART 3: CHECK TABLE DATA
-- =====================================================

SELECT * FROM Customers;

SELECT * FROM Products;

SELECT * FROM Orders;


-- =====================================================
-- Queris 
-- =====================================================

-- Q1. Filter by Country
-- Find all customers who belong to India.
SELECT *
FROM Customers
WHERE country = 'India';


-- Q2. Products by Price
-- Display product name, category and price for products costing more than ₹1,000.
SELECT product_name, category, price
FROM Products
WHERE price > 1000;


-- Q3. Low Stock Products
-- Find products whose stock is below 20 units.
SELECT product_name, category, stock
FROM Products
WHERE stock < 20;


-- Q4. Total Number of Orders
-- Find how many order records exist in the `Orders` table.
SELECT COUNT(*) AS total_orders
FROM Orders;


-- Q5. Top 10 Expensive Products
-- Display the 10 most expensive products.
SELECT product_name, category, price
FROM Products
ORDER BY price DESC
LIMIT 10;


-- Q6. Order Summary
-- Calculate the total quantity sold, average order amount, highest order amount and lowest order amount.
SELECT
SUM(quantity) AS total_quantity_sold,
AVG(total_amount) AS average_order_amount,
MAX(total_amount) AS highest_order_amount,
MIN(total_amount) AS lowest_order_amount
FROM Orders;


-- Q7. Overall Sales Performance
-- Calculate total revenue, total orders, total units sold, and average order value.
Select sum(total_amount) AS Total_Revenue,
Count(Order_id) As Total_Orders,
sum(quantity) AS Total_Units_Sold,
Avg(Total_amount) As Average_Order_Value
from Orders;


-- Q8. Revenue by Category
-- Display each product category and its total revenue. Sort from highest to lowest revenue.
SELECT
p.category,
SUM(o.total_amount) AS total_revenue
FROM Products p
JOIN Orders o
ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


-- Q9. Best-Selling Products
-- Find the top 10 products based on total units sold. Display product name, category and units sold.
SELECT
p.product_id,
p.product_name,
p.category,
SUM(o.quantity) AS units_sold
FROM Products p
JOIN Orders o
ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY units_sold DESC
LIMIT 10;


-- Q10. Monthly Revenue Analysis
-- Calculate total revenue and number of orders for each month, sorted chronologically.
Select TO_CHAR(DATE_TRUNC('Month',Order_date), 'YYYY-MM') AS Month,
Count(Order_id) as Number_Of_Orders,
sum(Total_amount) as Total_Revenue
from Orders
Group by Date_Trunc('Month',Order_date)
Order by Month;


-- Q11. Best-Selling Products
-- Find the top 10 products by total quantity sold.
-- Display product name, category, units sold, and revenue.
Select p.product_name,p.category,
sum(o.quantity) AS unit_sold,
sum(o.Total_Amount) as Total_revenue
from Products p
join Orders o 
ON p.product_id=o.product_id
Group by p.product_name,p.category
Order by unit_sold desc limit 10;


-- Q12. Customer Spending Analysis
-- Find the top 10 customers by total spending.
-- Display their name, city, country, number of orders, and total spending.
Select c.customer_id,c.Customer_name,c.city,c.country,
count(o.order_id) As Number_OF_Orders,
sum(Total_amount) As Total_Spending
from Customers c
join Orders o
On c.customer_id=o.customer_id
Group by c.customer_id,c.Customer_name,c.city,c.country
Order by Total_Spending desc limit 10;


-- Q13. Repeat Customer Identification
-- Find customers who have placed at least 5 orders.
-- Display their total orders and total spending.
Select c.Customer_id,c.Customer_name,
count(o.Order_id) Total_Orders,
sum(Total_amount) As Total_Spending
from Customers c
join Orders o
On c.customer_id=o.customer_id
Group by c.Customer_id,c.Customer_name
Having count(o.Order_id)>=5;


-- Q14. Customers Who Never Purchased
-- Find every customer who has never placed an order.
-- Display their name, email, city, and signup date.
Select c.customer_name,c.email,c.city,c.signup_date
from Customers c
left join Orders o
On c.customer_id=o.customer_id
where o.Order_id is Null;


-- Q15. Products That Have Never Sold
-- Find products that have never appeared in the Orders table.
-- Display their name, category, price, and stock.

SELECT p.product_name, p.category, p.price, p.stock
FROM Products p
LEFT JOIN Orders o
ON p.product_id = o.product_id
WHERE o.product_id IS NULL;


-- Q16. Customer Revenue by Country
-- Calculate total revenue, number of purchasing customers, and total orders
-- for each country. Rank countries from highest to lowest revenue.
Select c.Country,count(Distinct o.customer_id) as number_purchasing_customers,
Count(o.order_id) as Total_orders,
Sum(Total_amount) As total_revenue 
from Customers c
join Orders o
On c.customer_id=o.customer_id
Group by c.Country
Order by total_revenue desc;


-- Q17. Products Above Average Price
-- Find products whose price is greater than the average price of all products. Display the product name, price and overall average price.
SELECT
product_name,
price,
(SELECT AVG(price) FROM Products) AS average_price
FROM Products
WHERE price > (
SELECT AVG(price)
FROM Products
)
ORDER BY price DESC;


-- Q18. Best Revenue-Generating Products
-- Find the top 10 products that generated the highest total revenue.
SELECT
p.product_id,
p.product_name,
p.category,
SUM(o.total_amount) AS total_revenue
FROM Products p
JOIN Orders o
ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;


-- Q19. Spending Categories
-- Categorize customers based on their total spending:
-- High Spender: more than ₹50,000
-- Medium Spender: ₹10,000 to ₹50,000, inclusive
-- Low Spender: below ₹10,000
-- Display customer name, total spending and spending category. Use `CASE WHEN`.
SELECT
c.customer_id,
c.customer_name,
SUM(o.total_amount) AS total_spending,
CASE
    WHEN SUM(o.total_amount) > 50000
        THEN 'High Spender'
    WHEN SUM(o.total_amount) >= 10000
        THEN 'Medium Spender'
    ELSE 'Low Spender'
END AS spending_category
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC;


-- Q20. Above-Average Products
-- Find products whose price is higher than the average price of all products.
-- Display product name, category, price, and difference from average price.
SELECT
product_name,
category,price,
(SELECT AVG(price) FROM products) AS Average_Price,
price-(SELECT AVG(price) From products) AS Diffrence_from_avg_price
FROM  products
where price >(SELECT AVG(price) FROM  products);