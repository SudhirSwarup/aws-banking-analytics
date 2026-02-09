# AWS Banking Analytics Platform

## Overview
This project demonstrates an end-to-end analytics pipeline on AWS using
a serverless architecture. It focuses on real-world analytics engineering
concepts such as schema-on-read, Slowly Changing Dimensions (SCD Type 2),
and time-aware fact enrichment using Amazon Athena.

The goal of this project is to show **how raw banking data can be
ingested, modeled, and queried efficiently for analytics use cases**.

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

s3://banking-analytics-scd2-sudhir/
|
|-- raw/
|   |-- customers/
|   |-- products/
|   |-- transactions/
|
|-- curated/
|   |-- dimensions/
|   |-- facts/
|
|-- athena-results/

---

## Phase 1: Data Ingestion (AWS CLI)

Raw CSV files are uploaded from local folders into Amazon S3 using AWS CLI.

Example commands:

aws s3 sync customers s3://banking-analytics-scd2-sudhir/raw/customers/
aws s3 sync products  s3://banking-analytics-scd2-sudhir/raw/products/
aws s3 sync transactions s3://banking-analytics-scd2-sudhir/raw/transactions/

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

The customer dimension maintains historical versions of customer data
using:
- effective_start_date
- effective_end_date
- is_current flag

This allows correct historical analysis when customer attributes change.

---

### Transaction Enrichment

Transactions are enriched with the **correct historical customer record**
using a time-aware join.

Core logic:

transaction_date BETWEEN
effective_start_date AND effective_end_date

The result is an analytics-ready fact table stored in Parquet format.

---

## Athena Constraints (Real-World Reality)

Important limitations handled in this project:
- Athena does NOT support UPDATE or DELETE on non-transactional tables
- SCD logic is implemented using INSERT and CTAS patterns
- Data quality must be handled carefully at ingestion time

These constraints are documented intentionally to reflect real-world
engineering decisions.

---

## Cost Considerations

- Amazon S3 storage cost is minimal for small datasets
- Athena charges per TB scanned
- Using Parquet significantly reduces query cost
- Entire pipeline runs comfortably within AWS Free Tier for demos

---

## Proof of Work

This project demonstrates:
- Real AWS services (not mock data)
- Real SQL executed in Athena
- Real SCD Type 2 modeling
- Real ingestion into Amazon S3

This can be demonstrated live during interviews.

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
