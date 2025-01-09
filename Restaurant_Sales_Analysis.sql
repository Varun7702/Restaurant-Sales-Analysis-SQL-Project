-- Restaurant Sales Analysis

USE  restaurant_orders;

-- Checking for duplicate values

SELECT menu_item_id, COUNT(DISTINCT menu_item_id) AS duplicate_row
FROM menu_items
GROUP BY menu_item_id
HAVING duplicate_row > 1;

SELECT order_details_id, COUNT(DISTINCT order_details_id) AS duplicate_row
FROM order_details
GROUP BY order_details_id
HAVING duplicate_row > 1;

-- Sales Analysis
-- What are the top-selling items from the menu
SELECT m.item_name
FROM menu_items m
JOIN order_details od
ON m.menu_item_id = od.item_id
GROUP BY m.item_name
ORDER BY COUNT(*) DESC
LIMIT 5;

-- Which category of food generates the most revenue
SELECT m.category, ROUND(SUM(m.price),2) AS total_revenue
FROM menu_items m
JOIN order_details od
ON m.menu_item_id = od.item_id
GROUP BY m.category
ORDER BY total_revenue DESC;

-- Creating a view to avoid joining table multiple times
CREATE VIEW menu_order_view AS
SELECT *
FROM menu_items m
JOIN order_details o
ON m.menu_item_id  = o.item_id;

-- What is the average order values
SELECT ROUND(SUM(order_total) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM (
    SELECT order_id, SUM(price) AS order_total
    FROM menu_order_view
    GROUP BY order_id
) orders;

-- What are the least popular menu items
SELECT m.item_name, COUNT(*) AS total_sales
FROM menu_items m
JOIN order_details od
ON m.menu_item_id = od.item_id
GROUP BY m.item_name
ORDER BY total_sales
LIMIT 5;

-- Customer Order Patterns
-- What are the peak ordering times during the day
SELECT HOUR(STR_TO_DATE(order_time, '%h:%i:%s %p')) AS hour_of_day, COUNT(*) AS total_orders
FROM menu_order_view
GROUP BY hour_of_day
ORDER BY total_orders DESC
LIMIT 5;

-- What are the most popular item ordered during diiferent time slots 
WITH CTE AS (SELECT *, DENSE_RANK() OVER(partition by time_slot ORDER BY total_sales DESC) as item_rank
FROM(
SELECT 
    CASE
        WHEN HOUR(STR_TO_DATE(order_time, '%h:%i:%s %p')) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(STR_TO_DATE(order_time, '%h:%i:%s %p')) BETWEEN 12 AND 16 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_slot,
    item_name,
    COUNT(item_id) AS total_sales
FROM menu_order_view
GROUP BY time_slot, item_name) orders)

SELECT time_slot, item_name, total_sales
FROM CTE
WHERE item_rank = 1;

-- How many items are ordered per order, on average

SELECT ROUND(AVG(number_of_items)) AS average_items_per_order
FROM (SELECT order_id, COUNT(*) number_of_items 
	  FROM menu_order_view
      GROUP BY order_id) items_per_order;
      
-- Revenue Insights
-- What is the total revenue generated on a specific date
SELECT order_date, ROUND(SUM(price),2) as total_revenue
FROM menu_order_view
GROUP BY order_date
ORDER BY order_date DESC;

-- How does revenue differ between categories
SELECT category, ROUND(SUM(price),2) AS revenue, 
	   ROUND((SUM(price) / (SELECT SUM(PRICE) FROM menu_order_view))*100,2) AS percent_contributed
FROM menu_order_view
GROUP BY category
ORDER BY revenue DESC;

-- Which menu item contributes the most to overall revenue
SELECT item_name, ROUND(SUM(price),2) AS revenue
FROM menu_order_view
GROUP BY item_name
ORDER BY revenue DESC
LIMIT 1;

-- Trends and Patterns
-- What are the most commonly ordered combinations of items
SELECT mo.item_id AS item_1, o.item_id AS item_2, COUNT(*) AS times_ordered
FROM menu_order_view mo
JOIN order_details o ON mo.order_id = o.order_id AND mo.item_id < o.item_id
GROUP BY mo.item_id, o.item_id
HAVING times_ordered > 1
ORDER BY times_ordered DESC
LIMIT 5;

/* Are there menu items with high prices but low sales? 
Should they be promoted or discounted? */

SELECT  item_name, price, COUNT(*) total_sales
FROM menu_order_view
WHERE price > 11
GROUP BY item_name, price
ORDER BY total_sales
LIMIT 5;

/* Are there low-priced items that are frequently ordered and could have their
price increased slightly to boost revenue */

SELECT item_name, price, COUNT(item_id) AS total_sales
FROM menu_order_view
WHERE price <=11
GROUP BY item_name, price
ORDER BY total_sales DESC
LIMIT 5;
