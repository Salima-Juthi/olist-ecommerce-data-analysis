USE sales_analysis_db;

-- Delivery performance
-- ===============================================================

SELECT
	 ROUND(
        AVG(
            DATEDIFF(
                DATE(order_delivered_customer_date),
                DATE(order_purchase_timestamp)
            )
        ), 2
    ) AS avg_delivery_days,
        MIN(
        DATEDIFF(
            DATE(order_delivered_customer_date),
            DATE(order_purchase_timestamp)
        )
    ) AS min_delivery_days,
       MAX(
        DATEDIFF(
            DATE(order_delivered_customer_date),
            DATE(order_purchase_timestamp)
        )
    ) AS max_delivery_days
FROM orders
WHERE order_status = 'delivered';

-- Delivery delay checking
-- ==========================================================

SELECT 
	COUNT(*) AS total_delivered_orders,
    SUM(
		CASE
			WHEN DATE(order_delivered_customer_date) <= DATE(order_estimated_delivery_date)
            THEN 1
            ELSE 0
		END
	) AS on_time_orders,
    
    SUM(
		CASE
			WHEN DATE(order_delivered_customer_date) >= DATE(order_estimated_delivery_date)
            THEN 1
            ELSE 0
		END
	) AS late_orders,
    
    ROUND(
		100 * SUM(
			CASE
				WHEN DATE(order_delivered_customer_date) >= DATE(order_estimated_delivery_date)
				THEN 1
				ELSE 0
			END
		) / COUNT(*),
		2
	) AS late_delivery_rate
    
    FROM orders
    WHERE order_status = 'delivered';
  
  
  -- Validation check to see missing dates
  -- ===================================================
  
    SELECT
    COUNT(*) AS delivered_orders,
    
    SUM(
        CASE
            WHEN order_delivered_customer_date IS NULL
            THEN 1 ELSE 0
        END
    ) AS missing_delivery_date,

    SUM(
        CASE
            WHEN order_estimated_delivery_date IS NULL
            THEN 1 ELSE 0
        END
    ) AS missing_estimated_date

FROM orders
WHERE order_status = 'delivered';

-- =============================================================
-- Delivery delay checking ( Final Query)
-- =============================================================

SELECT
    COUNT(*) AS total_delivered_orders,

    SUM(
        CASE
            WHEN order_delivered_customer_date IS NOT NULL
             AND DATE(order_delivered_customer_date)
                 <= DATE(order_estimated_delivery_date)
            THEN 1
            ELSE 0
        END
    ) AS on_time_orders,

    SUM(
        CASE
            WHEN order_delivered_customer_date IS NOT NULL
             AND DATE(order_delivered_customer_date)
                 > DATE(order_estimated_delivery_date)
            THEN 1
            ELSE 0
        END
    ) AS late_orders,

    SUM(
        CASE
            WHEN order_delivered_customer_date IS NULL
            THEN 1
            ELSE 0
        END
    ) AS unknown_delivery_status,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_delivered_customer_date IS NOT NULL
                 AND DATE(order_delivered_customer_date)
                     > DATE(order_estimated_delivery_date)
                THEN 1
                ELSE 0
            END
        )
        /
        SUM(
            CASE
                WHEN order_delivered_customer_date IS NOT NULL
                THEN 1
                ELSE 0
            END
        ),
        2
    ) AS late_delivery_rate

FROM orders
WHERE order_status = 'delivered';

-- ==============================================================
-- Customer satisfaction based on Review Score 
-- ==============================================================

SELECT 
	COUNT(r.review_id) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS avg_reveiw_score,
    MIN(r.review_score) AS min_review_score,
    MAX(r.review_score) AS max_review_score
FROM order_reviews r
JOIN orders o
	ON o.order_id = r.order_id
WHERE o.order_status = 'delivered';

SELECT
    COUNT(*) AS total_review_rows,
    COUNT(DISTINCT review_id) AS distinct_reviews,
    COUNT(DISTINCT order_id) AS reviewed_orders
FROM order_reviews;

-- ============================================================
-- Review score distribution
-- ============================================================

SELECT 
	review_score,
    COUNT(*) AS review_count,
    ROUND(
		100 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
	) AS review_percentage
FROM order_reviews r
JOIN orders o
	ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY review_score
ORDER BY review_score

-- ===========================================================
-- average review score for on-time vs late orders.
-- ===========================================================

SELECT 
	CASE
		WHEN DATE(o.order_delivered_customer_date)
        <= (o.order_estimated_delivery_date)
        THEN 'On time'
        ELSE 'Late'
	END AS delivery_status,
    
    COUNT(DISTINCT r.review_id) AS review_count,
    
    ROUND(AVG(r.review_score), 2) AS avg_review_score
    
FROM order_reviews r
JOIN orders o
	ON o.order_id = r.order_id

WHERE o.order_status = 'delivered'
	AND o.order_delivered_customer_date IS NOT NULL

GROUP BY delivery_status
ORDER BY delivery_status;











