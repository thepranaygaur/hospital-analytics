# Hospital Analytics — Business Insights

## Executive Summary

The hospital analytics project combines patient, appointment, admission, treatment, billing, doctor, and bed data to evaluate operational performance, patient outcomes, utilization, and financial performance.

Overall, the hospital processed **8,000 admissions** across **5,479 unique patients**, generated approximately **₹60.79M in billed revenue**, and recorded an **88.00% recovery rate**. Average length of stay was **4.43 days**.

## Key Findings

### 1. Monthly Admissions
Admissions decreased from **671 in November to 422 in December**, an approximate **37.1% month-over-month decline**.

**Action:** Investigate seasonality, appointment cancellations/no-shows, bed availability, referrals, and department-level demand.

### 2. Monthly Revenue
Revenue decreased from approximately **₹5.04M in November to ₹3.01M in December**, an approximate **40.3% decline**.

**Action:** Compare admission volume, average bill amount, revenue per admission, and department/service mix.

### 3. Department Performance
**Gynecology** had the highest admission volume with **1,218 admissions** and approximately **₹9.41M revenue**.

**ENT** recorded comparatively strong revenue per admission at approximately **₹8.12K**.

**Action:** Benchmark departments using admissions, revenue, revenue per admission, recovery rate, mortality rate, LOS, and wait time.

### 4. Patient Outcomes
- Recovery rate: **88.00%**
- Mortality rate: **1.19%**
- Other discharge outcomes include Referred and LAMA.

**Action:** Monitor discharge outcomes by department and admission type rather than relying on recovery rate alone.

### 5. Appointment Operations
The hospital handled **25,000 appointments** across Completed, Cancelled, Rescheduled, and No-Show statuses.

Wait time is available at appointment level.

**Action:** Track completion, cancellation, no-show, rescheduling, and average wait time by department to identify scheduling bottlenecks.

### 6. Bed Utilization
The hospital has **500 beds**:
- Occupied: **352**
- Available: **134**
- Maintenance: **14**

Current overall occupancy is approximately **70.4%** based on the bed-status table.

**Action:** Monitor occupancy by department and bed type, especially ICU capacity, because hospital-wide occupancy can hide local capacity constraints.

### 7. Financial Performance
Average bill amount is approximately **₹7.60K**. Billing also tracks insurance contribution, patient payment, and payment status.

Payment statuses are Paid, Pending, and Partially Paid.

**Action:** Separate billed revenue from collected cash and monitor pending/partially paid bills by department, insurance type, and time period.

## Data Quality & Governance

Preprocessing identified:
- Missing appointment wait times.
- Bed records without an associated admission.
- Synthetic source-data date inconsistencies.
- Treatment dates occurring after discharge; these were aligned to discharge date to keep treatment activity within the admission period.

The repository retains the original CSVs for transparency, while analysis and dashboards use the cleaned data.

## Recommended Management Actions

1. **Investigate the December decline** in admissions and revenue.
2. **Optimize department performance** using a balanced KPI scorecard.
3. **Improve appointment efficiency** by targeting high wait-time, cancellation, and no-show areas.
4. **Strengthen capacity planning** using department- and bed-type-level utilization.
5. **Improve revenue collection** by tracking pending and partially paid bills separately from billed revenue.

## Conclusion

The analysis shows a hospital with **8,000 admissions, 5,479 unique patients, ₹60.79M in billed revenue, and an 88% recovery rate**. The strongest management signal is the sharp December decline in both admissions and revenue. Gynecology is a major volume and revenue contributor, while ENT shows relatively strong revenue per admission.

The Power BI dashboard provides the monitoring layer, while the SQL analysis enables deeper drill-downs into admissions, departments, patients, appointments, beds, billing, and treatments.
