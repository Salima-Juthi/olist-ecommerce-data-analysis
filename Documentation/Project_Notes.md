# Olist E-Commerce Analytics — Project Notes

## 1. Project Rules
- Delivered orders only (`order_status = 'delivered'`).
- Revenue = `order_items.price`; freight excluded.
- Customer grain = `customer_unique_id`.

## 2. Executive KPIs
- Revenue: **$13,221,498.11**
- Delivered orders: **96,478**
- Delivered customers: **93,358**
- Average customer revenue: **$141.62**
- Average order value: **$137.04**

## 3. Customer Analysis
### Revenue Distribution
- P25: **$47.65**
- Median: **$89.73**
- P75: **$154.74**
- P90: **$279.99**
- P95: **$419.81**
- P99: **$1,004.99**
- Maximum: **$13,440**

### Revenue Concentration
- Top 1%: **11.46%**
- Top 5%: **29.13%**
- Top 10%: **41.10%**

Interpretation: customer revenue has a long upper tail and meaningful concentration among high-value customers.

## 4. Product Analysis
- Products with delivered-order sales: **32,216**
- Highest-revenue product: `bb50f2e236e5eea0100680137654686c` — **$63,560**
- Highest-volume product: `aca2eb7d00ea1a7b8ebd4e68314663af` — **520 units**
- Highest-revenue category: `beleza_saude` — **$1,233,131.72**
- Highest-volume category among the top-revenue categories: `cama_mesa_banho` — **10,953 units**
- Highest average-price category: `pcs` — about **$1,098.92**

## 5. Seller Analysis
- Sellers with delivered-order sales: **2,970**
- Highest-revenue seller: `4869f7a5dfa277a7dca6462dcf3b52b2` — **$226,987.93**
- Highest-volume seller: `6560211a19b47992c3666cc44a7e94c0` — **1,996 units**

Power BI seller count required `TREATAS` because the delivered-order filter did not propagate backward to Order Items under the model's single-direction relationship.

## 6. Customer Experience
### Delivery
- Average: **12.50 days**
- Minimum: **0 days**
- Maximum: **210 days**
- On time: **89,936**
- Late: **6,534**
- Unknown: **8**
- On-time rate among known status: **93.23%**
- Late rate: **6.77%**

### Reviews — final Power BI values
- All reviews: **98,410**
- Delivered-order reviews: **95,647**
- Average score: **4.16 / 5**

Distribution:
- 1 star: **9,311 (9.7%)**
- 2 stars: **2,911 (3.0%)**
- 3 stars: **7,889 (8.2%)**
- 4 stars: **18,862 (19.7%)**
- 5 stars: **56,674 (59.3%)**

Delivery status vs satisfaction:
- On Time: **4.29**
- Late: **2.27**

This is an association, not a causal conclusion.

## 7. Business Insights
### Revenue concentration
Top 10% of customers generate 41.10% of revenue. Consider targeted retention/loyalty strategies for high-value customers.

### Customer revenue distribution
Median revenue is $89.73 versus average $141.62, indicating a right-skewed distribution. Segment customers using business-friendly revenue bands.

### Product performance
Revenue and unit-volume leaders differ. Evaluate both metrics when assessing product performance.

### Seller performance
Revenue and volume leaders differ. Product mix and selling price should be considered alongside units.

### Delivery and satisfaction
Late deliveries are associated with substantially lower review scores. Investigate late-delivery drivers and monitor customer-experience effects.

## 8. Data Quality / Limitations
- Freight is excluded from the revenue definition.
- The Olist dataset is historical.
- Customer analysis uses `customer_unique_id`.
- Delivery/review analysis is observational.
- The SQL review table had an incomplete import during development; final review metrics come from the complete Power BI review table.

## Data & Modeling Notes
The project encountered and resolved practical data/modeling issues, including customer identity mapping, Power BI filter direction, DAX `TREATAS`

