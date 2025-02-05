DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS bolsa_talento;
DROP TABLE IF EXISTS modules;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS bootcamps;
DROP TABLE IF EXISTS bootcamps_edition;
DROP TABLE IF EXISTS coordinators;
DROP TABLE IF EXISTS teachers;


--Table Students

CREATE TABLE students (
student_id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
surname	VARCHAR(255) NOT NULL,
birthday DATE NOT NULL,
email VARCHAR(255) NOT NULL,
phone VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL
);


--Table Coordinators

CREATE TABLE coordinators (
coordinator_id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
surname	VARCHAR(255) NOT NULL,
birthday DATE NOT NULL,
email VARCHAR(255) NOT NULL,
phone VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL
);


--Table Bootcamps

CREATE TABLE bootcamps (
bootcamp_id SERIAL PRIMARY KEY,
bootcamp_name VARCHAR(255) NOT NULL,
price DECIMAL(10, 2) NOT NULL
);


--Table Bootcamps_Edition

CREATE TABLE bootcamps_edition (
bootcamp_edition_id SERIAL PRIMARY KEY,
edition VARCHAR(255) NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
bootcamp_id int,
coordinator_id int,
FOREIGN KEY (bootcamp_id) REFERENCES bootcamps(bootcamp_id),
FOREIGN KEY (coordinator_id) REFERENCES coordinators(coordinator_id)
);


--Table Enrollments

CREATE TABLE enrollments (
enrollment_id SERIAL PRIMARY KEY,
registration_date DATE NOT NULL,
student_id int,
bootcamp_edition_id int,
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (bootcamp_edition_id) REFERENCES bootcamps_edition(bootcamp_edition_id)
);


--Table Bolsa_Talento

CREATE TABLE bolsa_talento ( 
bolsa_talento_id SERIAL PRIMARY KEY,
registration_date DATE NOT NULL,
student_id int,
FOREIGN KEY (student_id) REFERENCES students(student_id)
);


--Table Teachers

CREATE TABLE teachers (
teacher_id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
surname	VARCHAR(255) NOT NULL,
birthday DATE NOT NULL,
email VARCHAR(255) NOT NULL,
phone VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
speciality  VARCHAR(255) NOT NULL,
hire_date DATE NOT NULL,
end_date DATE
);


--Table Modules

CREATE TABLE modules (
module_id SERIAL PRIMARY KEY,
module_name VARCHAR(255) NOT NULL,
start_date DATE,
end_date DATE,
bootcamp_edition_id int,
teacher_id int,
FOREIGN KEY (bootcamp_edition_id) REFERENCES bootcamps_edition(bootcamp_edition_id),
FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);
