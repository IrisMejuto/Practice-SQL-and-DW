SELECT
  calls_ivr_id,
  CASE
    WHEN step_name = 'CUSTOMERINFOBYDNI.TX'and step_result = 'OK' THEN 1
    ELSE 0
  END AS  info_by_dni_lg
FROM `keepcoding.ivr_detail`
ORDER BY 2 DESC
;
