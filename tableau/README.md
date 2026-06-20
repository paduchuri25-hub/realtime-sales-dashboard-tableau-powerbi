# Tableau — Real-Time Sales Dashboard

This folder holds the Tableau workbook (`.twbx`) and the build notes.

## Build Steps

1. **Connect** to the database with a **Live connection** (Connect > To a Server > your DB).
2. **Join** the star schema: `fact_sales` joined to `dim_date`, `dim_product`, and `dim_region` on their keys.
3. **Create calculated fields**:
   - Total Revenue = SUM([Revenue])
   - Order Count = COUNTD([Sale Id])
   - Avg Order Value = [Total Revenue] / [Order Count]
4. **Build sheets**:
   - KPI text/BAN sheets: Total Revenue, Order Count, Avg Order Value
   - Line chart: Revenue by order_ts
   - Filled map: Revenue by region
   - Bar chart: Top products by revenue
5. **Assemble a dashboard** and add **parameter-driven filters** for region and time window.
6. **Schedule extract refreshes** for heavier views; keep KPI sheets on the live connection.
7. **Publish** to Tableau Public or Tableau Server with row-level security where needed.

## Notes

- Use a **live connection** for true real-time KPIs and **extracts** for performance on large historical views.
- Parameters + filter actions make the dashboard interactive without slowing the live query.

> Place the actual `SalesDashboard.twbx` file in this folder.
