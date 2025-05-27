select * from hospital_readmissions;

-- AVERAGE HOSPITAL STAY DURATION FOR DIFFERENT AGE-GROUPS 
SELECT
    age,
    ROUND(AVG(time_in_hospital)) AS avg_stay_days_rounded,
    COUNT(*) AS patient_count
FROM hospital_readmissions
GROUP BY age
ORDER BY avg_stay_days_rounded DESC;

-- READMISSION RATE BY AGE-GROUP
SELECT
    age,
    ROUND(AVG(
            CASE 
                WHEN REPLACE(TRIM(readmitted), '\r', '') = 'yes' THEN 1 
                ELSE 0 
            END
        ) * 100, 2
    ) AS readmission_rate_percent,
    COUNT(*) AS patient_count
FROM hospital_readmissions
GROUP BY age
ORDER BY readmission_rate_percent DESC;

-- READMISSION RATE BY MEDICAL SPECIALITY
SELECT
    medical_specialty,
    ROUND(100 * SUM(CASE WHEN REPLACE(TRIM(readmitted), '\r', '') = 'yes' THEN 1  ELSE 0 END) / COUNT(*), 2) AS readmission_rate_percent,
    COUNT(*) AS total_patients
FROM hospital_readmissions
-- WHERE medical_specialty IS NOT NULL AND medical_specialty != 'Missing'
GROUP BY medical_specialty
ORDER BY readmission_rate_percent DESC
LIMIT 10;

-- AVERAGE NUMBER OF MEDICATIONS ADMINISTERED PER PATIENT
SELECT
     COUNT(*) AS total_patients,
    ROUND(AVG(n_medications), 2) AS avg_medications
FROM hospital_readmissions;

-- DISTRIBUTION OF PRIMARY DIAGNOSIS CATEGORIES (diag_1) BY PATIENT COUNT
SELECT
    diag_1 AS primary_diagnosis,
    COUNT(*) AS patient_count
FROM hospital_readmissions
GROUP BY diag_1
ORDER BY patient_count DESC;

-- AVERAGE NUMBER OF PROCEDURES BY MEDICAL SPECIALITY
SELECT
    medical_specialty,
    ROUND(AVG(n_procedures), 2) AS avg_procedures,
    COUNT(*) AS total_patients
FROM hospital_readmissions
GROUP BY medical_specialty
ORDER BY avg_procedures DESC
LIMIT 10;

-- AVERAGE NUMBER OF EMERGENCY VISITS IN PAST YEAR BY AGE GROUP
SELECT 
    age,
    ROUND(AVG(n_emergency), 2) AS avg_emergency_visits,
    COUNT(*) AS patient_count
FROM 
    hospital_readmissions
GROUP BY 
    age
ORDER BY 
    avg_emergency_visits DESC;

-- EFFECT OF DIABETES MEDICATION CHANGE ON READMISSION RATES
SELECT 
    changes,
    ROUND(SUM(CASE WHEN REPLACE(TRIM(readmitted), '\r', '') = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent,
    COUNT(*) AS total_patients
FROM hospital_readmissions
WHERE diabetes_med = 'yes'
GROUP BY changes;

-- A1C TEST RESULT VS READMISSION RATE
SELECT 
    A1Ctest,
    ROUND(100 * SUM(CASE WHEN REPLACE(TRIM(readmitted), '\r', '') = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS readmission_rate_percent,
    COUNT(*) AS patient_count
FROM hospital_readmissions
GROUP BY A1Ctest
ORDER BY readmission_rate_percent DESC;

-- AVERAGE NUMBER OF OUTPATIENT VISITS BY READMISSION STATUS
SELECT
    readmitted,
    ROUND(AVG(n_outpatient), 2) AS avg_outpatient_visits,
    COUNT(*) AS patient_count
FROM hospital_readmissions
GROUP BY readmitted;






























