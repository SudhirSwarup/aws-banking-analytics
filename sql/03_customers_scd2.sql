-- Initial load
CREATE TABLE customers_dim_scd2_v2
WITH (
  format = 'PARQUET',
  external_location = 's3://banking-analytics-scd2-sudhir/curated/dimensions/customers/'
) AS
SELECT
  customer_id,
  city,
  segment,
  risk_band,
  current_date AS effective_start_date,
  DATE '9999-12-31' AS effective_end_date,
  'Y' AS is_current
FROM customers_raw;