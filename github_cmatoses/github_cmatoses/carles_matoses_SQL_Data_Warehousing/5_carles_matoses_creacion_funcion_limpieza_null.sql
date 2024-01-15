CREATE OR REPLACE FUNCTION keepcoding.clean_integer(value STRING) 
RETURNS INT64 AS
(( SELECT 
      CASE
        WHEN value IS NULL THEN -999999
      ELSE
        SAFE_CAST(value AS INT64)
      END
))