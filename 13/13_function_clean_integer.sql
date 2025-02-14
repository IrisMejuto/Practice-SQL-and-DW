CREATE OR REPLACE FUNCTION keepcoding.clean_integer(p_int INT) RETURNS INT AS 
(( SELECT COALESCE(p_int, -999999) ))
;
