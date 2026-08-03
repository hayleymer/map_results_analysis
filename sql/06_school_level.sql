/*3. Whole School Level

These questions move the discussion to school improvement and leadership decisions.*/

/*3.1 How does achievement and growth vary between elementary grades and middle school grades?*/

SELECT school_stage, 
course, 
ROUND(AVG(fall_to_fall_observed_growth), 2) AS average_growth
FROM (SELECT grade, 
course, 
fall_to_fall_observed_growth, 
CASE  
WHEN grade BETWEEN 3 AND 5 THEN 'Elementary'
WHEN grade BETWEEN 6 AND 8 THEN 'Middle School'
END AS school_stage
FROM map_data
WHERE grade >2) m
GROUP BY school_stage, course
ORDER BY course, school_stage;

/*3.2 Which subject areas demonstrate the strongest overall growth and overall achievement across the school this year?*/
SELECT course, 
ROUND(AVG(fall_to_fall_observed_growth), 2) AS average_growth,
ROUND(AVG(test_rit_score), 2) AS average_rit
FROM map_data
GROUP BY course
ORDER BY average_rit, average_growth;

/*3.3 Which grades are showing the most/least growth and achievement this year?*/
SELECT course, 
grade, 
ROUND(AVG(fall_to_fall_observed_growth), 2) AS average_growth,
ROUND(AVG(test_rit_score), 2) AS average_rit
FROM map_data
GROUP BY course, grade
ORDER BY course, grade, average_rit, average_growth;

/*3.4 Which grades are showing the most achievement this year? Pivoted to wide format */
SELECT 
    course,
    ROUND(AVG(CASE WHEN grade = 3 THEN test_rit_score END), 2) AS grade_3_rit,
    ROUND(AVG(CASE WHEN grade = 4 THEN test_rit_score END), 2) AS grade_4_rit,
    ROUND(AVG(CASE WHEN grade = 5 THEN test_rit_score END), 2) AS grade_5_rit,
    ROUND(AVG(CASE WHEN grade = 6 THEN test_rit_score END), 2) AS grade_6_rit,
    ROUND(AVG(CASE WHEN grade = 7 THEN test_rit_score END), 2) AS grade_7_rit,
    ROUND(AVG(CASE WHEN grade = 8 THEN test_rit_score END), 2) AS grade_8_rit
FROM map_data
GROUP BY course
ORDER BY course;

/*3.5 Which grades are showing the most growth this year? Pivoted to wide format */

SELECT 
    course,
    ROUND(AVG(CASE WHEN grade = 3 THEN fall_to_fall_observed_growth END), 2) AS grade_3_growth,
    ROUND(AVG(CASE WHEN grade = 4 THEN fall_to_fall_observed_growth END), 2) AS grade_4_growth,
    ROUND(AVG(CASE WHEN grade = 5 THEN fall_to_fall_observed_growth END), 2) AS grade_5_growth,
    ROUND(AVG(CASE WHEN grade = 6 THEN fall_to_fall_observed_growth END), 2) AS grade_6_growth,
    ROUND(AVG(CASE WHEN grade = 7 THEN fall_to_fall_observed_growth END), 2) AS grade_7_growth,
    ROUND(AVG(CASE WHEN grade = 8 THEN fall_to_fall_observed_growth END), 2) AS grade_8_growth
FROM map_data
GROUP BY course
ORDER BY course;
