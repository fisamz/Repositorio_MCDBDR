# Tarea 8 (Base de Datos Relacionales)

## SQL: View, Join, Trigger

*VIEW + JOIN*: La vista **Vista_Desempeno_Estudiantes** permite obtener una versión unificada de datos provenientes de cuatro tablas distintas: Student, School, Grades y Course. Mediante el uso de un JOIN, se combinan los datos clave de cada entidad, ofreciendo como resultado una tabla virtual que muestra:

- El ID, edad y sexo del estudiante (Student)
- El nombre de la escuela a la que pertenece (School)
- El nombre del curso que cursó (Course)
- La calificación final obtenida en ese curso (Grades.G3)

Esta vista facilita el análisis del desempeño académico de los estudiantes, permitiendo consultar quiénes cursaron qué materia, en qué institución, y con qué resultado. Otro beneficio de esta vista es la centralización de información dispersa en varias tablas, además que facilita el análisis académico.

```sql

CREATE VIEW Vista_Desempeno_Estudiantes AS
SELECT 
    s.student_id,
    s.age,
    s.sex,
    sc.name AS nombre_escuela,
    c.name AS nombre_curso,
    g.G3 AS calificacion_final
FROM 
    Student s
JOIN 
    School sc ON s.school_id = sc.school_id
JOIN 
    Grades g ON s.student_id = g.student_id
JOIN 
    Course c ON g.course_id = c.course_id;

Select * FROM Vista_Desempeno_Estudiantes
ORDER BY calificacion_final DESC
LIMIT 10;

```

Para fines ilustrativos, se extraen el top 10 de estudiantes con mejor promedio, mostrando la siguiente vista:

| student_id | age | sex | nombre_escuela      | nombre_curso | calificacion_final |
| ----------- | --- | --- | -------------------- | ------------- | ------------------- |
| 150         | 17  | F   | Mousinho da Silveira | Math          | 20                  |
| 318         | 20  | F   | Mousinho da Silveira | Portuguese    | 20                  |
| 334         | 20  | F   | Gabriel Pereira      | Portuguese    | 20                  |
| 183         | 16  | F   | Mousinho da Silveira | Math          | 20                  |
| 104         | 24  | M   | Mousinho da Silveira | Portuguese    | 20                  |
| 106         | 15  | M   | Gabriel Pereira      | Math          | 19                  |
| 330         | 22  | M   | Gabriel Pereira      | Math          | 19                  |
| 304         | 17  | M   | Gabriel Pereira      | Math          | 18                  |
| 300         | 17  | M   | Gabriel Pereira      | Math          | 18                  |
| 159         | 17  | M   | Mousinho da Silveira | Math          | 18                  |
