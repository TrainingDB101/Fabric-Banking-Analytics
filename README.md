<h1 align="center">Microsoft Fabric Banking Analytics Project</h1>

<h2 align="center">End-to-End Banking Analytics Solution using Microsoft Fabric</h2>

---

# Overview

The **Microsoft Fabric Banking Analytics Project** demonstrates the complete lifecycle of building a modern enterprise analytics solution using Microsoft Fabric. The project follows the **Medallion Architecture (Bronze → Silver → Gold)**, enabling data ingestion, transformation, modeling, governance, reporting, collaboration, and version control within a unified analytics platform.

The solution begins with ingesting raw banking datasets into the **Bronze layer**, progressively transforms and enriches the data through the **Silver layer**, and finally creates business-ready dimensional models in the **Gold layer** for analytical reporting.

The project concludes with governance, security, deployment, optimization using **Materialized Lake Views**, and collaborative development through **Git Integration**.

---

# Project Objectives

The project demonstrates how to:

- Build an end-to-end analytics solution using Microsoft Fabric
- Implement Medallion Architecture
- Automate data ingestion using Pipelines
- Transform data using Dataflow Gen2
- Store curated data as Delta Tables
- Create a Star Schema for reporting
- Build a Power BI Dashboard
- Implement Governance and Security
- Configure Deployment Pipelines
- Optimize queries using Materialized Lake Views
- Enable collaborative development through Git Integration

---

# Solution Architecture

```text
Source Banking Data
        │
        ▼
Bronze Data Layer
(Raw Data Ingestion & Storage)
        │
        ▼
Silver Data Layer
(Cleaning & Standardization)
        │
        ▼
Gold Data Layer
(Business Ready Data Warehouse)
        │
        ▼
Semantic Model (Power BI)
        │
        ▼
Interactive Dashboard
        │
 ┌──────┴──────────────┐
 ▼                     ▼
Governance & Security  Deployment Pipeline
        │                     │
        └──────────┬──────────┘
                   ▼
          Git Version Control
```

---

# Module 1: Bronze Data Layer

## Overview

The **Bronze layer** is the first stage of the Medallion Architecture. It is responsible for ingesting raw banking datasets into Microsoft Fabric while preserving the original data without applying business transformations.

The data is stored as **Delta tables** within a Lakehouse, providing a reliable foundation for downstream processing.

The Bronze layer implementation consists of:

- Create Lakehouse
- Upload Source Files
- Create Bronze Data Ingestion Pipeline
- Create Bronze Dataflow Gen2
- Create Bronze Delta Tables
- Validate Bronze Layer

---

# 1.1 Create the Bronze Lakehouse

## Objective

Create a Microsoft Fabric Lakehouse to centrally store raw banking datasets and Delta tables used throughout the Medallion Architecture.

### Navigation

```text
Microsoft Fabric
→ Workspaces
→ fabric_banking_analytics_ws
→ New Item
→ Lakehouse
```

### Method

Follow the steps below in sequence:

1. Open the **fabric_banking_analytics_ws** workspace.
2. Click **New Item**.
3. Search for **Lakehouse**.
4. Select **Lakehouse**.
5. Enter the following name:

   ```
   fabric_banking_medallion_lakehouse
   ```

6. Click **Create**.
7. Wait until the Lakehouse is successfully provisioned.
8. Open the Lakehouse.
9. Verify that the following folders are available:

   - Tables
   - Files

### Expected Result

A Lakehouse named **fabric_banking_medallion_lakehouse** is successfully created.

---

# 1.2 Upload the Banking Source Files

## Objective

Upload the raw banking CSV datasets into the Lakehouse so they can be consumed by Pipelines and Dataflows.

### Navigation

```text
fabric_banking_medallion_lakehouse
→ Files
→ Upload
→ Files
```

### Method

Follow the steps below in sequence:

1. Open **fabric_banking_medallion_lakehouse**.
2. Select **Files**.
3. Click **Upload**.
4. Select **Files**.
5. Browse to the banking dataset location.
6. Upload the following files:

   - users.csv
   - cards.csv
   - transactions.csv

