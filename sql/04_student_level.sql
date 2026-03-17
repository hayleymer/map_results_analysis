/*1. Individual Student Level

Analysis of individual student performance, growth, and cross-subject variation

1.1 Which students showed the largest RIT score growth between tests within each grade?*/

SELECT m.grade,
	m.course,
	m.student_id,
    m.fall_to_fall_observed_growth 
FROM map_data m
JOIN (SELECT grade,
         course,
         MAX(fall_to_fall_observed_growth) AS max_growth
    FROM map_data
    GROUP BY grade, course
) m2
ON m.grade = m2.grade
AND m.course = m2.course
AND m.fall_to_fall_observed_growth = m2.max_growth
ORDER BY m.grade, m.course;

/*1.2 Which students had negative RIT scores across the year, and in which subjects?*/

SELECT student_id,
	grade, 
	course, 
	fall_to_fall_observed_growth AS negative_growth
FROM map_data
WHERE fall_to_fall_observed_growth < 0
ORDER BY grade, course
	
/*1.3 Which students are performing significantly above or below the grade median in each subject?*/

SELECT m.student_id, 
m.grade, 
m.course, 
m.test_rit_score,
m2.test_median,
m.test_rit_score - m2.test_median AS difference_from_median
FROM map_data m
JOIN (SELECT grade, 
course, 
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY test_rit_score) AS test_median
FROM map_data
GROUP BY grade, course) m2
ON m.grade = m2.grade
AND m.course = m2.course
WHERE ABS(m.test_rit_score - m2.test_median) > (0.10 * m2.test_median)
ORDER BY course, grade, difference_from_median

/*1.4 How many students fall into each achievement band for the current term?*/
SELECT 
grade,
course, 
achievement_quintile AS achievement_band,
COUNT (*) AS number_in_band
FROM map_data
GROUP BY grade, course, achievement_band
ORDER BY grade, course,   
CASE WHEN achievement_quintile = 'Low' THEN 1
    WHEN achievement_quintile = 'LoAvg' THEN 2
    WHEN achievement_quintile = 'Avg' THEN 3
    WHEN achievement_quintile = 'HiAvg' THEN 4
    WHEN achievement_quintile = 'High' THEN 5
END

/*1.5 Are there students whose performance differs significantly between subjects (e.g., strong reading but low math)?*/
SELECT
    student_id,
    grade,
    MAX(CASE WHEN course = 'Reading' THEN test_rit_score END) AS reading_score,
    MAX(CASE WHEN course = 'Math K-12' THEN test_rit_score END) AS math_score,
    MAX(CASE WHEN course = 'Language Usage' THEN test_rit_score END) AS language_score
FROM map_data
GROUP BY student_id, grade
HAVING 
GREATEST(
    MAX(CASE WHEN course='Reading' THEN test_rit_score END),
    MAX(CASE WHEN course='Math K-12' THEN test_rit_score END),
    MAX(CASE WHEN course='Language Usage' THEN test_rit_score END)
)
-
LEAST(
    MAX(CASE WHEN course='Reading' THEN test_rit_score END),
    MAX(CASE WHEN course='Math K-12' THEN test_rit_score END),
    MAX(CASE WHEN course='Language Usage' THEN test_rit_score END)
) >= 30
ORDER BY grade, student_id;

