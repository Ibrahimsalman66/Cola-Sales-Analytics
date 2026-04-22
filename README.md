# 🥤 Cola Sales Analytics — End-to-End Business Intelligence Project

> A production-grade data analytics project built for a carbonated beverages company operating in both manufacturing and distribution. The project covers the full data pipeline — from raw flat files to a cleaned SQL data warehouse — and delivers three Power BI dashboards covering Financial Performance, Sales Growth & Target Achievement, and Field Visits Performance.

---

## 📌 Table of Contents

- [Overview](#overview)
- [Objectives](#objectives)
- [Tech Stack](#tech-stack)
- [Data Description](#data-description)
- [Data Processing Workflow](#data-processing-workflow)
- [Dashboards Overview](#dashboards-overview)
- [Key Performance Indicators](#key-performance-indicators)
- [Business Value](#business-value)
- [Project Structure](#project-structure)
- [How to Use](#how-to-use)

---

## 🧭 Overview

This project delivers a complete Business Intelligence solution for a carbonated beverages company with a nationwide distribution network across Egypt. The raw operational data — spanning sales transactions, store visits, promotional activity, and market share — was ingested into SQL Server, cleaned and transformed using custom SQL logic, and then modeled and visualized in Power BI.

The result is a multi-page interactive dashboard system that enables executives, sales managers, and field supervisors to monitor financial health, track salesperson performance against targets, and optimize field execution.

---

## 🎯 Objectives

- Build a reliable, clean data warehouse from raw flat files with over **2 million sales transactions**
- Identify and resolve critical data quality issues: duplicates, invalid dates, ghost store references, and business logic violations
- Create a star schema data model optimized for Power BI performance
- Deliver three decision-ready dashboards covering:
  - Financial performance and profitability
  - Sales growth and target achievement
  - Field visits and out-of-stock execution
- Surface actionable insights that drive commercial decisions

---

## 🛠️ Tech Stack

| Layer | Tool |
|---|---|
| Data Storage & Cleaning | Microsoft SQL Server |
| Query Language | T-SQL (CTEs, Window Functions, Views) |
| Visualization | Microsoft Power BI |
| Data Source | Flat Files (CSV/Excel) |
| Data Modeling | Star Schema (Fact + Dimension Tables) |

---

## 🗂️ Data Description

The data warehouse is built around a **star schema** with 3 fact tables and 6 dimension tables.

### Fact Tables

| Table | Description | Key Metrics |
|---|---|---|
| `Fact_Sales` | Core transactional table — 2M+ rows of invoice-level sales data | Quantity, Gross Sales, Net Sales, COGS, Discounts, Returns |
| `Fact_Targets` | Monthly sales targets assigned per salesperson | Target Amount (EGP) |
| `Fact_Visits` | Field visit records by salesperson and store | Visit type, order placement, OOS count, GPS validation |
| `Fact_Market_Share` | Competitor and brand-level market share data by region | Volume share %, Value share %, Shelf space share |

### Dimension Tables

| Table | Description |
|---|---|
| `Dim_Calendar` | Date dimension with year, quarter, month, and weekend flag |
| `Dim_Geography` | Province, city, territory, population density, and warehouse mapping |
| `Dim_Products` | Product catalog with brand, sub-category, flavor, cost, price, and shelf life |
| `Dim_Stores` | Store master with channel, grade, sub-channel, payment terms, and GPS coordinates |
| `Dim_Salesmen` | Salesperson details including supervisor, position, commission rate, and hiring date |
| `Dim_Promotions` | Promotion catalog with discount %, budget, minimum quantity threshold, and objective |

---

## ⚙️ Data Processing Workflow

Raw data contained several quality issues that would have produced incorrect analytics if left unresolved. The following pipeline was applied in SQL Server before loading into Power BI.

### Step 1 — Data Ingestion
Flat files were imported into a dedicated database named **`Cola`** in SQL Server to enable SQL-based processing at scale and avoid Power BI performance degradation on 2M+ rows.

### Step 2 — Data Quality Audit

Four targeted diagnostic queries were written to identify specific issues:

**① Duplicate Transactions**
```sql
SELECT Transaction_ID, COUNT(*) AS number_of_copies
FROM Fact_Sales
GROUP BY Transaction_ID
HAVING COUNT(*) > 1
ORDER BY number_of_copies DESC;
```
Identified invoice IDs that appeared more than once, which would inflate revenue figures.

**② Invalid or Malformed Date Formats**
```sql
SELECT TOP 20 Transaction_ID, Date_Key
FROM Fact_Sales
WHERE Date_Key LIKE '%/%' OR ISDATE(Date_Key) = 0;
```
Detected dates stored as text in inconsistent formats (Egyptian DD/MM/YYYY and US MM/DD/YYYY mixed together).

**③ Ghost Store References**
```sql
SELECT fs.Store_Key AS ghost_store_key
FROM Fact_Sales fs
LEFT JOIN Dim_Stores ds ON fs.Store_Key = ds.Store_Key
WHERE ds.Store_Key IS NULL;
```
Surfaced transactions linked to stores that don't exist in the store master — orphaned foreign keys that would cause incorrect geographic analysis.

**④ Business Logic Violation — Returns Exceeding Sales**
```sql
SELECT Transaction_ID, Quantity_Cases, Qty_Returned, Return_Reason
FROM Fact_Sales
WHERE Qty_Returned > Quantity_Cases;
```
Identified rows where returned quantity exceeded original sold quantity — a data entry error that would produce negative net sales.

### Step 3 — Data Cleaning View

All issues were resolved in a single reusable SQL View: `vw_Fact_Sales_Clean`

```sql
CREATE VIEW vw_Fact_Sales_Clean AS
WITH RankedSales AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY Transaction_ID ORDER BY Date_Key DESC) AS row_num
    FROM Fact_Sales
)
SELECT
    Transaction_ID,
    COALESCE(TRY_CAST(Date_Key AS DATE), TRY_CONVERT(DATE, Date_Key, 103)) AS Clean_Date,
    fs.Store_Key,
    fs.Product_Key,
    fs.Salesman_Key,
    fs.Promo_Key,
    Order_Source,
    Quantity_Cases,
    CASE
        WHEN Qty_Returned > Quantity_Cases THEN Quantity_Cases
        ELSE Qty_Returned
    END AS Qty_Returned,
    Return_Reason,
    Gross_Sales,
    Discount_Amount,
    Net_Sales,
    COGS
FROM RankedSales fs
INNER JOIN Dim_Stores ds ON fs.Store_Key = ds.Store_Key
WHERE row_num = 1;
```

**Fixes applied inside this view:**

| Issue | Fix Applied |
|---|---|
| Duplicate transactions | `ROW_NUMBER()` keeps only the most recent version of each invoice |
| Mixed date formats | `TRY_CAST` + `TRY_CONVERT(..., 103)` handles both ISO and Egyptian DD/MM/YYYY formats |
| Ghost store keys | `INNER JOIN` to `Dim_Stores` silently excludes orphaned transactions |
| Returns > Sales | `CASE` statement caps `Qty_Returned` at `Quantity_Cases` as the logical maximum |

### Step 4 — Power BI Modeling
The cleaned view and dimension tables were connected in Power BI using a star schema. DAX measures were written for all KPIs including YoY Growth, Target Achievement %, Strike Rate, and Gross Margin %.

---

## 📊 Dashboards Overview

### 1. 📈 Sales Growth & Target Achievement
Tracks salesperson performance against monthly targets with year-over-year growth analysis.

- **Gauge chart** comparing Net Revenue (2.82bn) vs Total Target (3.00bn)
- **Salesperson table** showing individual Net Revenue, Total Target, and Target Achievement %
- **Dual-line time series** comparing current year vs prior year revenue by month
- Filters: Year, Quarter

### 2. 💰 Financial Performance Overview
Monitors the company's overall profitability and cost structure.

- **KPI cards** for Net Revenue, Total Cost, Gross Margin, and Gross Margin %
- **Combo chart** showing monthly Net Revenue (bar) overlaid with Gross Margin % trend (line)
- **Bar chart** ranking brands by Gross Margin contribution
- **Donut chart** breaking down Gross Margin by Sub-Category (PET, Glass, Can)
- Filters: Year, Quarter

### 3. 🚗 Visits Performance
Measures field execution quality, order conversion, and out-of-stock distribution.

- **KPI cards** for Total Visits, Active Visits, Strike Rate %, and Total Out-of-Stock
- **Bar chart** ranking top salespeople by Strike Rate %
- **Line chart** showing monthly Out-of-Stock trend
- **Horizontal bar chart** comparing Out-of-Stock availability rates by Province (with % of total)
- Filters: Year, Territory

---

## 📐 Key Performance Indicators

### Financial KPIs
| KPI | Value |
|---|---|
| Net Revenue | 2.82bn EGP |
| Total Cost (COGS) | 2.14bn EGP |
| Gross Margin | 686.58M EGP |
| Gross Margin % | 24.32% |

### Growth & Target KPIs
| KPI | Value |
|---|---|
| Total Target | 3.00bn EGP |
| Target Achievement % | 94.04% |
| PY Revenue | 2.61bn EGP |
| YoY Growth | 8.31% |

### Visits Performance KPIs
| KPI | Value |
|---|---|
| Total Visits | 400K |
| Total Active Visits | 259.85K |
| Strike Rate % | 64.96% |
| Total Out-of-Stock | 131.66K |

---

## 💼 Business Value

This project solves real operational challenges for a FMCG distribution company:

- **Revenue assurance** — Duplicate and ghost-store transactions are filtered out before any metric is calculated, ensuring reported revenue reflects reality
- **Target management** — Sales managers can instantly identify which salespeople are under-performing against targets and investigate whether the gap is in visit frequency, strike rate, or product availability
- **Margin optimization** — Brand and sub-category margin breakdowns allow the commercial team to prioritize high-margin SKUs in promotional and field execution planning
- **Field operations** — Out-of-stock tracking by province and month exposes geographic and seasonal patterns, enabling proactive replenishment and territory planning
- **Scalability** — The SQL-first architecture means adding new months of data only requires refreshing the source tables; the view and Power BI model update automatically

---

## 🗃️ Project Structure

```
Cola-Sales-Analytics/
│
├── SQL/
│   └── SQLQuery1.sql              # Schema creation, audit queries, and cleaning view
│
├── PowerBI/
│   └── Cola_Sales_Dashboard.pbix  # Full Power BI report (3 dashboard pages)
│
├── Screenshots/
│   ├── 01_Sales_Growth_Target.png
│   ├── 02_Financial_Performance.png
│   └── 03_Visits_Performance.png
│
├── Insights_and_Recommendations.md
└── README.md
```

---

## 🚀 How to Use

### Prerequisites
- Microsoft SQL Server (2019 or later recommended)
- SQL Server Management Studio (SSMS)
- Power BI Desktop (latest version)

### Setup Steps

1. **Create the database**
   ```sql
   CREATE DATABASE Cola;
   USE Cola;
   ```

2. **Run the schema script**
   Open `SQL/SQLQuery1.sql` in SSMS and execute it to create all dimension and fact tables.

3. **Import flat files**
   Use SQL Server's Import/Export Wizard or `BULK INSERT` to load the raw CSV data into the corresponding tables.

4. **Create the cleaning view**
   Execute the `CREATE VIEW vw_Fact_Sales_Clean` section from the SQL script.

5. **Connect Power BI**
   Open `Cola_Sales_Dashboard.pbix` in Power BI Desktop. Update the SQL Server connection string to point to your local or remote `Cola` database instance.

6. **Refresh data**
   Click **Refresh** in Power BI to load the latest data through the cleaning view.

---

## 👤 Author

Built as part of a professional data analytics portfolio, demonstrating end-to-end skills across data engineering, SQL transformation, dimensional modeling, and business intelligence visualization.

---

*Tools: SQL Server · T-SQL · Power BI · DAX · Star Schema Modeling*
