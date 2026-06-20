-- ============================================================
-- Real-Time Sales Analytics — Star Schema
-- Database: SQL Server / PostgreSQL compatible
-- ============================================================

-- Dimension: Date
CREATE TABLE dim_date (
    date_key      INT PRIMARY KEY,      -- e.g. 20260101
    full_date     DATE NOT NULL,
    day_of_week   VARCHAR(10),
    month_name    VARCHAR(10),
    quarter       INT,
    year          INT
);

-- Dimension: Product
CREATE TABLE dim_product (
    product_key   INT PRIMARY KEY,
    product_name  VARCHAR(100) NOT NULL,
    category      VARCHAR(50),
    unit_price    DECIMAL(10,2)
);

-- Dimension: Region
CREATE TABLE dim_region (
    region_key    INT PRIMARY KEY,
    region_name   VARCHAR(50) NOT NULL,
    country       VARCHAR(50)
);

-- Fact: Sales (the real-time stream lands here)
CREATE TABLE fact_sales (
    sale_id       BIGINT PRIMARY KEY,
    date_key      INT NOT NULL REFERENCES dim_date(date_key),
    product_key   INT NOT NULL REFERENCES dim_product(product_key),
    region_key    INT NOT NULL REFERENCES dim_region(region_key),
    quantity      INT NOT NULL,
    revenue       DECIMAL(12,2) NOT NULL,
    order_ts      TIMESTAMP NOT NULL    -- transaction timestamp for real-time tracking
);

-- Helpful indexes for live dashboard queries
CREATE INDEX idx_fact_sales_date   ON fact_sales(date_key);
CREATE INDEX idx_fact_sales_region ON fact_sales(region_key);
CREATE INDEX idx_fact_sales_ts     ON fact_sales(order_ts);

-- Example KPI query used by the dashboards
-- Today's revenue, order count, and average order value
SELECT
    COUNT(*)                       AS order_count,
    SUM(revenue)                   AS total_revenue,
    SUM(revenue) / NULLIF(COUNT(*),0) AS avg_order_value
FROM fact_sales
WHERE order_ts >= CURRENT_DATE;
