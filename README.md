# 🐸 GBIF Amphibian Data Pipeline

## Overview

This project presents an end-to-end data engineering pipeline built on amphibian occurrence records retrieved from the Global Biodiversity Information Facility (GBIF).

The goal was to transform raw biodiversity occurrence data into an analytical-ready dataset using SQL-based ETL processes, enabling temporal, spatial, and institutional analyses.

---

## 🧱 Project Architecture

Raw GBIF Data → PostgreSQL ETL → Cleaned Dataset → Feature Engineering → Analytical Dataset → Python Analysis

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

## 🧰 Technologies Used

- PostgreSQL
- SQL (ETL, data cleaning, aggregation)
- DBeaver
- GBIF API / dataset

Future additions:
- Python (pandas, seaborn, matplotlib)
- Statistical analysis
- Data visualization

---

## 📁 Repository Structure
