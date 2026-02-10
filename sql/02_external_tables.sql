CREATE EXTERNAL TABLE IF NOT EXISTS customers_raw (
  customer_id string,
  customer_name string,
  city string,
  segment string,
  risk_band string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = "\"",
  "skip.header.line.count" = "1"
)
LOCATION 's3://banking-analytics-scd2-sudhir/raw/customers/';



CREATE EXTERNAL TABLE IF NOT EXISTS products_raw (
  product_id string,
  product_name string,
  product_type string,
  interest_rate double,
  annual_fee int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = "\"",
  "skip.header.line.count" = "1"
)
LOCATION 's3://banking-analytics-scd2-sudhir/raw/products/';



CREATE EXTERNAL TABLE transactions_raw (
  transaction_id string,
  transaction_date string,
  customer_id string,
  product_id string,
  amount string,
  txn_type string,
  channel string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "skip.header.line.count" = "1"
)
LOCATION 's3://banking-analytics-scd2-sudhir/raw/transactions/';


