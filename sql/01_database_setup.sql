/* Hospital Analytics - 01 Database Setup */
IF DB_ID('HospitalAnalytics') IS NULL CREATE DATABASE HospitalAnalytics;
GO
USE HospitalAnalytics;
GO
IF OBJECT_ID('dbo.beds','U') IS NOT NULL DROP TABLE dbo.beds;
IF OBJECT_ID('dbo.billing','U') IS NOT NULL DROP TABLE dbo.billing;
IF OBJECT_ID('dbo.treatments','U') IS NOT NULL DROP TABLE dbo.treatments;
IF OBJECT_ID('dbo.appointments','U') IS NOT NULL DROP TABLE dbo.appointments;
IF OBJECT_ID('dbo.admissions','U') IS NOT NULL DROP TABLE dbo.admissions;
IF OBJECT_ID('dbo.doctors','U') IS NOT NULL DROP TABLE dbo.doctors;
IF OBJECT_ID('dbo.patients','U') IS NOT NULL DROP TABLE dbo.patients;
GO
CREATE TABLE dbo.patients(patient_id VARCHAR(20) NOT NULL PRIMARY KEY,age INT NOT NULL,gender VARCHAR(20) NOT NULL,city VARCHAR(100) NOT NULL,insurance_type VARCHAR(30) NOT NULL,registration_date DATE NOT NULL,CONSTRAINT CK_patients_age CHECK(age BETWEEN 0 AND 120));
CREATE TABLE dbo.doctors(doctor_id VARCHAR(20) NOT NULL PRIMARY KEY,doctor_name VARCHAR(150) NOT NULL,department VARCHAR(100) NOT NULL,specialization VARCHAR(100) NOT NULL,experience_years INT NOT NULL,CONSTRAINT CK_doctors_exp CHECK(experience_years>=0));
CREATE TABLE dbo.appointments(appointment_id VARCHAR(20) NOT NULL PRIMARY KEY,patient_id VARCHAR(20) NOT NULL,doctor_id VARCHAR(20) NOT NULL,appointment_date DATE NOT NULL,appointment_time TIME NOT NULL,department VARCHAR(100) NOT NULL,appointment_status VARCHAR(30) NOT NULL,wait_time_minutes DECIMAL(10,2) NULL,FOREIGN KEY(patient_id) REFERENCES dbo.patients(patient_id),FOREIGN KEY(doctor_id) REFERENCES dbo.doctors(doctor_id));
CREATE TABLE dbo.admissions(admission_id VARCHAR(20) NOT NULL PRIMARY KEY,patient_id VARCHAR(20) NOT NULL,doctor_id VARCHAR(20) NOT NULL,department VARCHAR(100) NOT NULL,admission_date DATE NOT NULL,discharge_date DATE NOT NULL,admission_type VARCHAR(30) NOT NULL,bed_type VARCHAR(30) NOT NULL,discharge_status VARCHAR(30) NOT NULL,FOREIGN KEY(patient_id) REFERENCES dbo.patients(patient_id),FOREIGN KEY(doctor_id) REFERENCES dbo.doctors(doctor_id),CONSTRAINT CK_admission_dates CHECK(discharge_date>=admission_date));
CREATE TABLE dbo.treatments(treatment_id VARCHAR(20) NOT NULL PRIMARY KEY,admission_id VARCHAR(20) NOT NULL,diagnosis VARCHAR(200) NOT NULL,treatment_type VARCHAR(100) NOT NULL,treatment_date DATE NOT NULL,treatment_cost DECIMAL(12,2) NOT NULL,FOREIGN KEY(admission_id) REFERENCES dbo.admissions(admission_id),CONSTRAINT CK_treatment_cost CHECK(treatment_cost>0));
CREATE TABLE dbo.billing(bill_id VARCHAR(20) NOT NULL PRIMARY KEY,patient_id VARCHAR(20) NOT NULL,admission_id VARCHAR(20) NOT NULL,total_amount DECIMAL(12,2) NOT NULL,insurance_amount DECIMAL(12,2) NOT NULL,patient_payment DECIMAL(12,2) NOT NULL,payment_status VARCHAR(30) NOT NULL,FOREIGN KEY(patient_id) REFERENCES dbo.patients(patient_id),FOREIGN KEY(admission_id) REFERENCES dbo.admissions(admission_id),CONSTRAINT CK_billing_amounts CHECK(total_amount>0 AND insurance_amount>=0 AND patient_payment>=0));
CREATE TABLE dbo.beds(bed_id VARCHAR(20) NOT NULL PRIMARY KEY,department VARCHAR(100) NOT NULL,bed_type VARCHAR(30) NOT NULL,status VARCHAR(30) NOT NULL,admission_id VARCHAR(20) NULL,FOREIGN KEY(admission_id) REFERENCES dbo.admissions(admission_id));
GO
CREATE INDEX IX_appointments_patient ON dbo.appointments(patient_id);
CREATE INDEX IX_appointments_doctor ON dbo.appointments(doctor_id);
CREATE INDEX IX_admissions_patient ON dbo.admissions(patient_id);
CREATE INDEX IX_admissions_doctor ON dbo.admissions(doctor_id);
CREATE INDEX IX_admissions_date ON dbo.admissions(admission_date);
CREATE INDEX IX_treatments_admission ON dbo.treatments(admission_id);
CREATE INDEX IX_billing_admission ON dbo.billing(admission_id);
CREATE INDEX IX_beds_admission ON dbo.beds(admission_id);
GO
/* CSV loading is intentionally left as a template because BULK INSERT needs a local path accessible to SQL Server. */
-- SET DATEFORMAT DMY;
-- BULK INSERT dbo.patients FROM 'C:\YOUR_PATH\data\patients.csv' WITH (FORMAT='CSV',FIRSTROW=2,FIELDQUOTE='"');
-- Repeat for doctors, appointments, admissions, treatments, billing and beds.
