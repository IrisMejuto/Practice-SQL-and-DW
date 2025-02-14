SELECT
  cast(calls_ivr_id as string) as calls_ivr_id,
  customer_phone
FROM `keepcoding.ivr_detail`
WHERE customer_phone != 'UNKNOWN'
qualify row_number() over(partition by calls_ivr_id order by customer_phone desc) = 1
;
