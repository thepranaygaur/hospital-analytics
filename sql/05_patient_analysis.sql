/* Hospital Analytics - 05 Patient Analysis */
USE HospitalAnalytics;
GO
SELECT gender,COUNT(*) total_patients,ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(),2) patient_share_pct FROM dbo.patients GROUP BY gender ORDER BY total_patients DESC;
SELECT insurance_type,COUNT(*) total_patients,ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(),2) patient_share_pct FROM dbo.patients GROUP BY insurance_type ORDER BY total_patients DESC;
SELECT TOP 10 city,COUNT(*) total_patients FROM dbo.patients GROUP BY city ORDER BY total_patients DESC;
SELECT appointment_status,COUNT(*) total_appointments,ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(),2) appointment_share_pct FROM dbo.appointments GROUP BY appointment_status ORDER BY total_appointments DESC;
SELECT COUNT(*) completed_appointments,ROUND(AVG(wait_time_minutes),2) avg_wait_time_minutes,MIN(wait_time_minutes) min_wait_time_minutes,MAX(wait_time_minutes) max_wait_time_minutes FROM dbo.appointments WHERE appointment_status='Completed';
SELECT TOP 10 d.doctor_id,d.doctor_name,d.department,COUNT(a.appointment_id) total_appointments,ROUND(AVG(a.wait_time_minutes),2) avg_wait_time_minutes FROM dbo.doctors d JOIN dbo.appointments a ON d.doctor_id=a.doctor_id GROUP BY d.doctor_id,d.doctor_name,d.department ORDER BY total_appointments DESC;
SELECT TOP 20 p.patient_id,p.age,p.gender,COUNT(a.admission_id) total_admissions FROM dbo.patients p JOIN dbo.admissions a ON p.patient_id=a.patient_id GROUP BY p.patient_id,p.age,p.gender ORDER BY total_admissions DESC;
SELECT payment_status,COUNT(*) total_bills,SUM(total_amount) billed_amount,SUM(patient_payment) patient_paid_amount,SUM(insurance_amount) insurance_paid_amount FROM dbo.billing GROUP BY payment_status ORDER BY billed_amount DESC;
SELECT ROUND(SUM(insurance_amount),2) total_insurance_amount,ROUND(SUM(patient_payment),2) total_patient_payment,ROUND(100.0*SUM(insurance_amount)/SUM(total_amount),2) insurance_share_pct,ROUND(100.0*SUM(patient_payment)/SUM(total_amount),2) patient_payment_share_pct FROM dbo.billing;