7. Wait for all files to finish uploading.
8. Verify that all three CSV files appear under **Files**.

---

# 1.3 Create the Bronze Data Ingestion Pipeline

## Objective

Create a Fabric Pipeline that automates the ingestion of raw banking files into the Bronze layer.

### Navigation

```text
fabric_banking_analytics_ws
→ New Item
→ Data Pipeline
```

### Method

Follow the steps below in sequence:

1. Click **New Item**.
2. Select **Data Pipeline**.
3. Rename the pipeline:

   ```
   pl_bronze_ingestion
   ```

4. Click **Create**.
5. Add a **Copy Data** activity to the canvas.
6. Configure the **Source** connection.
7. Browse to the uploaded CSV files in the Lakehouse.
8. Configure the **Destination** as the Lakehouse.
9. Enable **Automatic Table Creation**.
10. Save the pipeline.
11. Click **Run**.
12. Wait for the execution to complete successfully.

---

# 1.4 Create the Bronze Dataflow Gen2

## Objective

Create a Dataflow Gen2 that reads the raw Bronze tables, performs minimal ingestion processing, and writes the data back as managed Bronze Delta tables.

### Navigation

```text
fabric_banking_analytics_ws
→ New Item
→ Dataflow Gen2
```

### Method

Follow the steps below in sequence:

1. Click **New Item**.
2. Select **Dataflow Gen2**.
3. Rename the Dataflow:

   ```
   df_bronze_standardization
   ```

4. Click **Create**.
5. In the Power Query editor, click **Get Data**.
6. Select **Lakehouse** as the source.
7. Choose the following Lakehouse:

   ```
   fabric_banking_medallion_lakehouse
   ```

8. Select the following source files/tables:

   - users
   - cards
   - transactions

9. Load all three queries into the Dataflow.
10. Rename the queries as:

```
bronze_users
bronze_cards
bronze_transactions
```

11. Review each query and verify that **no business transformations** are applied.
12. Configure the **Data Destination** for each query.

**Destination**

```
Lakehouse
```

**Lakehouse**

```
fabric_banking_medallion_lakehouse
```

13. Enable **Replace Existing Table** (if re-running).
14. Save the Dataflow.
15. Click **Publish**.
16. Wait until the Dataflow refresh completes successfully.

### Expected Result

The Bronze Dataflow successfully loads all three raw datasets into managed Delta tables without applying business transformations.

---

# 1.5 Create Bronze Delta Tables

## Objective

Persist the raw banking datasets as Delta tables within the Lakehouse to provide scalable and ACID-compliant storage.

### Navigation

```text
fabric_banking_medallion_lakehouse
→ Tables
```

### Method

After the Bronze Dataflow completes successfully:

1. Open the Lakehouse.
2. Select **Tables**.
3. Verify that the following Delta tables have been created:

```
bronze_users
bronze_cards
bronze_transactions
```

4. Open each table.
5. Preview the data.
6. Verify that all records have been loaded successfully.

### Expected Result

The Bronze Lakehouse contains the following Delta tables:

- bronze_users
- bronze_cards
- bronze_transactions

---

# 1.6 Validate the Bronze Layer

## Objective

Verify that the Bronze ingestion process has successfully loaded the raw banking data into Delta tables.

### Navigation

```text
fabric_banking_medallion_lakehouse
→ SQL Analytics Endpoint
→ New SQL Query
```

### Method

Follow the steps below in sequence:

1. Open the **SQL Analytics Endpoint**.
2. Create a new SQL query.

3. Validate the **Users** table.

```sql
SELECT COUNT(*) AS TotalUsers
FROM bronze_users;
```

4. Validate the **Cards** table.

```sql
SELECT COUNT(*) AS TotalCards
FROM bronze_cards;
```

5. Validate the **Transactions** table.

```sql
SELECT COUNT(*) AS TotalTransactions
FROM bronze_transactions;
```

6. Compare the record counts with the original source files.
7. Verify that no unexpected NULL values or missing records exist due to ingestion issues.

### Expected Result

All Bronze Delta tables contain the expected number of records, matching the uploaded source datasets and confirming successful data ingestion.
