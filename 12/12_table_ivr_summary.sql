CREATE TABLE keepcoding.ivr_summary AS
WITH 
vdn_aggregation AS(
  SELECT
  calls_ivr_id,
  CASE
    WHEN calls_vdn_label LIKE 'ATC%' THEN 'FRONT'
    WHEN calls_vdn_label LIKE 'TECH%' THEN 'TECH' 
    WHEN calls_vdn_label LIKE 'ABSORPTION' THEN 'ABSORPTION'
    ELSE 'RESTO'
  END AS vdn_aggregation
FROM `keepcoding.ivr_detail` 
),

document_info AS(
  SELECT
  calls_ivr_id,
  document_type,
  document_identification
FROM `keepcoding.ivr_detail`
WHERE document_type IN ('DNI', 'NIE', 'CIF', 'PASSPORT')
qualify row_number() over(partition by cast(calls_ivr_id as string) order by document_type desc) = 1
),

customer_phone AS(
  SELECT
  calls_ivr_id,
  customer_phone
FROM `keepcoding.ivr_detail`
WHERE customer_phone != 'UNKNOWN'
qualify row_number() over(partition by cast(calls_ivr_id as string) order by customer_phone desc) = 1
),

billing_account_id AS(
  SELECT 
  calls_ivr_id,
  billing_account_id
FROM `keepcoding.ivr_detail`
WHERE billing_account_id != 'UNKNOWN'
AND billing_account_id IS NOT NULL
qualify row_number() over(partition by cast(calls_ivr_id as string) order by billing_account_id desc) = 1
),

masiva_lg AS(
  SELECT DISTINCT
  calls_ivr_id,
  CASE
    WHEN module_name ='AVERIA_MASIVA' THEN 1
    ELSE 0
  END AS masiva_lg
FROM `keepcoding.ivr_detail`
),

info_by_phone_lg AS(
  SELECT DISTINCT
  calls_ivr_id,
  CASE
    WHEN step_name = 'CUSTOMERINFOBYPHONE.TX' and step_result = 'OK' THEN 1
    ELSE 0
  END AS  info_by_phone_lg
FROM `keepcoding.ivr_detail`
),

info_by_dni_lg AS(
  SELECT DISTINCT
  calls_ivr_id,
  CASE
    WHEN step_name = 'CUSTOMERINFOBYDNI.TX'and step_result = 'OK' THEN 1
    ELSE 0
  END AS  info_by_dni_lg
FROM `keepcoding.ivr_detail`
),

repeated_and_cause_recall_phone_24H AS(
  SELECT
  calls_ivr_id,
  calls_phone_number,
  calls_start_date,
  CASE
    WHEN DATETIME_DIFF(calls_start_date,LAG(calls_start_date) over(partition by cast(calls_phone_number as string) order by calls_start_date),hour) <=24 THEN 1
    ELSE 0
  END AS repeated_phone_24H,
  CASE
    WHEN DATETIME_DIFF(LEAD(calls_start_date) OVER(partition by cast(calls_phone_number as string) order by calls_start_date), calls_start_date, hour) <=24 THEN 1
    ELSE 0
  END AS cause_recall_phone_24H
FROM `keepcoding.ivr_detail`
)

SELECT
  det.calls_ivr_id as ivr_id,
  det.calls_phone_number as phone_number, 
  det.calls_ivr_result as  ivr_result, 
  vdn.vdn_aggregation as vdn_aggregation, 
  det.calls_start_date as start_date, 
  det.calls_end_date as end_date,
  det.calls_total_duration as total_duration, 
  det.calls_customer_segment as customer_segment,
  det.calls_ivr_language as ivr_language,
  det.calls_steps_module as steps_module,
  det.calls_module_aggregation as module_aggregation,
  doc.document_type as document_type,
  doc.document_identification as document_identification,
  cus.customer_phone as customer_phone,
  bil.billing_account_id as billing_account_id,
  mas.masiva_lg as masiva_lg,
  pho_lg.info_by_phone_lg as info_by_phone_lg,
  dni_lg.info_by_dni_lg as info_by_dni_lg,
  re_ca.repeated_phone_24H as repeated_phone_24H,
  re_ca.cause_recall_phone_24H as cause_recall_phone_24H
FROM `keepcoding.ivr_detail` det
LEFT JOIN vdn_aggregation vdn 
  ON det.calls_ivr_id = vdn.calls_ivr_id
LEFT JOIN document_info doc 
  ON det.calls_ivr_id = doc.calls_ivr_id
LEFT JOIN customer_phone cus 
  ON det.calls_ivr_id = cus.calls_ivr_id
LEFT JOIN billing_account_id bil 
  ON det.calls_ivr_id = bil.calls_ivr_id
LEFT JOIN masiva_lg mas 
  ON det.calls_ivr_id = mas.calls_ivr_id
LEFT JOIN info_by_phone_lg pho_lg 
  ON det.calls_ivr_id = pho_lg.calls_ivr_id
LEFT JOIN info_by_dni_lg dni_lg 
  ON det.calls_ivr_id = dni_lg.calls_ivr_id
LEFT JOIN repeated_and_cause_recall_phone_24H re_ca 
  ON det.calls_ivr_id = re_ca.calls_ivr_id
