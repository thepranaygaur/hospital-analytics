/* Hospital Analytics - 02 Data Quality */
USE HospitalAnalytics;
GO
SELECT 'patients' table_name,COUNT(*) row_count FROM dbo.patients UNION ALL SELECT 'doctors',COUNT(*) FROM dbo.doctors UNION ALL SELECT 'appointments',COUNT(*) FROM dbo.appointments UNION ALL SELECT 'admissions',COUNT(*) FROM dbo.admissions UNION ALL SELECT 'treatments',COUNT(*) FROM dbo.treatments UNION ALL SELECT 'billing',COUNT(*) FROM dbo.billing UNION ALL SELECT 'beds',COUNT(*) FROM dbo.beds;
GO
SELECT patient_id,COUNT(*) duplicate_count FROM dbo.patients GROUP BY patient_id HAVING COUNT(*)>1;
SELECT doctor_id,COUNT(*) duplicate_count FROM dbo.doctors GROUP BY doctor_id HAVING COUNT(*)>1;
SELECT appointment_id,COUNT(*) duplicate_count FROM dbo.appointments GROUP BY appointment_id HAVING COUNT(*)>1;
SELECT admission_id,COUNT(*) duplicate_count FROM dbo.admissions GROUP BY admission_id HAVING COUNT(*)>1;
SELECT treatment_id,COUNT(*) duplicate_count FROM dbo.treatments GROUP BY treatment_id HAVING COUNT(*)>1;
SELECT bill_id,COUNT(*) duplicate_count FROM dbo.billing GROUP BY bill_id HAVING COUNT(*)>1;
SELECT bed_id,COUNT(*) duplicate_count FROM dbo.beds GROUP BY bed_id HAVING COUNT(*)>1;
GO
SELECT a.* FROM dbo.appointments a LEFT JOIN dbo.patients p ON a.patient_id=p.patient_id WHERE p.patient_id IS NULL;
SELECT a.* FROM dbo.appointments a LEFT JOIN dbo.doctors d ON a.doctor_id=d.doctor_id WHERE d.doctor_id IS NULL;
SELECT a.* FROM dbo.admissions a LEFT JOIN dbo.patients p ON a.patient_id=p.patient_id WHERE p.patient_id IS NULL;
SELECT a.* FROM dbo.admissions a LEFT JOIN dbo.doctors d ON a.doctor_id=d.doctor_id WHERE d.doctor_id IS NULL;
SELECT t.* FROM dbo.treatments t LEFT JOIN dbo.admissions a ON t.admission_id=a.admission_id WHERE a.admission_id IS NULL;
SELECT b.* FROM dbo.billing b LEFT JOIN dbo.admissions a ON b.admission_id=a.admission_id WHERE a.admission_id IS NULL;
GO
SELECT * FROM dbo.patients WHERE age<0 OR age>100;
SELECT * FROM dbo.appointments WHERE wait_time_minutes<0;
SELECT * FROM dbo.admissions WHERE discharge_date<admission_date;
SELECT * FROM dbo.treatments WHERE treatment_cost<=0;
SELECT * FROM dbo.billing WHERE total_amount<=0 OR insurance_amount<0 OR patient_payment<0 OR insurance_amount>total_amount OR patient_payment>total_amount;
GO
SELECT COUNT(*) reconciliation_issues FROM dbo.billing WHERE ABS(total_amount-(insurance_amount+patient_payment))>0.01;
SELECT appointment_status,COUNT(*) total_appointments,SUM(CASE WHEN wait_time_minutes IS NULL THEN 1 ELSE 0 END) missing_wait_time FROM dbo.appointments GROUP BY appointment_status ORDER BY total_appointments DESC;
SELECT * FROM dbo.beds WHERE status='Occupied' AND admission_id IS NULL;
SELECT admission_id,COUNT(*) linked_beds FROM dbo.beds WHERE admission_id IS NOT NULL GROUP BY admission_id HAVING COUNT(*)>1;
