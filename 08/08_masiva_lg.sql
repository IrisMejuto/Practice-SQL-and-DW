SELECT
  calls_ivr_id,
  CASE
    WHEN module_name ='AVERIA_MASIVA' THEN 1
    ELSE 0
  END AS masiva_lg
FROM `keepcoding.ivr_detail`
ORDER BY 2 DESC
;
