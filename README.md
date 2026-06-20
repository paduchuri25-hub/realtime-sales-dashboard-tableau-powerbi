# Real-Time Sales Analytics Dashboard — Tableau & Power BI

An end-to-end **real-time sales analytics** project built in both **Tableau** and **Power BI**. This repository documents the full build: a streaming data source, a SQL star-schema data model, auto-refreshing dashboards, and a step-by-step walkthrough so you can reproduce it yourself.

---

## Project Overview

The goal is to monitor retail sales **as transactions happen** — tracking revenue, order volume, average order value (AOV), and regional performance on dashboards that refresh automatically. The same metrics are built in Tableau and Power BI so the two tools can be compared side by side.

## Tech Stack

- **Data source:** Simulated transactional feed (can be swapped for Azure Event Hub, a REST API, or Kafka)
- **Database:** SQL Server / PostgreSQL (star schema)
- **BI tools:** Tableau (Live connection + extract refresh), Power BI (DirectQuery + auto page refresh)
- **Languages:** SQL, DAX, Python (data generator)

## Repository Structure

```
realtime-sales-dashboard-tableau-powerbi/
├── README.md                  <- This file
├── data/
│   └── data-model.md          <- Star-schema design notes
├── sql/
│   └── schema.sql             <- Table definitions (fact + dimensions)
├── powerbi/
│   └── README.md              <- Power BI build steps (.pbix lives here)
└── tableau/
    └── README.md              <- Tableau build steps (.twbx lives here)
```

---

## Step-by-Step Walkthrough

### Step 1 — Define the use case
Live retail sales monitoring: orders, revenue, AOV, and regional performance, updated continuously.

### Step 2 — Set up a streaming data source
A generator pushes transaction records into the database every few seconds. For a true production stream, replace it with Azure Event Hub, a REST API, or Kafka.

### Step 3 — Build the data model
Design a **star schema**: a `fact_sales` table at the center, surrounded by `dim_product`, `dim_region`, and `dim_date` dimensions. See `sql/schema.sql` and `data/data-model.md`.

### Step 4 — Power BI (DirectQuery + auto page refresh)
Connect to the database with **DirectQuery**, then enable **automatic page refresh** so KPI cards (revenue, order count, AOV) update without manual reloads.

### Step 5 — Tableau (live connection + extract refresh)
Create a **live connection** for real-time visuals and schedule **extract refreshes** for heavier views. Add parameter-driven filters for region and time window.

### Step 6 — Design the dashboards
KPI cards at the top, a revenue trend line, a regional performance map, and a top-products bar chart — mirrored across both tools for an apples-to-apples comparison.

### Step 7 — Publish & share
Deploy to **Power BI Service** and **Tableau Public / Server**, applying row-level security where needed.

---

## Key Takeaways

- Power BI's automatic page refresh felt smoother for true real-time KPIs.
- Tableau offered more flexibility on visual design and formatting.
- The right choice depends on your existing data stack and team skills.

## How to Reproduce

1. Clone this repo.
2. Run `sql/schema.sql` against your database.
3. Start the data generator to populate `fact_sales`.
4. Open the Power BI and Tableau files and point them at your connection.
5. Enable auto-refresh and publish.

---

*Built as a portfolio project to demonstrate real-time BI workflows across Tableau and Power BI.*
