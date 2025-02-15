SELECT 
  calls_ivr_id,
  billing_account_id
FROM `keepcoding.ivr_detail`
WHERE billing_account_id != 'UNKNOWN'
AND billing_account_id IS NOT NULL
qualify row_number() over(partition by CAST(calls_ivr_id AS STRING) order by billing_account_id desc) = 1
;
