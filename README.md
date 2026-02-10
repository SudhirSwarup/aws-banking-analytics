# AWS Banking Analytics Platform

## Overview
This project demonstrates an end-to-end analytics pipeline on AWS using a serverless architecture. It focuses on real-world analytics engineering concepts such as schema-on-read, Slowly Changing Dimensions (SCD Type 2), and time-aware fact enrichment using Amazon Athena.

The goal of this project is to show **how raw banking data can be ingested, modeled, and queried efficiently for analytics use cases**.

---

## Architecture Overview

Services Used:
- Amazon S3 (Data Lake)
- Amazon Athena (Query Engine)
- AWS CLI
- SQL (Athena / Presto)
- Parquet

High-level Flow:
1. Raw CSV files are ingested into Amazon S3
2. External tables are created in Athena (schema-on-read)
3. Customer dimension is modeled using SCD Type 2
4. Transactions are enriched using effective date joins
5. Curated Parquet datasets are created for analytics

---

## S3 Data Lake Structure

```text
s3://banking-analytics-scd2-sudhir/
├── raw/
│   ├── customers/
│   ├── products/
│   └── transactions/
│
├── curated/
│   ├── dimensions/
│   └── facts/
│
└── athena-results/
```

---

## Phase 1: Data Ingestion (AWS CLI)

Raw CSV files are uploaded from local folders into Amazon S3 using AWS CLI.

Example commands:

- aws s3 sync customers s3://banking-analytics-scd2-sudhir/raw/customers/
- aws s3 sync products  s3://banking-analytics-scd2-sudhir/raw/products/
- aws s3 sync transactions s3://banking-analytics-scd2-sudhir/raw/transactions/

Why AWS CLI?
- Simple and fast for manual ingestion
- Suitable for POCs and portfolio projects
- No additional services required

---

## Phase 2: External Tables (Schema-on-Read)

External tables are created in Athena directly on top of raw CSV files.

Key characteristics:
- No data movement
- Schema applied at query time
- Very cost-efficient

Tables created:
- customers_raw
- products_raw
- transactions_raw

---

## Phase 3: SCD Type 2 & Fact Enrichment

### Customer Dimension (SCD Type 2)

The customer dimension maintains historical versions of customer data using:
- effective_start_date
- effective_end_date
- is_current flag

This allows correct historical analysis when customer attributes change.

---

### Transaction Enrichment

Transactions are enriched with the **correct historical customer record** using a time-aware join.

Core logic:

transaction_date BETWEEN effective_start_date AND effective_end_date

The result is an analytics-ready fact table stored in Parquet format.

---

## Athena Constraints (Real-World Reality)

Important limitations handled in this project:
- Athena does NOT support UPDATE or DELETE on non-transactional tables
- SCD logic is implemented using INSERT and CTAS patterns
- Data quality must be handled carefully at ingestion time

These constraints are documented intentionally to reflect real-world engineering decisions.

---

## SQL Artifacts

All SQL used in this project is version-controlled and available in the `/sql` directory.

The scripts are organized in execution order:
- Database setup
- External table creation
- SCD Type 2 dimension logic
- Fact table enrichment
- Validation & quality checks

## Screenshots & Visual Evidence

This section provides visual proof of each stage of the AWS analytics pipeline.
All screenshots are captured from actual AWS services during execution of the project.

Screenshots are stored under the `screenshots/` directory and are ordered to follow the pipeline flow from ingestion to analytics.

---

### 1. S3 Data Lake – Raw Layer

**01_s3_raw.png**  
Shows the overall raw data lake structure in Amazon S3.

**02_s3_raw_customers.png**  
Displays customer CSV files successfully ingested into the raw layer.

These screenshots validate:
- Correct S3 bucket and folder structure
- Successful ingestion of raw data

---

### 2. S3 Data Lake – Curated Layer

**03_s3_curated.png**  
Shows curated datasets stored in Parquet format after transformation.

This confirms:
- Separation of raw and curated layers
- Analytics-optimized storage format

---

### 3. Data Ingestion via AWS CLI

**04_aws_cli_upload.png**  
Shows AWS CLI commands used to upload raw CSV files into Amazon S3.

This demonstrates:
- Manual ingestion using AWS CLI
- Reproducible ingestion process

---

### 4. Athena External Tables (Schema-on-Read)

**05_athena_customers_raw.png**  
External table created on top of raw customer data.

**06_athena_transactions_raw.png**  
External table created on top of raw transaction data.

These screenshots show:
- Schema-on-read implementation
- Direct querying of CSV data in S3 using Athena

---

### 5. SCD Type 2 Customer Dimension

**07_athena_scd2_dimension.png**  
Displays the customer dimension with historical records.

This validates:
- Proper SCD Type 2 implementation
- Historical tracking using effective start and end dates

---

### 6. Enriched Fact Table

**08_athena_fact_enriched.png**  
Shows the analytics-ready fact table enriched with customer attributes.

This confirms:
- Time-aware joins
- Correct alignment of transactions with historical customer data

---

### 7. Analytics & Business Queries

**09_analytics_city.png**  
Daily transaction volume and total amount analysis.

**10_analytics_segment.png**  
Aggregated analytics by customer segment.

**11_analytics_risk_band.png**  
Transaction distribution across customer risk bands.

These screenshots demonstrate:
- Business-ready analytics
- Querying directly on curated fact tables
- Support for reporting and insights

---

## Future Enhancements

- Python (boto3) based ingestion pipeline
- Data quality validation layer
- Partitioning by transaction_date
- AWS Glue Data Catalog integration
- BI dashboards using QuickSight or Power BI

---

## Author

Sudhir Swarup  
AWS Analytics & Data Engineering Portfolio Project
