-- ============================================
-- Customer Analysis
-- ============================================

-- Repeat customer and Repeat customer rate

USE sales_analysis_db;

-- ====================================================================
-- Order Frequency
-- ====================================================================

WITH RepeatCustomers AS (  
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM orders o
    JOIN customers c
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
    HAVING COUNT(DISTINCT o.order_id) >= 2
),
TotalCustomers AS (
    SELECT 
        COUNT(DISTINCT c.customer_unique_id) AS total_customers
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
)
SELECT
    COUNT(*) AS repeat_customers,
    tc.total_customers,
    ROUND(
        COUNT(*) / tc.total_customers * 100,
        2
    ) AS repeat_customer_rate
FROM RepeatCustomers rc
CROSS JOIN TotalCustomers tc
GROUP BY tc.total_customers;

-- =========================================
-- First VS latest purchase, days between purchases (Customer purchase behavior Analysis)
-- Customer Segmentation (customer base break down by purchase frequency and percentage check)
-- =========================================

WITH DeliveredOrders AS (
	SELECT	
		o.order_id,
        o.customer_id,
        o.order_purchase_timestamp
	FROM orders o
    WHERE o.order_status = 'delivered'
),
CustomerMetrics AS (
	SELECT 
		c.customer_unique_id AS customer,
        MIN(order_purchase_timestamp) AS first_order_date,
        MAX(order_purchase_timestamp) AS latest_order_date,
		COUNT(DISTINCT d.order_id) AS total_orders,
        DATEDIFF(
			MAX(order_purchase_timestamp), 
            MIN(order_purchase_timestamp)
        ) AS days_active
	FROM DeliveredOrders d
    JOIN customers c
		ON d.customer_id = c.customer_id
	GROUP BY c.customer_unique_id
),
CustomerSegments AS (
    SELECT
        customer,
        total_orders,
        CASE
            WHEN total_orders = 1 THEN 'One-time'
            WHEN total_orders BETWEEN 2 AND 3 THEN 'Repeat'
            WHEN total_orders >= 4 THEN 'Frequent'
        END AS segment
    FROM CustomerMetrics
),
SegmentSummary AS (
	SELECT 
		segment,
		COUNT(*) customer_count
	FROM CustomerSegments
	GROUP BY segment
),
TotalCustomers AS (
	SELECT 
		COUNT(*) AS total_customers
	FROM CustomerSegments
)
SELECT 
	ss.segment,
    ss.customer_count,
    ROUND(
		ss.customer_count / tc.total_customers * 100,
		2
    ) AS percentage
FROM SegmentSummary ss
CROSS JOIN TotalCustomers tc;

-- ================================
-- Customer Revenue
-- ================================

WITH DeliveredCustomerOrders AS (
	SELECT
		c.customer_unique_id,
        o.order_id
	FROM customers c
    JOIN orders o
		ON c.customer_id = o.customer_id
	WHERE o.order_status = 'delivered'
),
CustomerRevenue AS (
	SELECT 
		dc.customer_unique_id,
        SUM(oi.price) AS total_revenue
	FROM DeliveredCustomerOrders dc
    JOIN order_items oi
		ON oi.order_id = dc.order_id
	GROUP BY dc.customer_unique_id
),
RankedCustomers AS (
	SELECT
		customer_unique_id,
		total_revenue,
        ROW_NUMBER() OVER (
			ORDER BY total_revenue DESC
		) AS revenue_rank,
        COUNT(*) OVER () AS total_customers
	FROM CustomerRevenue
),
RevenueConcentration AS (
SELECT
    ROUND(SUM(
        CASE
            WHEN revenue_rank <= total_customers * 0.01
            THEN total_revenue
            ELSE 0
        END
    ), 2) AS top_1_revenue,

    ROUND(SUM(
        CASE
            WHEN revenue_rank <= total_customers * 0.05
            THEN total_revenue
            ELSE 0
        END
    ), 2) AS top_5_revenue,

    ROUND(SUM(
        CASE
            WHEN revenue_rank <= total_customers * 0.10
            THEN total_revenue
            ELSE 0
        END
    ), 2) AS top_10_revenue,

    ROUND(SUM(total_revenue), 2) AS total_revenue

FROM RankedCustomers
)
SELECT
    top_1_revenue,
    ROUND(top_1_revenue / total_revenue * 100, 2) AS top_1_percentage,

    top_5_revenue,
    ROUND(top_5_revenue / total_revenue * 100, 2) AS top_5_percentage,

    top_10_revenue,
    ROUND(top_10_revenue / total_revenue * 100, 2) AS top_10_percentage,

    total_revenue
FROM RevenueConcentration;


SELECT -- To get customer level metrics
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(AVG(total_revenue), 2) AS avg_revenue,
    MAX(total_revenue) AS max_customer_revenue,
    MIN(total_revenue) AS min_customer_revenue
FROM CustomerRevenue;

-- Required to calculate customer level metrics(meaning customer wise total_revenue for delivered orders)

SELECT -- To get per customer revenue
	customer_unique_id AS customers,
	total_revenue
FROM CustomerRevenue;



	
        















