WITH document_id_type AS (
  SELECT 
    CAST(calls_ivr_id AS STRING) as calls_ivr_id,
    CASE 
      WHEN document_type IN ('DNI', 'NIE', 'CIF', 'PASSPORT') THEN document_type
      ELSE 'UNKNOWN'
    END as document_type,
    document_identification,
    ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY 
        CASE 
          WHEN document_type IN ('DNI', 'NIE', 'CIF', 'PASSPORT') THEN 1
          ELSE 2 
        END,
        document_identification
    ) as rn
  FROM `keepcoding.ivr_detail`
)
SELECT 
  calls_ivr_id,
  document_type,
  document_identification
FROM document_id_type
WHERE rn = 1;
