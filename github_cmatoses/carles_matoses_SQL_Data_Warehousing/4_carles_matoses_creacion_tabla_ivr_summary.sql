CREATE OR REPLACE TABLE `keepcoding.ivr_summary` AS
WITH document_type_identification AS (
    SELECT
      calls_ivr_id,
      document_type,
      document_identification
    FROM
      `keepcoding.ivr_detail`
    WHERE
      document_type <> 'UNKNOWN'
    QUALIFY ROW_NUMBER() OVER (PARTITION BY calls_ivr_id ORDER BY modules_module_sequece ASC) = 1
),
cust_phone AS(
    SELECT
      calls_ivr_id,
      customer_phone,
    FROM
      `keepcoding.ivr_detail`
    WHERE
      customer_phone <> 'UNKNOWN'
    QUALIFY ROW_NUMBER() OVER (PARTITION BY calls_ivr_id ORDER BY modules_module_sequece ASC) = 1
),
bill_account AS(
    SELECT
      calls_ivr_id,
      billing_account_id,
    FROM
      `keepcoding.ivr_detail`
    WHERE
      billing_account_id <> 'UNKNOWN'
    QUALIFY ROW_NUMBER() OVER (PARTITION BY calls_ivr_id ORDER BY modules_module_sequece ASC) = 1
),
masi_lg AS(
    SELECT
      calls_ivr_id,
        SUM(CASE
          WHEN modules_module_name = 'AVERIA_MASIVA' THEN 1
          ELSE 0
      END) AS masiva_lg
    FROM 
      `keepcoding.ivr_detail`
    WHERE calls_ivr_id = '1670787860.2680669'
    GROUP BY calls_ivr_id
),
info_phone_lg AS (
    SELECT
      calls_ivr_id,
      SUM(CASE
        WHEN step_name = 'CUSTOMERINFOBYPHONE.TX' AND step_description_error = 'UNKNOWN' THEN 1
        ELSE 0
      END) AS info_by_phone_lg
    FROM 
      `keepcoding.ivr_detail`
    GROUP BY calls_ivr_id
),
info_dni_lg AS (
    SELECT
      calls_ivr_id,
      SUM(CASE
        WHEN step_name = 'CUSTOMERINFOBYDNI.TX' AND step_description_error = 'UNKNOWN' THEN 1
        ELSE 0
      END) AS info_by_dni_lg
    FROM 
      `keepcoding.ivr_detail`
    GROUP BY calls_ivr_id 
),
rep_phone_24 AS (
    SELECT
      CAST(ivr_id AS STRING) AS calls_ivr_id
      ,IF(DATETIME_DIFF(LAG(start_date) OVER(PARTITION BY phone_number ORDER BY start_date ),
      start_date, HOUR) <= -24, 1 , 0) AS repeated_phone_24H
    FROM
      `keepcoding.ivr_calls`
),
cause_phone_24 AS (
    SELECT
      CAST(ivr_id AS STRING) AS calls_ivr_id
      ,IF(DATETIME_DIFF(LEAD(start_date) OVER(PARTITION BY phone_number ORDER BY start_date),
      start_date, HOUR) >= 24, 1 , 0) AS cause_recall_phone_24H
    FROM
      `keepcoding.ivr_calls`
)      
SELECT DISTINCT
    de.calls_ivr_id AS ivr_id
  , de.calls_phone_number AS  phone_number
  , de.calls_ivr_result AS  ivr_result
  , CASE
        WHEN LEFT(de.calls_vdn_label, 3) = 'ATC' THEN 'FRONT'
        WHEN LEFT(de.calls_vdn_label, 4) = 'TECH' THEN 'TECH'
        WHEN de.calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
        ELSE 'RESTO'
    END AS vdn_aggregation
  , de.calls_start_date AS start_date
  , de.calls_end_date AS end_date
  , de.calls_total_duration AS total_duration
  , de.calls_customer_segment AS customer_segment
  , de.calls_ivr_language AS ivr_language
  , de.calls_steps_module AS steps_module
  , de.calls_module_aggregation AS module_aggregation
  , dty.document_type
  , dty.document_identification
  , cp.customer_phone
  , ba.billing_account_id
  , IF(ml.masiva_lg >= 1, 1, 0) AS masiva_lg
  , IF(ipl.info_by_phone_lg >= 1, 1, 0) AS info_by_phone_lg
  , IF(idl.info_by_dni_lg >= 1, 1, 0) AS info_by_dni_lg
  , rp2.repeated_phone_24H
  , cp2.cause_recall_phone_24H  
FROM `keepcoding.ivr_detail` AS de
LEFT JOIN document_type_identification AS dty
  ON dty.calls_ivr_id = de.calls_ivr_id
LEFT JOIN cust_phone AS cp
  ON cp.calls_ivr_id = de.calls_ivr_id  
LEFT JOIN bill_account AS ba
  ON ba.calls_ivr_id = de.calls_ivr_id  
LEFT JOIN masi_lg AS ml
  ON ml.calls_ivr_id = de.calls_ivr_id
LEFT JOIN info_phone_lg AS ipl
  ON ipl.calls_ivr_id = de.calls_ivr_id
LEFT JOIN info_dni_lg AS idl
  ON idl.calls_ivr_id = de.calls_ivr_id
LEFT JOIN rep_phone_24 AS rp2
  ON rp2.calls_ivr_id = de.calls_ivr_id
LEFT JOIN cause_phone_24 AS cp2
  ON cp2.calls_ivr_id = de.calls_ivr_id