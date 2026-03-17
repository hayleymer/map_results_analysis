# 📊 Data Dictionary

## Overview
This dataset is derived from MAP (Measures of Academic Progress) assessment data.  
Only columns used in SQL analysis are included below.  
Raw data is not shared due to privacy constraints.

---

## Core Identifiers

| Column | Type | Description |
|--------|------|------------|
| student_id | INT | Unique anonymised student identifier |
| grade | INT | Student grade level |

---

## Assessment Context

| Column | Type | Description |
|--------|------|------------|
| course | TEXT | Specific subject/course (e.g., Reading, Math K-12, Language Usage) |

---

## Achievement Measures

| Column | Type | Description |
|--------|------|------------|
| test_rit_score | NUMERIC | MAP RIT score representing student achievement level |
| achievement_quintile | TEXT | Performance band (Low, LoAvg, Avg, HiAvg, High) |

---

## Growth Measures

| Column | Type | Description |
|--------|------|------------|
| fall_to_fall_observed_growth | NUMERIC | Actual RIT score growth across the academic year |

---

## Derived / Analytical Fields

| Column | Type | Description |
|--------|------|------------|
| school_stage | TEXT | Derived grouping of grades: Elementary (3–5) and Middle School (6–8) |

---

## Notes

- Growth values may be positive or negative, indicating improvement or decline.
- Median calculations use `PERCENTILE_CONT(0.5)` within grade and course.
- Significant difference from median is defined as ±10% of the median RIT score.
- Cross-subject comparisons use pivoted RIT scores (Reading, Math, Language).
- Achievement bands are ordered for reporting: Low → LoAvg → Avg → HiAvg → High.

---