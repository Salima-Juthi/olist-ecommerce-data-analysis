SET SQL_SAFE_UPDATES = 0;

USE sales_analysis_db;
-- =========================================================
-- Data validation
-- =========================================================

SELECT COUNT(*) AS empty_oder_approved_at
FROM orders
WHERE order_approved_at = '';

UPDATE orders
SET order_estimated_delivery_date = NULL
WHERE order_estimated_delivery_date = '';

UPDATE orders
SET order_approved_at = NULL
WHERE order_approved_at = 'NULL';

SELECT COUNT(*) AS null_values
FROM orders
WHERE order_approved_at IS NULL;

ALTER TABLE orders
MODIFY COLUMN order_estimated_delivery_date DATETIME;

DESCRIBE orders;

SELECT
	COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_oders
FROM orders;

SELECT
	COUNT(*) AS total_rows,
    SUM(customer_id IS NULL) AS null_customer_id
FROM orders;

SELECT 
	order_status,
    COUNT(*) AS orders
FROM orders;
GROUP BY order_status
ORDER BY orders DESC;

SELECT
	COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders
FROM order_items;

USE sales_analysis_db;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_category_name_english) AS unique_categories
FROM product_category_name_trans;