# Tarea 4 (Base de Datos Relacionales)

## Creación de base de datos *(Lenguage SQL, se usa como SGBD MySQL)*

**El código SQL realiza lo siguiente:**

 - Se crea la base de datos en la cual se guardara cada una de nuestras tablas, esta BD es llamada *STUDENTS_PERFORMANCE_DB*
 - En la base de datos se crean 4 tablas siguiendo la lógica del modelo relacional y modelo entidad-relación observado en los anteriores entregables. Las 4 tablas son:
    - School
    - Course
    - Student
    - Grades  
 - En cada tabla se definen cuales son sus PK, FK y tipo de valor de cada atributo.
 - Finalmente se poblan completamente las tablas *School* y *Course*, mientras que para las tablas *Student* y *Grades* se incluyen 10 registros.

```sql
-- Eliminar BD si existe
DROP DATABASE IF EXISTS STUDENTS_PERFORMANCE_DB;

-- Creamos BD
CREATE DATABASE STUDENTS_PERFORMANCE_DB;
USE STUDENTS_PERFORMANCE_DB;

-- Tabla School
CREATE TABLE School (
    school_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Tabla Course
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Tabla Student
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    sex VARCHAR(1) CHECK (sex IN ('F', 'M')),
    age INT,
    address VARCHAR(1) CHECK (address IN ('U', 'R')),
    famsize VARCHAR(3) CHECK (famsize IN ('LE3', 'GT3')),
    Pstatus VARCHAR(1) CHECK (Pstatus IN ('T', 'A')),
    Medu INT CHECK (Medu BETWEEN 0 AND 4),
    Fedu INT CHECK (Fedu BETWEEN 0 AND 4),
    Mjob VARCHAR(10) CHECK (Mjob IN ('teacher', 'health', 'services', 'at_home', 'other')),
    Fjob VARCHAR(10) CHECK (Fjob IN ('teacher', 'health', 'services', 'at_home', 'other')),
    guardian VARCHAR(10) CHECK (guardian IN ('mother', 'father', 'other')),
    traveltime INT CHECK (traveltime BETWEEN 1 AND 4),
    studytime INT CHECK (studytime BETWEEN 1 AND 4),
    failures INT CHECK (failures BETWEEN 0 AND 4),
    schoolsup BOOLEAN,
    famsup BOOLEAN,
    paid BOOLEAN,
    activities BOOLEAN,
    nursery BOOLEAN,
    higher BOOLEAN,
    internet BOOLEAN,
    romantic BOOLEAN,
    famrel INT CHECK (famrel BETWEEN 1 AND 5),
    freetime INT CHECK (freetime BETWEEN 1 AND 5),
    goout INT CHECK (goout BETWEEN 1 AND 5),
    Dalc INT CHECK (Dalc BETWEEN 1 AND 5),
    Walc INT CHECK (Walc BETWEEN 1 AND 5),
    health INT CHECK (health BETWEEN 1 AND 5),
    absences INT,
    school_id VARCHAR(10),
    FOREIGN KEY (school_id) REFERENCES School(school_id) ON DELETE CASCADE
);

-- Tabla Grades
CREATE TABLE Grades (
    student_id INT,
    course_id INT,
    G1 INT CHECK (G1 BETWEEN 0 AND 20),
    G2 INT CHECK (G2 BETWEEN 0 AND 20),
    G3 INT CHECK (G3 BETWEEN 0 AND 20),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE
);


-- Insertar datos School
INSERT INTO School VALUES
('GP', 'Gabriel Pereira'),
('MS', 'Mousinho da Silveira');

-- Insertar datos Course
INSERT INTO Course VALUES
(1, 'Math'),
(2, 'Portuguese');

-- Insertar datos Student
INSERT INTO Student VALUES
(1, 'F', 18, 'U', 'GT3', 'A', 4, 4, 'at_home', 'teacher', 'mother', 2, 2, 0, TRUE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE, 4, 3, 4, 1, 1, 3, 6, 'GP'),
(2, 'F', 17, 'U', 'GT3', 'T', 1, 1, 'at_home', 'other', 'father', 1, 2, 0, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, TRUE, 5, 3, 3, 1, 1, 3, 4, 'GP'),
(3, 'F', 15, 'U', 'LE3', 'T', 1, 1, 'at_home', 'other', 'mother', 1, 2, 3, TRUE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE, 4, 3, 2, 2, 3, 3, 10, 'GP'),
(4, 'F', 15, 'U', 'GT3', 'T', 4, 2, 'health', 'services', 'mother', 1, 3, 0, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, TRUE, 3, 2, 2, 1, 1, 5, 2, 'GP'),
(5, 'F', 16, 'U', 'GT3', 'T', 3, 3, 'other', 'other', 'father', 1, 2, 0, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, 4, 3, 2, 1, 2, 5, 4, 'GP'),
(6, 'M', 16, 'U', 'LE3', 'T', 4, 3, 'services', 'other', 'mother', 1, 2, 0, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, 5, 4, 2, 1, 2, 5, 10, 'GP'),
(7, 'M', 16, 'U', 'LE3', 'T', 2, 2, 'other', 'other', 'mother', 1, 2, 0, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE, 4, 4, 4, 1, 1, 3, 0, 'GP'),
(8, 'F', 17, 'U', 'GT3', 'A', 4, 4, 'other', 'teacher', 'mother', 2, 2, 0, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, 4, 1, 4, 1, 1, 1, 6, 'GP'),
(9, 'M', 15, 'U', 'LE3', 'A', 3, 2, 'services', 'other', 'mother', 1, 2, 0, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE, 4, 2, 2, 1, 1, 1, 0, 'GP'),
(10, 'M', 15, 'U', 'GT3', 'T', 3, 4, 'other', 'other', 'mother', 1, 2, 0, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE, 5, 5, 1, 1, 1, 5, 0, 'GP');

-- Insertar datos Grades
INSERT INTO Grades VALUES
(1,1,5,6,6),
(1,2,0,11,11),
(2,1,5,5,6),
(2,2,9,11,11),
(3,1,7,8,10),
(3,2,12,13,12),
(4,1,15,14,15),
(4,2,14,14,14),
(5,1,6,10,10),
(5,2,11,13,13);


SHOW TABLES;
SELECT * FROM School;
SELECT * FROM Course;
SELECT * FROM Student;
SELECT * FROM Grades;

```