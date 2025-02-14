SELECT
  cast(calls_ivr_id as string) as calls_ivr_id,
  document_type,
  document_identification
FROM `keepcoding.ivr_detail`
WHERE document_type IN ('DNI', 'NIE', 'CIF', 'PASSPORT')
qualify row_number() over(partition by calls_ivr_id order by document_type desc) = 1
;
