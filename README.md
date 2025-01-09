# Restaurant-Sales-Analysis-SQL-Project

## 📜 Overview
This project demonstrates the use of SQL to analyze sales data from a hypothetical restaurant's orders and menu items. By leveraging SQL functions, joins, and window functions, the project answers key business questions and provides actionable insights to improve decision-making.

---

## 🔍 Key Questions Answered
1. What is the **average value of orders**?
2. Which items are the **most popular** overall?
3. Which items are the **least popular**?
4. Which items are the **most popular during specific time slots** (Morning, Afternoon, Evening)?
5. Which **high-priced items** have the **lowest sales**?
6. How much **revenue** does each category generate?

---

## 🛠️ Methods Performed
### 1. Data Integration
- Created a **SQL View** (`menu_order_view`) by joining the `menu_items` and `order_details` tables to simplify the analysis.
- View includes fields like `order_id`, `item_name`, `price`, and `order_time`.

### 2. Data Analysis Techniques
- **Joins:** Combined data from `menu_items` and `order_details` tables.
- **Aggregation Functions:** Used `SUM`, `COUNT`, and `ROUND` to calculate metrics like total revenue, order counts, and averages.
- **Window Functions:** Applied `DENSE_RANK` with `PARTITION BY` to rank items within specific time slots.
- **Conditional Logic:** Used `CASE` statements to group data into time slots (Morning, Afternoon, Evening).
- **Grouping and Sorting:** Grouped data using `GROUP BY` and sorted results with `ORDER BY` for ranking and insights.

---

## 📊 Insights Gained
1. **Average Order Value:**
   - Found the average value of orders to be **$29.8**.
   - This metric helps understand the spending habits of customers.

2. **Most Popular Items:**
   - Identified top-selling items across all time periods, e.g., `Hamburger`, `Korean Beef Bowl`.

3. **Least Popular Items:**
   - Found items with the lowest sales, e.g., `Chicken Tacos`, indicating potential for menu optimization.

4. **Time-Based Popularity:**
   - Morning: `Korean Beef Bowl` was the most popular item.
   - Afternoon: `Hamburger` topped the sales.
   - Evening: `Hamburger` led the orders.

5. **High Price, Low Sales:**
   - Expensive items like `Shrimp Scampi` (priced at $19.95) showed low sales volumes, highlighting potential pricing issues.

6. **Revenue by Category:**
   - Italian food generated the highest revenue, emphasizing their importance in the menu.

---

## 📂 Project Files
1. **`Sales_analysis.sql`:** Contains all the SQL queries used for the analyses.
2. **`README.md`:** Documentation of the project, including methods, functions, and insights.

---

## 🛠️ Functions and Concepts Used
1. **Joins:**
   - Used `INNER JOIN` to combine data from the `menu_items` and `order_details` tables.
2. **Aggregation Functions:**
   - `SUM`: Calculate total revenue.
   - `COUNT`: Count the number of orders or items sold.
   - `ROUND`: Round off values to two decimal places for readability.
3. **Window Functions:**
   - `DENSE_RANK`: Rank items by sales within each time slot.
4. **Conditional Logic:**
   - `CASE`: Categorize order times into time slots (Morning, Afternoon, Evening).
5. **Grouping and Sorting:**
   - `GROUP BY`: Aggregate data by item or time slot.
   - `ORDER BY`: Rank items based on total sales or revenue.

