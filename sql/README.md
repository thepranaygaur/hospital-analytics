# SQL Analysis

SQL Server layer for the Hospital Analytics portfolio project.

- `01_database_setup.sql` — database, 7 tables, PK/FK constraints and indexes.
- `02_data_quality.sql` — NULL/duplicate/range/referential-integrity and billing checks.
- `03_admission_analysis.sql` — admissions, monthly trend, outcomes, recovery/mortality, age groups and LOS.
- `04_department_analysis.sql` — department admissions, revenue, recovery, mortality, LOS and wait time.
- `05_patient_analysis.sql` — demographics, insurance, appointments, doctors and billing.
- `06_advanced_analysis.sql` — CTEs, window functions, ranking, MoM analysis and business analysis.

The scripts use the actual project schema: `patients`, `doctors`, `appointments`, `admissions`, `treatments`, `billing`, and `beds`.
