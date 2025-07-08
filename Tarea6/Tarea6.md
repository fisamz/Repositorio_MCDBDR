# Tarea 6 (Base de Datos Relacionales)

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

### Modificaciones a la base

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
X

---

### Conclusiones
X

---