/* Hospital Analytics - 03 Admission Analysis */
USE HospitalAnalytics;
GO
SELECT COUNT(DISTINCT admission_id) total_admissions,COUNT(DISTINCT patient_id) unique_patients,AVG(CAST(DATEDIFF(DAY,admission_date,discharge_date) AS DECIMAL(10,2))) avg_length_of_stay FROM dbo.admissions;
GO
SELECT YEAR(admission_date) admission_year,MONTH(admission_date) month_number,DATENAME(MONTH,admission_date) month_name,COUNT(*) total_admissions FROM dbo.admissions GROUP BY YEAR(admission_date),MONTH(admission_date),DATENAME(MONTH,admission_date) ORDER BY admission_year,month_number;
GO
WITH m AS(SELECT DATEFROMPARTS(YEAR(admission_date),MONTH(admission_date),1) month_start,COUNT(*) total_admissions FROM dbo.admissions GROUP BY DATEFROMPARTS(YEAR(admission_date),MONTH(admission_date),1)) SELECT month_start,total_admissions,LAG(total_admissions) OVER(ORDER BY month_start) previous_month,ROUND(100.0*(total_admissions-LAG(total_admissions) OVER(ORDER BY month_start))/NULLIF(LAG(total_admissions) OVER(ORDER BY month_start),0),2) mom_change_pct FROM m ORDER BY month_start;
GO
SELECT admission_type,COUNT(*) total_admissions,ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(),2) admission_share_pct FROM dbo.admissions GROUP BY admission_type ORDER BY total_admissions DESC;
SELECT discharge_status,COUNT(*) total_admissions,ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(),2) outcome_share_pct FROM dbo.admissions GROUP BY discharge_status ORDER BY total_admissions DESC;
SELECT COUNT(*) total_admissions,SUM(CASE WHEN discharge_status='Recovered' THEN 1 ELSE 0 END) recovered_cases,SUM(CASE WHEN discharge_status='Deceased' THEN 1 ELSE 0 END) deceased_cases,ROUND(100.0*SUM(CASE WHEN discharge_status='Recovered' THEN 1 ELSE 0 END)/COUNT(*),2) recovery_rate_pct,ROUND(100.0*SUM(CASE WHEN discharge_status='Deceased' THEN 1 ELSE 0 END)/COUNT(*),2) mortality_rate_pct FROM dbo.admissions;
GO
WITH age_groups AS(SELECT CASE WHEN p.age<18 THEN 'Under 18' WHEN p.age<=30 THEN '18-30' WHEN p.age<=45 THEN '31-45' WHEN p.age<=60 THEN '46-60' ELSE '60+' END age_group,CASE WHEN p.age<18 THEN 1 WHEN p.age<=30 THEN 2 WHEN p.age<=45 THEN 3 WHEN p.age<=60 THEN 4 ELSE 5 END sort_order FROM dbo.admissions a JOIN dbo.patients p ON a.patient_id=p.patient_id) SELECT age_group,COUNT(*) total_admissions FROM age_groups GROUP BY age_group,sort_order ORDER BY sort_order;
SELECT p.gender,COUNT(*) total_admissions FROM dbo.admissions a JOIN dbo.patients p ON a.patient_id=p.patient_id GROUP BY p.gender ORDER BY total_admissions DESC;
SELECT DATEDIFF(DAY,admission_date,discharge_date) length_of_stay_days,COUNT(*) admissions FROM dbo.admissions GROUP BY DATEDIFF(DAY,admission_date,discharge_date) ORDER BY length_of_stay_days;
