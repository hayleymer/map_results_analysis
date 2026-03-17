# 📊 MAP Student Growth Analysis

## Overview

This project analyses MAP (Measures of Academic Progress) assessment data to support data-informed discussions at the student, cohort, and whole-school level.

The analysis focuses on:
- student growth over time  
- achievement relative to peers  
- variation across subjects and cohorts  
- practical questions used in Professional Learning Communities (PLCs)  

All analysis is conducted using SQL after preparing and cleaning the dataset.

---

## Data Pipeline

```text
Raw CSV → Python (merge & anonymise) → PostgreSQL → SQL analysis
```

Key steps:
- merged multiple assessment and demographic datasets  
- anonymised student identifiers while preserving row relationships  
- cleaned and transformed data types (text → numeric, date conversion)  
- structured dataset for efficient querying  

---

## Student ID Anonymisation

Student identifiers were anonymised to protect privacy while maintaining analytical integrity.

Each unique student is assigned a consistent numeric ID across all test records.

Example:

| StudentID | Test    | Score |
|----------|--------|------|
| 83921    | Maths   | 78   |
| 83921    | Reading | 82   |

Becomes:

| student_id | Test    | Score |
|-----------|--------|------|
| 1         | Maths   | 78   |
| 1         | Reading | 82   |

Method:

```python
df["anon_student_id"] = pd.factorize(df["StudentID"])[0] + 1
```

A lookup table can be generated if required but is **not included for privacy reasons**.

---

## Key Analytical Questions

### 1. Individual Student Level
- Which students showed the highest growth within each grade?
- Which students experienced negative growth?
- Who is significantly above or below the median?
- Are there students with large differences across subjects?

### 2. Cohort / Grade Level
- Which courses show the highest and lowest average growth?
- How does growth vary across gender groups?
- What proportion of students meet projected growth targets?
- How consistent is growth within each subject?

### 3. Whole School Level
- How does growth differ between elementary and middle school?
- Which subjects show the strongest overall performance?
- Which grades demonstrate the highest achievement and growth?
- How do results compare across grades (pivoted analysis)?

---

## Tools & Techniques

- **SQL (PostgreSQL)**  
  aggregation, joins, subqueries, percentile calculations, pivoting  

- **Python (Pandas)**  
  data merging, transformation, anonymisation  

- **Data Cleaning**  
  text → numeric conversion, handling special characters, date formatting  

---

## Data Availability

The dataset is not included due to privacy and ethical considerations.  
All scripts and SQL queries required to reproduce the analytical structure are provided.

---

## Limitations

- MAP growth projections are based on large external datasets (primarily US-based), which may not reflect local or international contexts  
- High-performing students may show inflated RIT scores, limiting interpretability at the upper range  
- This dataset represents a snapshot rather than longitudinal multi-year data  

---

## Future Opportunities

This analysis highlights the potential for more context-specific modelling.

In particular:
- Developing school-specific growth projections based on historical data
- Improving fairness for students from non-English-speaking backgrounds
- Using longitudinal data to better understand growth trajectories

Custom benchmarks would allow schools to:
- set more meaningful targets  
- better recognise student progress  
- make more accurate instructional decisions  

---

## Summary

This project demonstrates how structured SQL analysis can transform assessment data into meaningful insights for educators, supporting both classroom practice and whole-school decision making.