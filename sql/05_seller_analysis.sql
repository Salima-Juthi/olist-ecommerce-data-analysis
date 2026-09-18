USE sales_analysis_db;

-- Seller Revenue
-- =================================================

SELECT 
	oi.seller_id,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN orders o
	ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY total_revenue DESC;

-- Seller sales volume
-- ==================================================

SELECT 
	oi.seller_id,
    COUNT(oi.order_id) AS units_sold
FROM order_items oi
JOIN orders o
	ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY units_sold DESC;








