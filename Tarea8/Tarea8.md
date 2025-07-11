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

---

*VIEW + LEFT JOIN*: La vista **Vista_Estudiantes_Con_o_Sin_Calificaciones** muestra a todos los estudiantes, incluso si no tienen calificaciones registradas, junto con el nombre de la escuela a la que pertenecen y, si existe, el curso y su calificación final (G3). Dentro de los beneficios de esta vista estan: 

- Visión completa del padrón estudiantil, incluso de quienes aún no han tomado cursos.
- Útil para detectar estudiantes inactivos o recién inscritos.
- Permite construir reportes de cobertura académica, como qué porcentaje de alumnos ya tiene alguna calificación.
- Evita perder datos valiosos de estudiantes que aún no han sido evaluados.

```sql

CREATE VIEW Vista_Estudiantes_Con_o_Sin_Calificaciones AS
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
LEFT JOIN 
    Grades g ON s.student_id = g.student_id
LEFT JOIN 
    Course c ON g.course_id = c.course_id;


Select * FROM Vista_Estudiantes_Con_o_Sin_Calificaciones LIMIT 10;

```

Para fines ilustrativos, con la ultima linea podemos observar los primeros 10 registros de la vista:

| student\_id | age | sex | nombre\_escuela | nombre\_curso | calificacion\_final |
| ----------- | --- | --- | --------------- | ------------- | ------------------- |
| 500         | 16  | F   | Gabriel Pereira | *(NULL)*      | *(NULL)*            |
| 499         | 18  | F   | Gabriel Pereira | *(NULL)*      | *(NULL)*            |
| 498         | 20  | M   | Gabriel Pereira | *(NULL)*      | *(NULL)*            |
| 497         | 23  | F   | Gabriel Pereira | *(NULL)*      | *(NULL)*            |
| 496         | 21  | M   | Gabriel Pereira | *(NULL)*      | *(NULL)*            |
| 495         | 25  | F   | Gabriel Pereira | *(NULL)*      | *(NULL)*            |
| 494         | 20  | M   | Gabriel Pereira | *(NULL)*      | *(NULL)*            |
| 493         | 20  | M   | Gabriel Pereira | *(NULL)*      | *(NULL)*            |
| 492         | 20  | M   | Gabriel Pereira | Portuguese    | 12                  |
| 491         | 24  | F   | Gabriel Pereira | *(NULL)*      | *(NULL)*            |

---

