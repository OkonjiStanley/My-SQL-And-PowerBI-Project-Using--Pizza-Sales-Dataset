SELECT * FROM pizza.pizza_sales;

CREATE VIEW total_sold AS
SELECT pizza_category, SUM(quantity) total_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_sold DESC;

-- find the sum of total revenue

CREATE VIEW `total_revenue` AS
SELECT ROUND(sum(total_price),2) `total_revenue`
FROM pizza_sales;

-- Average Order by value

CREATE VIEW `Avg_Order_value` AS
SELECT round(sum(total_price),2) / round(count(DISTINCT order_id),2) `Avg_Order_value`
FROM pizza_sales;

-- calculate the Total Pizzas sold

CREATE VIEW `total_quantity` AS
SELECT sum(quantity) total_quantity
FROM pizza_sales;


-- calculate for Total orders

CREATE VIEW `total_orders` AS
SELECT COUNT(DISTINCT order_id) total_orders
FROM pizza_sales;


CREATE VIEW `Avg_pizzas_per_order` AS
SELECT sum(quantity)  / COUNT(DISTINCT order_id) `Avg_pizzas_per_order`
FROM pizza_sales;




update pizza_sales
set order_date = str_to_date(order_date, "%d-%m-%Y");

alter table pizza_sales
modify order_date date;

alter table pizza_sales
modify order_time time;

describe pizza_sales;


-- Daily trend for total orders
drop view  `daily_trends`;

CREATE VIEW `daily_trends` AS
SELECT DAYNAME(order_date), COUNT(DISTINCT order_id) daily_trends,
case 
	when DAYNAME(order_date)="Sunday" then 1 
    when DAYNAME(order_date)="Monday" then 2 
    when DAYNAME(order_date)="Tuesday" then 3 
    when DAYNAME(order_date)="wednesday" then 4 
    when DAYNAME(order_date)="Thursday" then 5
    when DAYNAME(order_date)="Friday" then 6 
    when DAYNAME(order_date)="Saturday" then 7
    end as daysno
FROM pizza_sales
GROUP BY DAYNAME(order_date)
ORDER BY daily_trends DESC ; 

-- Monthly trend for total orders

CREATE VIEW `monthly_trendS` AS
SELECT MONTHNAME(order_date), COUNT(DISTINCT order_id) monthly_trendS
FROM pizza_sales
GROUP BY MONTHNAME(order_date)
ORDER BY monthly_trendS DESC; 


SELECT * FROM pizza_sales;

CREATE VIEW `PCT` AS
SELECT pizza_category, SUM(total_price) * 100 / ( SELECT sum(total_price) FROM pizza_sales) `PCT`
FROM pizza_sales
GROUP BY pizza_category;

CREATE VIEW `pct_by_months` AS
SELECT pizza_category, SUM(total_price) total_sales,  SUM(total_price) * 100 / ( SELECT sum(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) `pct_by_months`
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;


CREATE VIEW `PCT_size` AS
SELECT pizza_size, SUM(total_price) AS total_sales,  ROUND(SUM(total_price) * 100 /
 ( SELECT sum(total_price) FROM pizza_sales WHERE QUARTER(order_date) =1), 2 ) `PCT_size`
FROM pizza_sales
WHERE QUARTER(order_date) =1
GROUP BY pizza_size
ORDER BY `PCT_size` DESC;

CREATE VIEW `total_rev` AS
SELECT pizza_name, SUM(total_price) total_rev
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_rev DESC
LIMIT 5; 

CREATE VIEW total_rev_bottom5 AS
SELECT pizza_name, SUM(total_price) total_rev_bottom5
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_rev_bottom5 ASC
LIMIT 5; 

CREATE VIEW total_qut AS
SELECT pizza_name, SUM(quantity) total_qut
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_qut DESC
LIMIT 5; 

CREATE VIEW total_orderid AS
SELECT pizza_name, COUNT(DISTINCT order_id) total_orderid
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orderid DESC
LIMIT 5; 
