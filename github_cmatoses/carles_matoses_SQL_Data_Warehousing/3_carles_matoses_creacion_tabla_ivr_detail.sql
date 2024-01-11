CREATE OR REPLACE TABLE `keepcoding.ivr_detail` AS
SELECT
    CAST(ca.ivr_id AS STRING)   AS calls_ivr_id
  , ca.phone_number             AS calls_phone_number
  , ca.ivr_result               AS calls_ivr_result  
  , ca.vdn_label                AS calls_vdn_label
  , ca.start_date               AS calls_start_date
  , FORMAT_DATE('%Y%m%d', ca.start_date)            AS calls_start_date_id 
  , ca.end_date                 AS calls_end_date
  , FORMAT_DATE('%Y%m%d', ca.end_date)              AS calls_end_date_id 
  , ca.total_duration           AS calls_total_duration
  , ca.customer_segment         AS calls_customer_segment
  , ca.ivr_language             AS calls_ivr_language 
  , ca.steps_module             AS calls_steps_module 
  , ca.module_aggregation       AS calls_module_aggregation 
  , mo.module_sequece           AS modules_module_sequece 
  , mo.module_name              AS modules_module_name 
  , mo.module_duration          AS modules_module_duration 
  , mo.module_result            AS modules_module_result 
  , st.step_sequence            AS step_sequence 
  , st.step_name                AS step_name 
  , st.step_result              AS step_result 
  , st.step_description_error   AS step_description_error 
  , st.document_type            AS document_type 
  , st.document_identification  AS document_identification 
  , st.customer_phone           AS customer_phone 
  , st.billing_account_id       AS billing_account_id    
FROM `keepcoding.ivr_calls`           AS ca
LEFT JOIN `keepcoding.ivr_modules`    AS mo
    ON ca.ivr_id = mo.ivr_id
LEFT JOIN `keepcoding.ivr_steps`      AS st
    ON mo.ivr_id = st.ivr_id
    AND mo.module_sequece = st.module_sequece