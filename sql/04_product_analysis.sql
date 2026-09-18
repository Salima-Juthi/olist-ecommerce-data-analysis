USE sales_analysis_db;

-- Products sales by Revenue
-- ==============================================

SELECT 
	oi.product_id,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN orders o
	ON oi.order_id = o.order_id
WHERE o.order_status ='delivered'
GROUP BY oi.product_id
ORDER BY total_revenue DESC;

-- Top Products by volume
-- ==============================================

SELECT
	oi.product_id,
    COUNT(oi.order_id) AS units_sold
FROM order_items oi
JOIN orders o
	ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.product_id
ORDER BY units_sold DESC;

-- Quick validation to check if null categories exists
-- =======================================================
SELECT
	count(*) AS total_products,
    count(product_category_name) AS products_with_category,
    count(*) - count(product_category_name) AS products_without_category
FROM products;

-- Products category wise performance
-- =======================================================

SELECT 
	p.product_category_name,
    ROUND(AVG(oi.price), 2) AS avg_product_price,
    COUNT(oi.order_id) AS units_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN orders o
	ON o.order_id = oi.order_id
JOIN products p
	ON p.product_id = oi.product_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_name
ORDER BY avg_product_price DESC;




























    
