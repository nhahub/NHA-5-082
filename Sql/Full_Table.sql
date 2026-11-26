CREATE DATABASE student_performance;
USE student_performance;

CREATE TABLE students_performance (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20),
    name VARCHAR(100),
    subject VARCHAR(100),
    score DECIMAL(5,2),
    date DATE,
    attendance DECIMAL(5,2),
    performance VARCHAR(20)
);

SELECT COUNT(*) 
FROM students_performance;

SELECT *
FROM students_performance
LIMIT 10;

SELECT
    COUNT(*) AS total_records,
    SUM(student_id IS NULL) AS missing_student_id,
    SUM(name IS NULL) AS missing_name,
    SUM(subject IS NULL) AS missing_subject,
    SUM(score IS NULL) AS missing_score,
    SUM(date IS NULL) AS missing_date,
    SUM(attendance IS NULL) AS missing_attendance,
    SUM(performance IS NULL) AS missing_performance
FROM students_performance;




-- Query one for average student score
SELECT
    subject,
    COUNT(*) AS total_records,
    ROUND(AVG(score), 2) AS average_score
FROM students_performance
GROUP BY subject
ORDER BY average_score DESC;

-- Count students in each performance level

SELECT
    performance,
    COUNT(*) AS total_students
FROM students_performance
GROUP BY performance
ORDER BY total_students DESC;



-- Average attendance by performance level

SELECT
    performance,
    ROUND(AVG(attendance), 2) AS average_attendance
FROM students_performance
GROUP BY performance
ORDER BY average_attendance DESC;


-- Performance distribution across subjects

SELECT
    subject,
    performance,
    COUNT(*) AS total_records
FROM students_performance
GROUP BY subject, performance
ORDER BY subject, performance;




-- Average score for each performance level(summary for query Performance distribution across subjects)

SELECT
    performance,
    COUNT(*) AS total_records,
    ROUND(AVG(score), 2) AS average_score
FROM students_performance
GROUP BY performance
ORDER BY average_score DESC;



-- Percentage of each performance level

SELECT
    performance,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM students_performance),
        2
    ) AS percentage
FROM students_performance
GROUP BY performance
ORDER BY percentage DESC;



-- Top 10 students by average score

SELECT
    student_id,
    name,
    COUNT(*) AS total_records,
    ROUND(AVG(score), 2) AS average_score
FROM students_performance
GROUP BY student_id, name
ORDER BY average_score DESC
LIMIT 10;



-- Bottom 10 students by average score

SELECT
    student_id,
    name,
    COUNT(*) AS total_records,
    ROUND(AVG(score), 2) AS average_score
FROM students_performance
GROUP BY student_id, name
ORDER BY average_score ASC
LIMIT 10;



-- General statistics about student performance

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT student_id) AS total_students,
    ROUND(AVG(score), 2) AS average_score,
    MAX(score) AS highest_score,
    MIN(score) AS lowest_score,
    ROUND(AVG(attendance), 2) AS average_attendance
FROM students_performance;



SELECT
    student_id,
    COUNT(DISTINCT name) AS names_count
FROM students_performance
GROUP BY student_id
HAVING COUNT(DISTINCT name) > 1;

