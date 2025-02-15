SELECT
  calls_ivr_id,
  calls_phone_number,
  calls_start_date,
  
  CASE
    WHEN DATETIME_DIFF(calls_start_date,LAG(calls_start_date) over(partition by calls_phone_number order by calls_start_date),hour) <=24 THEN 1
    ELSE 0
  END AS repeated_phone_24H,

  CASE
    WHEN DATETIME_DIFF(LEAD(calls_start_date) OVER(partition by calls_phone_number order by calls_start_date), calls_start_date, hour) <=24 THEN 1
    ELSE 0
  END AS cause_recall_phone_24H
FROM `keepcoding.ivr_detail`
ORDER BY 3 ASC
;
