CREATE TABLE keepcoding.ivr_detail AS
SELECT
  cal.ivr_id as calls_ivr_id,
  cal.phone_number as calls_phone_number,
  cal.ivr_result as calls_ivr_result,
  cal.vdn_label as calls_vdn_label,
  cal.start_date as calls_start_date,
  cast(format_date('%Y%m%d',cal.start_date) as int64) as calls_start_date_id,
  cal.end_date as calls_end_date,
  cast(format_date('%Y%m%d',cal.end_date) as int64) as calls_end_date_id,
  cal.total_duration as calls_total_duration,
  cal.customer_segment as calls_customer_segment,
  cal.ivr_language as calls_ivr_language,
  cal.steps_module as calls_steps_module,
  cal.module_aggregation as calls_module_aggregation,
  mol.module_sequece,
  mol.module_name,
  mol.module_duration,
  mol.module_result,
  ste.step_sequence,
  step_name,
  step_result,
  step_description_error,
  document_type,
  document_identification,
  customer_phone,
  billing_account_id
FROM `keepcoding.ivr_calls` cal
LEFT JOIN `keepcoding.ivr_modules` mol
  ON cal.ivr_id = mol.ivr_id
LEFT JOIN `keepcoding.ivr_steps` ste
  ON mol.ivr_id = ste.ivr_id AND mol.module_sequece = ste.module_sequece
;
