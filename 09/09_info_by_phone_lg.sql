SELECT DISTINCT
  calls_ivr_id,
  CASE
    WHEN step_name = 'CUSTOMERINFOBYPHONE.TX' and step_result = 'OK' THEN 1
    ELSE 0
  END AS  info_by_phone_lg
FROM `keepcoding.ivr_detail`
ORDER BY 2 DESC
;
