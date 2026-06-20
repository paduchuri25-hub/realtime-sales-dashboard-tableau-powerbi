# Power BI — Real-Time Sales Dashboard

This folder holds the Power BI report (`.pbix`) and the build notes.

## Build Steps

1. **Connect** to the database using **DirectQuery** (Get Data > SQL Server > DirectQuery).
2. **Model** the star schema: relate `fact_sales` to `dim_date`, `dim_product`, and `dim_region` on their keys.
3. **Create measures** (DAX):
   - Total Revenue = SUM(fact_sales[revenue])
   - Order Count = DISTINCTCOUNT(fact_sales[sale_id])
   - Avg Order Value = DIVIDE([Total Revenue], [Order Count])
4. **Build visuals**:
   - KPI cards: Total Revenue, Order Count, Avg Order Value
   - Line chart: Revenue over time (order_ts)
   - Map: Revenue by region
   - Bar chart: Top products by revenue
5. **Enable auto page refresh** (Format > Page refresh) so KPIs update in near real time.
6. **Publish** to the Power BI Service and set a refresh schedule / gateway as needed.

## Notes

- DirectQuery keeps data live but pushes query load to the source — index the fact table (see `/sql/schema.sql`).
- Apply **Row-Level Security** if different users should only see their region.

> Place the actual `SalesDashboard.pbix` file in this folder.
