# 🐸 GBIF Amphibian Data Pipeline

## Overview

This project presents an end-to-end data engineering pipeline built on amphibian occurrence records retrieved from the Global Biodiversity Information Facility (GBIF).

The goal was to transform raw biodiversity occurrence data into an analytical-ready dataset using SQL-based ETL processes, enabling temporal, spatial, and institutional analyses.

---

## 🧱 Project Architecture

Raw GBIF Data → PostgreSQL ETL → Cleaned Dataset → Feature Engineering → Analytical Dataset → Python Analysis

---

## 🌍 Data Source

The dataset consists of amphibian occurrence records downloaded from GBIF.

- **Raw dataset size:** ~211 MB  
- **Number of records after processing:** 399,333  
- **Final format:** PostgreSQL relational tables  

> ⚠️ The raw dataset and final CSV are not included in this repository due to size constraints and reproducibility considerations.  
> The full pipeline is fully reproducible using the SQL scripts provided.

---

## ⚙️ ETL Process (SQL)

The following transformations were performed in PostgreSQL:

### 1. Data Cleaning
- Standardization of `stateProvince` (Brazilian states normalization)
- Handling of missing and inconsistent values
- Harmonization of taxonomic and geographic fields

### 2. Date Processing
- Parsing heterogeneous `eventdate` formats
- Creation of `eventdate_clean` (DATE type)
- Extraction of temporal components:
  - year
  - month
  - day

### 3. Feature Engineering
Derived variables:
- `decade` (temporal aggregation)
- `century`
- `season` (Southern Hemisphere)

### 4. Data Quality Assessment
- Column completeness profiling
- Identification of low-information fields
- Feature selection and dimensionality reduction

---

## 📊 Dataset Summary

- 399,333 original occurrence records
- 326,520 records with valid temporal information (81.8%)
- Final analytical dataset enriched with temporal and standardized fields

---

## 📈 Key Insights

- Strong temporal increase in records after the 1950s
- Peak in biodiversity records between 2000–2010, associated with digitization efforts
- Seasonal bias consistent with amphibian activity patterns in warmer and wetter months
- Strong institutional concentration in a small number of biodiversity data providers

---

## 🔁 Reproducibility

To reproduce the pipeline:

1. Load raw GBIF occurrence data into PostgreSQL
2. Execute the `gbif_etl.sql` script step-by-step
3. Generate the `gbif_clean` table
4. Run column profiling diagnostics (`column_profile`)
5. Derive the final analytical dataset

No external preprocessing steps are required.

---

## 🧰 Technologies Used

- PostgreSQL
- SQL (ETL, data cleaning, aggregation)
- DBeaver
- GBIF API / dataset

---

---

## 📈 Key Analytical Capabilities

This pipeline enables downstream analyses such as:

- Temporal trends in biodiversity sampling
- Seasonal patterns of amphibian occurrence records
- Institutional bias in biodiversity data collection
- Geographic standardization of Brazilian states
- Large-scale biodiversity data quality assessment

---

## 🧠 Design Principles

This project emphasizes:

- Full transparency in data transformation
- Reproducible SQL-based workflows
- Explicit handling of missing and inconsistent data
- Scalable relational data engineering practices

---

## 🚀 Next Steps (Planned Extensions)

- Python-based exploratory data analysis (EDA)
- Statistical modeling of temporal and spatial patterns
- Visualization dashboard (Matplotlib / Seaborn / Plotly)
- Integration with biodiversity metadata APIs

---

## 📁 Repository Structure
