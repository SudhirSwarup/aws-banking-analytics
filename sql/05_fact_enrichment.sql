CREATE TABLE fact_transactions_enriched
WITH (
  format = 'PARQUET',
  external_location = 's3://banking-analytics-scd2-sudhir/curated/facts/'
) AS
SELECT
  t.transaction_id,
  t.transaction_date,
  t.customer_id,
  d.customer_sk,
  d.city,
  d.segment,
  d.risk_band,
  t.product_id,
  t.amount,
  t.txn_type,
  t.channel
FROM transactions_raw t
JOIN customers_dim_scd2_v2 d
  ON t.customer_id = d.customer_id
 AND t.transaction_date
     BETWEEN d.effective_start_date AND d.effective_end_date;
     BETWEEN d.effective_start_date AND d.effective_end_date;