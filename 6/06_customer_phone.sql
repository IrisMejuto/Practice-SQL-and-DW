WITH customer_phone_update AS (
  SELECT 
    CAST(calls_ivr_id AS STRING) as calls_ivr_id,
    customer_phone,
    row_number()over(
    partition by cast (calls_ivr_id as string) order by 
        case 
          when customer_phone != 'UNKNOWN' then 1
          else 2 
        end,
        customer_phone
    ) as rn
  FROM `keepcoding.ivr_detail`
)
SELECT 
  calls_ivr_id,
  customer_phone
FROM customer_phone_update
WHERE rn = 1 AND customer_phone != 'UNKNOWN'
;
