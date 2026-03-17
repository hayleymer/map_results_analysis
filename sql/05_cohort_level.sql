/*
#2. Grade / Cohort Level

These questions support instructional conversations at the grade/cohort level.*/

/* 2.1 Which courses demonstrated the highest/lowest average growth across the year?*/

SELECT 
grade,
course,
ROUND(AVG(fall_to_fall_observed_growth), 2) AS avg_growth
FROM map_data
GROUP BY grade, course
ORDER BY grade, avg_growth DESC;

/*2.2 What is the distribution of student growth within each course (e.g., high growth vs low growth students)?*/

SELECT grade, 
course, 
MAX(fall_to_fall_observed_growth) - MIN(fall_to_fall_observed_growth) AS growth_distribution
FROM map_data
GROUP BY grade, course
ORDER BY grade, growth_distribution DESC;

/*2.3 Are there courses where student growth is uneven across gender groups?*/

SELECT grade, 
course, 
student_gender, 
ROUND(AVG(fall_to_fall_observed_growth), 2) AS avg_growth
FROM map_data
WHERE grade > 2
GROUP BY grade, course, student_gender
ORDER BY grade, course, student_gender

/*2.4 Which courses have the largest proportion of students meeting projected growth targets?*/

SELECT grade, 
course, 
COUNT (CASE WHEN fall_to_fall_met_projected_growth LIKE 'Yes%' THEN 1 END) AS met_growth_projection,
ROUND(COUNT(*) FILTER(WHERE fall_to_fall_met_projected_growth LIKE 'Yes%') * 100.0 / COUNT(*) FILTER(WHERE fall_to_fall_met_projected_growth LIKE 'Yes%' 
                        OR fall_to_fall_met_projected_growth LIKE 'No%'), 2) AS percentage_met,
COUNT(CASE WHEN fall_to_fall_met_projected_growth LIKE 'No%' THEN 1 END) AS not_met_growth_projection,
ROUND(COUNT(*) FILTER(WHERE fall_to_fall_met_projected_growth LIKE 'No%') * 100.0 / COUNT(*) FILTER(WHERE fall_to_fall_met_projected_growth LIKE 'Yes%' 
                        OR fall_to_fall_met_projected_growth LIKE 'No%'), 2) AS percentage_not_met
FROM map_data
WHERE grade > 2
GROUP BY grade, course
ORDER BY grade, course
