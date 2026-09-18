

-- =============================================================
-- Olist E-Commerce Analysis
-- Section : Executive Sale KPIs
-- =============================================================

-- 1. Total Revenue
SELECT 
	ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi
	ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';

-- 2. Total Delivered Orders
SELECT 
	COUNT(DISTINCT order_id) AS total_orders
FROM orders
WHERE order_status = 'delivered';

-- 3. Total Unique Customers
SELECT 
	COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered';

-- 4. Average Order value
SELECT 
	ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN order_items oi
	ON oi.order_id = o.order_id;
WHERE o.order_status = 'delivered';

SELECT
    ROUND(SUM(oi.price), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS avg_order_value
FROM orders o
JOIN order_items oi
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered';

















