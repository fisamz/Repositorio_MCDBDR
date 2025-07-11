# Tarea 7 (Base de Datos Relacionales)

## Corrección de errores y subconsultas
*[Contexto de las tablas creadas en SQL que componen las base de datos...](../Tarea4/Tarea4.md)*

### Revisión de inconsistencias

- *Integridad Referencial*: Se validó que todos los student_id presentes en la tabla Grades existan en la tabla Student, y que todos los course_id correspondan a cursos válidos registrados en la tabla Course. No se encontraron inconsistencias.

```sql

SELECT * FROM Grades WHERE student_id NOT IN (SELECT student_id FROM Student);

SELECT * FROM Grades WHERE course_id NOT IN (SELECT course_id FROM Course);

```
- *Rango de calificaciones*: Se revisó que los valores de G1, G2 y G3 estén dentro del rango permitido (0 a 20).

```sql

SELECT * FROM Grades WHERE G1 < 0 OR G1 > 20 OR G2 < 0 OR G2 > 20 OR G3 < 0 OR G3 > 20;

```
- *Estudiantes duplicados*: Se revisó que no existieran student_id duplicados en la tabla Student, lo cual podría generar ambigüedad al hacer busquedas

```sql

SELECT student_id, COUNT(*) 
FROM Student 
GROUP BY student_id 
HAVING COUNT(*) > 1;

```

- *1 calificacion unica por curso/alumno*: Se verificó que no existan registros duplicados por combinación de student_id y course_id en la tabla Grades. Esta restricción es crítica para garantizar que cada estudiante tenga una única calificación por curso

```sql

SELECT student_id, course_id, COUNT(*) AS cantidad
FROM Grades
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

```

**Después de realizar todas las revisiones anteriores, se observa que la base de datos es integra y no presenta errores que requieran correcciones.**

---

### Modificaciones a la Base de Datos

Si bien no se encontraron inconsistencias en la base de datos, las variables consideras BOOL en lenguaje SQL aceptan como valor TRUE/FALSE, mientras que en la base de datos estas columnas tienen valor STRING YES/NO. Se modifican estas columnas para incorporar correctamente a la Base de Datos de acuerdo al tipo de valor definido:

```sql

UPDATE Student
SET 
    schoolsup = CASE 
        WHEN LEFT(schoolsup, 1) = 'y' THEN TRUE
        WHEN LEFT(schoolsup, 1) = 'n' THEN FALSE
        ELSE schoolsup
    END,
    
    famsup = CASE 
        WHEN LEFT(famsup, 1) = 'y' THEN TRUE
        WHEN LEFT(famsup, 1) = 'n' THEN FALSE
        ELSE famsup
    END,

    paid = CASE 
        WHEN LEFT(paid, 1) = 'y' THEN TRUE
        WHEN LEFT(paid, 1) = 'n' THEN FALSE
        ELSE paid
    END,

    activities = CASE 
        WHEN LEFT(activities, 1) = 'y' THEN TRUE
        WHEN LEFT(activities, 1) = 'n' THEN FALSE
        ELSE activities
    END,

    nursery = CASE 
        WHEN LEFT(nursery, 1) = 'y' THEN TRUE
        WHEN LEFT(nursery, 1) = 'n' THEN FALSE
        ELSE nursery
    END,

    higher = CASE 
        WHEN LEFT(higher, 1) = 'y' THEN TRUE
        WHEN LEFT(higher, 1) = 'n' THEN FALSE
        ELSE higher
    END,

    internet = CASE 
        WHEN LEFT(internet, 1) = 'y' THEN TRUE
        WHEN LEFT(internet, 1) = 'n' THEN FALSE
        ELSE internet
    END,

    romantic = CASE 
        WHEN LEFT(romantic, 1) = 'y' THEN TRUE
        WHEN LEFT(romantic, 1) = 'n' THEN FALSE
        ELSE romantic
    END;

```

---

### Subconsultas interesantes

***¿Quién es el estudiante con mejor promedio final en cada materia, dentro de cada escuela?***

```sql

SELECT 
    s.school_id,
    sc.name AS school_name,
    g.course_id,
    c.name AS course_name,
    s.student_id,
    ROUND((g.G1 + g.G2 + g.G3)/3.0, 2) AS final_grade
FROM Grades g
JOIN Student s ON g.student_id = s.student_id
JOIN School sc ON s.school_id = sc.school_id
JOIN Course c ON g.course_id = c.course_id
WHERE ROUND((g.G1 + g.G2 + g.G3)/3.0, 2) = (
    SELECT MAX(ROUND((g2.G1 + g2.G2 + g2.G3)/3.0, 2))
    FROM Grades g2
    JOIN Student s2 ON g2.student_id = s2.student_id
    WHERE s2.school_id = s.school_id
      AND g2.course_id = g.course_id
)
ORDER BY school_id, course_id;

```
| school_id | school_name           | course_id | course_name | student_id | final_grade |
|-----------|------------------------|-----------|--------------|-------------|--------------|
| GP        | Gabriel Pereira        | 1         | Math         | 2           | 16.67        |
| GP        | Gabriel Pereira        | 2         | Portuguese   | 11          | 15.67        |
| MS        | Mousinho da Silveira   | 1         | Math         | 183         | 16.67        |
| MS        | Mousinho da Silveira   | 2         | Portuguese   | 6           | 14.67        |



***¿Qué estudiante tiene más ausencias entre los que aprobaron el final (G3 ≥ 10) en ambos cursos?***

```sql

SELECT s.student_id, s.sex, s.age, s.absences
FROM Student s
WHERE s.student_id IN (
    SELECT DISTINCT student_id
    FROM Grades
    WHERE G3 >= 10
)
ORDER BY s.absences DESC
LIMIT 1;

```

| student_id | sex | age | absences |
|------------|-----|-----|----------|
| 123         | M   | 16  | 20       |


***¿Qué estudiante con promedio sobresaliente (>17) en el G3 (calificacion del examen final) tiene el mayor nivel de “goout” (frecuencia de salir con amigos)?***

```sql

SELECT 
    s.student_id, 
    s.sex, 
    s.age, 
    g.course_id,
    c.name AS course_name,
    g.G3, 
    s.goout
FROM Student s
JOIN Grades g ON s.student_id = g.student_id
JOIN Course c ON g.course_id = c.course_id
WHERE g.G3 > 17
ORDER BY s.goout ASC
LIMIT 1;


```

| student_id | sex | age | course_id | course_name | G3  | goout |
|------------|-----|-----|-----------|--------------|-----|--------|
| 94         | F   | 23  | 2         | Portuguese   | 19  | 4      |



