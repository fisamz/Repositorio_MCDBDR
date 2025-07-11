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

*VIEW + RIGHT JOIN*: La vista Vista_Estadisticas_Cursos2 resume información académica a nivel de curso. Utiliza un RIGHT JOIN entre las tablas Grades y Course para asegurar que todos los cursos aparezcan en el resultado, incluso aquellos que aún no han sido inscritos por ningún estudiante.

Esta vista agrupa la información por curso (GROUP BY) y calcula dos métricas clave:
- cantidad_estudiantes: número de estudiantes que han cursado esa materia, obtenido mediante COUNT(g.student_id).
- promedio_calificacion_final: promedio de las calificaciones finales (G3) registradas en el curso, calculado mediante AVG(g.G3).

El resultado es una tabla que indica cuántos estudiantes han tomado cada curso y cuál ha sido su promedio final, o bien señala que aún no se han inscrito alumnos en ese curso.

Dentro de los beneficios de esta vista estan:

- Se visualizan todos los cursos disponibles, incluyendo aquellos aún no tomados por ningún estudiante. Esto permite una revisión integral del plan de estudios.
- Con cantidad_estudiantes, se puede identificar cuántos alumnos han inscrito cada materia, detectando cursos poco concurridos o de alta demanda.
- El campo promedio_calificacion_final facilita la evaluación del rendimiento promedio en cada curso, lo que puede ser útil para detectar materias con bajo desempeño general.

```sql

-- Se agregan cursos extra para fines ilustrativos
INSERT INTO Course (course_id, name)
VALUES 
    (3, 'History'),
    (4, 'Physics');


CREATE VIEW Vista_Estadisticas_Cursos2 AS
SELECT 
    c.course_id,
    c.name AS nombre_curso,
    COUNT(g.student_id) AS cantidad_estudiantes,
    AVG(g.G3) AS promedio_calificacion_final
FROM 
    Grades g
RIGHT JOIN 
    Course c ON g.course_id = c.course_id
GROUP BY 
    c.course_id, c.name;

Select * FROM Vista_Estadisticas_Cursos2;

```

Para fines ilustrativos, se agregan 2 cursos extras a la TABLE Course, además, con la ultima linea podemos observar el resultado de la vista:

| course\_id | nombre\_curso | cantidad\_estudiantes | promedio\_calificacion\_final |
| ---------- | ------------- | --------------------- | ----------------------------- |
| 1          | Math          | 47                    | 10.1489                       |
| 2          | Portuguese    | 53                    | 10.1132                       |
| 3          | History       | 0                     | NULL                          |
| 4          | Physics       | 0                     | NULL                          |

---

*Subconsultas de una vista*: Se pueden realizar subconsultas de las vistas anteriormente creadas al igual que lo realizamos con tablas, por ejemplo usando la vista llamada **Vista_Desempeno_Estudiantes** extraemos solo los hombres que hayan cursado matematicas y tengan una calificación sobresaliente (mayor o igual a 16).

```sql

CREATE VIEW Vista_Hombres_Math_Sobresalientes2 AS
SELECT *
FROM Vista_Desempeno_Estudiantes
WHERE sex = 'M'
  AND nombre_curso = (
    SELECT name
    FROM Course
    WHERE name = 'Math'
    LIMIT 1
  )
  AND calificacion_final >= 16;

Select * FROM Vista_Hombres_Math_Sobresalientes2;

```

De manera ilustrativa, la subconsulta muestra lo siguiente:

| student\_id | age | sex | nombre\_escuela      | nombre\_curso | calificacion\_final |
| ----------- | --- | --- | -------------------- | ------------- | ------------------- |
| 427         | 18  | M   | Gabriel Pereira      | Math          | 17                  |
| 343         | 25  | M   | Gabriel Pereira      | Math          | 17                  |
| 300         | 17  | M   | Gabriel Pereira      | Math          | 18                  |
| 104         | 15  | M   | Gabriel Pereira      | Math          | 20                  |
| 78          | 15  | M   | Gabriel Pereira      | Math          | 17                  |
| 106         | 22  | M   | Gabriel Pereira      | Math          | 19                  |
| 450         | 20  | M   | Mousinho da Silveira | Math          | 17                  |
| 159         | 17  | M   | Mousinho da Silveira | Math          | 18                  |

---

*Subconsultas de una vista*: Se pueden realizar subconsultas de las vistas anteriormente creadas al igual que lo realizamos con tablas, por ejemplo usando la vista llamada **Vista_Desempeno_Estudiantes** extraemos solo los hombres que hayan cursado matematicas y tengan una calificación sobresaliente (mayor o igual a 16).

```sql

CREATE VIEW Vista_Hombres_Math_Sobresalientes2 AS
SELECT *
FROM Vista_Desempeno_Estudiantes
WHERE sex = 'M'
  AND nombre_curso = (
    SELECT name
    FROM Course
    WHERE name = 'Math'
    LIMIT 1
  )
  AND calificacion_final >= 16;

Select * FROM Vista_Hombres_Math_Sobresalientes2;

