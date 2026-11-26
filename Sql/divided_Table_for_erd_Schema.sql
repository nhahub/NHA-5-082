-- Create Students table

CREATE TABLE students (
    student_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create Subjects table

CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create Performance Records table

CREATE TABLE performance_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL,
    subject_id INT NOT NULL,
    score DECIMAL(5,2),
    date DATE,
    attendance DECIMAL(5,2),
    performance VARCHAR(20),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (subject_id)
        REFERENCES subjects(subject_id)
);

INSERT INTO students (student_id, name)
SELECT DISTINCT student_id, name
FROM students_performance;

INSERT INTO subjects (subject_name)
SELECT DISTINCT subject
FROM students_performance;

INSERT INTO performance_records (
    student_id,
    subject_id,
    score,
    date,
    attendance,
    performance
)
SELECT
    sp.student_id,
    s.subject_id,
    sp.score,
    sp.date,
    sp.attendance,
    sp.performance
FROM students_performance sp
JOIN subjects s
    ON sp.subject = s.subject_name;


SELECT COUNT(*) AS total_students
FROM students;

SELECT COUNT(*) AS total_subjects
FROM subjects;

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT student_id) AS total_students,
    COUNT(DISTINCT subject_id) AS total_subjects,
    ROUND(AVG(score), 2) AS average_score
FROM performance_records;
