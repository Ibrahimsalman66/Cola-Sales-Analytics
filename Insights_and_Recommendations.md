# 📊 Insights & Recommendations
### Cola Sales Analytics — Business Intelligence Report

> This document synthesizes key findings from the three Power BI dashboards and translates them into concrete, actionable business recommendations for commercial, financial, and field operations teams.

---

## 🔷 1. Financial Performance Insights

### 1.1 Gross Margin Is Structurally Thin at 24.32%

With a Net Revenue of **2.82bn EGP** and Total COGS of **2.14bn EGP**, the company is retaining roughly 24 cents of gross profit for every EGP of revenue. In the FMCG beverages sector, this is not alarming — but it leaves limited room for error on promotional discounts, logistics cost overruns, or raw material price increases.

**Critical observation:** The monthly gross margin % line in the combo chart is relatively flat across all 12 months (hovering between 24.2% and 24.4%), which indicates that margin compression is systemic rather than seasonal. This rules out "bad months" as an explanation and points to structural cost or pricing dynamics.

### 1.2 Pepsi Dominates Brand-Level Margin Contribution, But Mid-Tier Brands Underperform

The Gross Margin by Brand chart reveals a clear power-law distribution:
- **Pepsi** leads at **145M EGP**
- **V7** follows at **137M EGP**
- **Sina Cola** at **130M EGP**
- The bottom three brands (**Spiro Spathis, Shams-Cola, Big Cola**) collectively contribute only ~165M EGP — less than Pepsi alone

This concentration risk means that any supply disruption, price war, or listing loss affecting the top two brands would disproportionately damage overall profitability.

### 1.3 PET Packaging Drives 61% of Gross Margin

The sub-category donut chart shows that **PET bottles account for 419M EGP (61.07%)** of gross margin, while **Glass contributes 143M (20.76%)** and **Can contributes 125M (18.16%)**.

This is strategically important: PET's dominance likely reflects both volume scale and better unit economics. However, glass and can formats may serve premium or on-premise channels that carry higher price points — the raw margin contribution underrepresents their strategic value.

### 1.4 Monthly Revenue Is Volatile in Q1

The monthly bar chart shows January through March experiencing elevated Net Revenue (consistently above 250M–300M), which then drops sharply in May and stabilizes at ~200M–230M for the remainder of the year. This Q1 spike likely reflects post-holiday restocking, seasonal promotional bursts, or annual trade deal renewals. The drop in Q2 is steep enough to warrant investigation into whether it reflects genuine demand softening or delayed order fulfilment.

---

## 🔷 2. Sales Growth & Target Achievement Insights

### 2.1 The Company Is Growing — But Missing Its Collective Target

- **YoY Growth of 8.31%** (from 2.61bn to 2.82bn EGP) is a healthy commercial result
- However, the **94.04% Target Achievement** means the company fell short of its 3.00bn target by approximately **178M EGP**
- This gap is not trivial — it represents roughly **6.5% of actual revenue** left on the table relative to plan

The gauge chart visualization makes this gap visually clear and provides a strong basis for commercial review conversations.

### 2.2 Individual Salesperson Achievement Is Narrowly Clustered — But Consistently Below Target

From the visible salesperson table, all five displayed reps (Aaron Lopez, Adam Patterson, Adam Ramirez, Adrian Williams, Alexa Matthews) are achieving between **77.5% and 98.24%** of their individual targets. Notably:

- **Aaron Lopez** is the weakest at **77.51%** — a 22.5% shortfall is operationally significant and warrants investigation into whether his territory targets are realistic or whether his execution is lagging
- **Adam Ramirez** is closest to target at **98.24%**, suggesting his territory, product mix, or customer base is better aligned with planned expectations
- No salesperson in the visible set is **over-achieving**, which suggests targets may have been set at stretch levels, OR that there is a systemic execution gap across the entire sales force

### 2.3 Q1 Revenue Spike Does Not Reflect Sustained Growth

The dual-line monthly chart clearly shows that both current year and prior year revenue peak in Q1 and then contract. The gap between current year (light blue area) and prior year (dark blue line) is **largest in Q1 and Q2**, then converges in the second half of the year.

This means most of the **8.31% YoY growth is front-loaded** — if the current year trend holds, H2 growth contribution is marginal. The company should investigate whether its go-to-market investments (promotions, new listings, key account negotiations) are being deployed disproportionately in Q1.

---

## 🔷 3. Visits Performance Insights

### 3.1 One in Three Visits Results in No Order — Strike Rate Has Room to Improve

With **400K total visits** and only **259.85K active visits**, the **Strike Rate of 64.96%** means that approximately **140,000 field visits generated zero orders**. At an average fully-loaded cost of a field visit (fuel, time, device cost), this represents a significant inefficiency.

The variance in strike rate across salespeople (ranging from ~66.5% down to ~66% for the visible cohort) appears small in absolute terms, but at this volume, even a **1% improvement in strike rate** would add roughly **4,000 productive visits** — equivalent to more than a full month of one salesperson's workload.

### 3.2 Out-of-Stock Is Highest in Cairo — But That May Be a Volume Effect

