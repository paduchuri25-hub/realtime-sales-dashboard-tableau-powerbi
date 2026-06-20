# Data Model — Star Schema

The project uses a classic **star schema** optimized for fast, real-time aggregation on dashboards.

## Fact Table

### `fact_sales`
The central table. The streaming source inserts one row per transaction.

| Column      | Type           | Notes                                   |
|-------------|----------------|-----------------------------------------|
| sale_id     | BIGINT (PK)    | Unique transaction id                   |
| date_key    | INT (FK)       | Links to dim_date                       |
| product_key | INT (FK)       | Links to dim_product                    |
| region_key  | INT (FK)       | Links to dim_region                     |
| quantity    | INT            | Units sold                              |
| revenue     | DECIMAL(12,2)  | Line revenue                            |
| order_ts    | TIMESTAMP      | Transaction time (drives real-time view)|

## Dimension Tables

### dim_date
Standard calendar dimension (date_key, full_date, day_of_week, month_name, quarter, year).

### dim_product
Product attributes (product_key, product_name, category, unit_price).

### dim_region
Geography (region_key, region_name, country).

## Why a Star Schema?

- **Fast aggregations** — dashboards sum/average the fact table grouped by dimensions.
- **Simple joins** — one hop from fact to each dimension keeps live queries cheap.
- **Tool-friendly** — both Tableau and Power BI model star schemas natively.

## Core Metrics (DAX / SQL)

- **Total Revenue** = SUM(revenue)
- **Order Count** = COUNT(sale_id)
- **Average Order Value (AOV)** = Total Revenue / Order Count
- **Revenue by Region** = SUM(revenue) grouped by region_name
