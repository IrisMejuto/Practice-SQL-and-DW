SELECT
  calls_ivr_id,
  document_type,
  document_identification
FROM `keepcoding.ivr_detail`
WHERE document_type IN ('DNI', 'NIE', 'CIF', 'PASSPORT')
qualify row_number() over(partition by cast(calls_ivr_id as string) order by document_type desc) = 1
;
