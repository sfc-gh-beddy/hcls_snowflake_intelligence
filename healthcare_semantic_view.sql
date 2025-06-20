
USE DATABASE SNOWFLAKE_INTELLIGENCE;
USE SCHEMA SNOWFLAKE_INTELLIGENCE.CONFIG;
USE ROLE SNOWFLAKE_INTELLIGENCE_ADMIN_RL;
USE WAREHOUSE SNOWFLAKE_INTELLIGENCE_WH;
-- -----------------------------------------------------------------------------
-- CREATE SEMANTIC VIEW: Healthcare Intelligence Demo
-- -----------------------------------------------------------------------------
-- This semantic view combines healthcare data from multiple tables for unified analytics.
-- It includes dimensions for appointments, claims, patients, providers, and prescriptions,
-- along with metrics for counts and financial totals.

CREATE OR REPLACE SEMANTIC VIEW healthcare_demo_semantic_vw

TABLES (
  appointments AS HEALTHCARE_DEMO_DB.PUBLIC.APPOINTMENTS PRIMARY KEY (APPOINTMENT_ID),
  claims AS HEALTHCARE_DEMO_DB.PUBLIC.CLAIMS PRIMARY KEY (CLAIM_ID),
  patients AS HEALTHCARE_DEMO_DB.PUBLIC.PATIENTS PRIMARY KEY (PATIENT_ID),
  providers AS HEALTHCARE_DEMO_DB.PUBLIC.PROVIDERS PRIMARY KEY (PROVIDER_ID),
  prescriptions AS HEALTHCARE_DEMO_DB.PUBLIC.PRESCRIPTIONS PRIMARY KEY (PRESCRIPTION_ID)
)

RELATIONSHIPS (
  claims (PATIENT_ID) REFERENCES patients (PATIENT_ID),
  claims (PROVIDER_ID) REFERENCES providers (PROVIDER_ID),
  appointments (PATIENT_ID) REFERENCES patients (PATIENT_ID),
  appointments (PROVIDER_ID) REFERENCES providers (PROVIDER_ID),
  appointments (APPOINTMENT_ID) REFERENCES claims (CLAIM_ID),
  prescriptions (PATIENT_ID) REFERENCES patients (PATIENT_ID),
  prescriptions (PROVIDER_ID) REFERENCES providers (PROVIDER_ID),
  prescriptions (APPOINTMENT_ID) REFERENCES appointments (APPOINTMENT_ID)
)

DIMENSIONS (

  -- Appointments
  appointments.reason_for_visit AS appointments.REASON_FOR_VISIT,
  appointments.status AS appointments.STATUS,
  appointments.notes AS appointments.NOTES,
  appointments.patient_id AS appointments.PATIENT_ID,
  appointments.provider_id AS appointments.PROVIDER_ID,
  appointments.appointment_date AS appointments.APPOINTMENT_DATE,

  -- Claims
  claims.diagnosis_code AS claims.DIAGNOSIS_CODE,
  claims.claim_status AS claims.CLAIM_STATUS,
  claims.service_description AS claims.SERVICE_DESCRIPTION,
  claims.reason_for_visit AS claims.REASON_FOR_VISIT,
  claims.patient_id AS claims.PATIENT_ID,
  claims.provider_id AS claims.PROVIDER_ID,
  claims.visit_date AS claims.VISIT_DATE,

  -- Patients
  patients.first_name AS patients.FIRST_NAME,
  patients.last_name AS patients.LAST_NAME,
  patients.gender AS patients.GENDER,
  patients.member_id AS patients.MEMBER_ID,
  patients.insurance_plan AS patients.INSURANCE_PLAN,
  patients.email AS patients.EMAIL,
  patients.phone AS patients.PHONE,
  patients.address AS patients.ADDRESS,
  patients.dob AS patients.DOB,

  -- Providers
  providers.name AS providers.NAME,
  providers.specialty AS providers.SPECIALTY,
  providers.location AS providers.LOCATION,
  providers.phone AS providers.PHONE,
  providers.email AS providers.EMAIL,
  providers.npi AS providers.NPI,

  -- Prescriptions
  prescriptions.medication AS prescriptions.MEDICATION,
  prescriptions.dosage AS prescriptions.DOSAGE,
  prescriptions.frequency AS prescriptions.FREQUENCY,
  prescriptions.duration AS prescriptions.DURATION,
  prescriptions.patient_id AS prescriptions.PATIENT_ID,
  prescriptions.provider_id AS prescriptions.PROVIDER_ID,
  prescriptions.appointment_id AS prescriptions.APPOINTMENT_ID

)

METRICS (
  appointments.appointment_count AS COUNT(DISTINCT appointments.APPOINTMENT_ID),
  claims.claim_count AS COUNT(DISTINCT claims.CLAIM_ID),
  claims.total_amount_billed AS SUM(claims.AMOUNT_BILLED),
  claims.total_amount_paid AS SUM(claims.AMOUNT_PAID),
  claims.total_patient_responsible AS SUM(claims.AMOUNT_PATIENT_RESPONSIBLE),
  prescriptions.prescription_count AS COUNT(DISTINCT prescriptions.PRESCRIPTION_ID)
)

COMMENT = ' semantic view combining appointments, claims, patients, providers, prescriptions for unified healthcare analytics.';