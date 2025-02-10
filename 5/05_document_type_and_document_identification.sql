WITH document_id_type AS (
  SELECT 
    CAST(calls_ivr_id AS STRING) as calls_ivr_id,
    CASE 
      WHEN document_type IN ('DNI', 'NIE', 'CIF', 'PASSPORT') THEN document_type
      ELSE 'UNKNOWN'
    END as document_type,
    document_identification,
    ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id as STRING) ORDER BY 
        CASE 
          WHEN document_type IN ('DNI', 'NIE', 'CIF', 'PASSPORT') then 1
          ELSE 2 
        END,
        document_identification
    ) AS rn
  FROM `keepcoding.ivr_detail`
)
SELECT 
  calls_ivr_id,
  document_type,
  document_identification
FROM document_id_type
where rn = 1;
