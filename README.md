# Olist E-Commerce Data Analytics

## Project Overview
This project analyzes the Olist Brazilian e-commerce dataset using MySQL and Power BI.

## Objective
Turn transactional e-commerce data into validated KPIs, interactive dashboards, and business recommendations.

## Tools
- MySQL 8.0
- Power BI
- DAX
- GitHub

## Data Source
This project uses the **Brazilian E-Commerce Public Dataset by Olist**, a publicly available dataset provided by Olist and hosted on Kaggle.

The dataset contains approximately **100,000 orders from 2016–2018** and includes information on customers, orders, order items, products, sellers, payments, reviews, delivery performance, and product categories.

- Source: Olist
- **Hosted on:** Kaggle
- **Coverage:** 2016–2018
- **License:** CC BY-NC-SA 4.0
- **Dataset:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Analysis Scope
- Core analysis uses `order_status = 'delivered'`.
- Revenue = `SUM(order_items.price)`; freight excluded.
- Customer analysis uses `customer_unique_id`.
- Delivery late rate uses orders with known actual delivery dates.
- Final review metrics use the complete Power BI review dataset because the SQL review table had an incomplete import during development.

## Dashboard
### Page 1 — Executive Sales Overview
Executive KPIs, revenue/order trend, and category performance.

### Page 2 — Customer & Product Analysis
Customer revenue distribution, revenue concentration, customer segmentation, product rankings, and category performance.

### Page 3 — Seller & Customer Experience
Seller revenue/volume performance, delivery reliability, review distribution, and delivery status vs customer satisfaction.

## Key Results
- Revenue: **$13,221,498.11**
- Delivered orders: **96,478**
- Delivered customers: **93,358**
- Average order value: **$137.04**
- Average customer revenue: **$141.62**
- Sellers with delivered-order sales: **2,970**
- Average delivery time: **12.50 days**
- On-time delivery: **93.23%** of orders with known delivery status
- Late delivery: **6.77%**
- Average review score: **4.16 / 5**
- Delivered-order reviews: **95,647**

## Key Business Insights
1. The top 10% of customers generated **41.10%** of revenue, showing substantial revenue concentration.
2. Customer revenue is right-skewed: median **$89.73** versus average **$141.62**.
3. The highest-revenue product is not the highest-volume product, so revenue and units provide different views of product performance.
4. The highest-volume seller is not the highest-revenue seller, indicating the importance of product mix and price.
5. **93.23%** of known-status deliveries were on time.
6. On-time orders averaged **4.29** stars versus **2.27** for late orders. This is an association, not proof of causation.
7. 4–5 star reviews represented approximately **79%** of delivered-order reviews.

## Recommendations
- Consider targeted retention/loyalty initiatives for high-value customers.
- Investigate drivers of late delivery and monitor their effect on customer satisfaction.
- Evaluate products and categories using both revenue and units sold.
- Evaluate sellers using revenue and volume together, with attention to product mix.
- Investigate high-value customer/product outliers for additional commercial opportunities.

## Project Files

### SQL Analysis

- [Data Validation](sql/01_data_validation.sql)
- [Executive Sales KPIs](sql/02_executive_kpis.sql)
- [Customer Analysis](sql/03_customer_analysis.sql)
- [Product Analysis](sql/04_product_analysis.sql)
- [Seller Analysis](sql/05_seller_analysis.sql)
- [Customer Experience](sql/06_customer_experience.sql)

### Power BI Dashboard

The Power BI `.pbix` file is hosted externally due to GitHub file size limitations.

- [Download Power BI Dashboard](PowerBI/olist_ecommerce_sales_analysis)

### Dashboard Screenshots

- [Executive Sales Overview](Screenshots/01_Executive_Overview.png)
- [Customer & Product Analysis](Screenshots/02_Customer_Product.png)
- [Seller & Customer Experience](Screenshots/03_Seller_Customer_Experience.png)

### Documentation

- [Project Notes](Documentation/Project_Notes.md)