The "Total Out-of-Stock by Province" chart shows **Cairo leading at 16.4K** in absolute terms. However, the percentage-based bar chart shows Cairo is NOT the worst performer on a relative basis. Provinces like **Alexandria (85.28%)** and **Giza (84.3%)** have significantly higher OOS rates as a percentage of their visits.

This distinction is critical for prioritization:
- Cairo's high absolute OOS count reflects its market size, not necessarily poor execution
- Alexandria and Giza have structural OOS problems relative to their visit frequency and need targeted replenishment or route planning interventions

### 3.3 Out-of-Stock Declined Sharply After Q1 — Then Stabilized at a Sub-Optimal Level

The monthly OOS trend chart shows a dramatic drop from ~14K in January to ~10K from May onwards. This improvement may reflect operational improvements (new warehouse allocations, improved routing) or seasonal demand normalization. However, the fact that it stabilized at 10K+ for the rest of the year — rather than continuing to decline — suggests the remaining OOS events are structural, not transient.

### 3.4 South Sinai Has the Lowest OOS Rate — A Best Practice Signal

**South Sinai at 46.02%** is the lowest OOS rate in the country. While this may partly reflect lower demand complexity, it also signals that the operational model in this territory (route density, replenishment frequency, or salesperson behavior) could contain learnable practices for higher-OOS provinces.

---

## 🔷 4. Actionable Business Recommendations

### 💰 Financial Recommendations

| # | Recommendation | Priority |
|---|---|---|
| F1 | Launch a **brand portfolio review** for Shams-Cola and Big Cola — assess whether these brands are generating sufficient margin contribution to justify shelf space and salesperson attention relative to higher-margin alternatives | High |
| F2 | Investigate the **Q1 revenue spike and Q2 contraction** — determine whether this is driven by promotional timing and consider redistributing trade spend to smooth monthly revenue and reduce H1 dependency | High |
| F3 | Conduct a **sub-category pricing audit** for Glass and Can SKUs — if these formats serve premium channels, ensure their pricing reflects that positioning, as their current margin contribution appears disproportionately low relative to their strategic value | Medium |
| F4 | Model the **impact of a 1–2% gross margin improvement** scenario across the top 3 brands — given the structural flatness of the margin %, even small unit economics improvements at scale compound significantly | Medium |

### 📈 Growth & Target Recommendations

| # | Recommendation | Priority |
|---|---|---|
| G1 | Conduct a **territory-level target calibration exercise** — Aaron Lopez's 77.51% achievement (vs Adam Ramirez's 98.24%) could reflect either an over-ambitious territory target or an execution gap; distinguishing between these two causes determines whether the fix is in planning or coaching | High |
| G2 | Implement a **mid-year target review mechanism** — given the Q1 revenue front-loading, the company should formally review H2 trajectory in July to adjust expectations or redeploy commercial resources | High |
| G3 | Identify and replicate the top 20% of salespeople's behaviors — specifically their **visit-to-order conversion rate, product mix sold, and promotional utilization** — across the broader sales force | Medium |
| G4 | Build a **YoY growth decomposition analysis** (price vs volume vs mix) to determine how much of the 8.31% growth is attributable to genuine volume growth versus inflation-driven price increases | Medium |

### 🚗 Visits Performance Recommendations

| # | Recommendation | Priority |
|---|---|---|
| V1 | Investigate the **140K non-productive visits** — segment them by store type, visit time, and salesperson to determine whether these are genuinely zero-opportunity visits or missed conversion opportunities that can be recovered with better pre-call planning or promotional tools | High |
| V2 | Deploy a **targeted replenishment task force in Alexandria and Giza** — their 85%+ relative OOS rates indicate a persistent supply chain or route coverage gap that is actively costing sales | High |
| V3 | Study the **South Sinai model** — interview the responsible sales team or analyze visit patterns, delivery frequency, and store grade mix to extract practices transferable to higher-OOS provinces | Medium |
| V4 | Set a **Strike Rate improvement target of +3% for the next cycle** (from ~65% to ~68%) with structured incentives — at 400K annual visits, this translates to approximately 12,000 additional productive visits | Medium |
| V5 | Analyze the **seasonal OOS pattern** — the January–April spike in OOS likely correlates with Q1 demand surge; pre-position additional stock or increase delivery frequency in those months to avoid supply-side revenue leakage during the highest-revenue period | Low |

---

## 🔷 5. Summary — Priority Action Matrix

| Action | Business Impact | Effort | Owner |
|---|---|---|---|
| Territory target calibration | High | Medium | Sales Management |
| Alexandria/Giza OOS task force | High | Medium | Supply Chain + Field Ops |
| Brand portfolio review (Shams, Big Cola) | High | Low | Commercial / Marketing |
| Q1 trade spend redistribution | High | High | Trade Marketing |
| Strike rate improvement program | Medium | Medium | Sales Management |
| South Sinai best practice extraction | Medium | Low | Field Operations |
| Sub-category pricing audit | Medium | Medium | Revenue Management |
| Mid-year target review mechanism | Medium | Low | Finance + Sales |

---

*Prepared based on Power BI dashboard analysis of Cola Sales Analytics project. All figures reference the full-year unfiltered view unless otherwise stated.*
