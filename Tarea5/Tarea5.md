# Tarea 5 (Base de Datos Relacionales)

## Parte 1: Generación de Datos *(simulados con Mockaroo)*

Como parte 1 de la presente tarea, se utilizó **Mockaroo** como herramienta principal para la generación de datos sintéticos que permiten poblar las tablas que previamente diseñamos. Pueden conocer mas de las tablas que poblamos en: 

- [Diagrama Entidad - Relación](../Tarea2/Tarea2.md)
- [Modelo Relacional](../Tarea3/Tarea3.md)
- [SQL (CREATE TABLE)](../Tarea4/Tarea4.md)

En esta simulación no se consideran las tablas School y Courses, para estas tablas se mantienen los 2 registros agregados anteriormente, por otro lado, en las tabla Student se simulan los datos para 500 estudiantes, mientras que para Grades se simulan 100 registros de calificaciones. 

### Respecto a Mockaroo...

Mockaroo es una herramienta en línea que facilita la creación de datos ficticios de manera rápida y flexible. Permite definir los campos, tipos de datos, rangos y reglas básicas para la generación de registros, y exportarlos en distintos formatos como SQL, CSV, JSON, entre otros. Los siguientes puntos son algunos puntos relevantes a considerar al momento de usar esta plataforma:

- **Ventajas:**
  - Permite generar grandes volúmenes de datos en muy poco tiempo.
  - Ofrece una amplia variedad de tipos de datos predefinidos (números, fechas, nombres, direcciones, correos electrónicos, etc.).
  - Facilita la personalización mediante listas personalizadas, rangos numéricos y fórmulas básicas.
  - Exporta directamente en formatos como SQL, CSV, JSON, lo que simplifica la integración con bases de datos.
  - Es posible importar el CREATE TABLE de SQL para partir de una base al momento de crear el Schema (no aplica correctamente el dominio de los valores, hay que modificar manual).

- **Limitaciones y Dificultades:**
  - No permite definir condiciones avanzadas de generación, como limitar la cantidad de veces que un valor se puede repetir (por ejemplo en este ejercicio ningun alumno puede tomar el mismo curso 2 veces, sin embargo estas condiciones de conteo no es posible implementarlas).
  - Las fórmulas y lógica condicional son limitadas a expresiones sencillas y no soportan memoria entre registros (no es posible llevar un conteo global o histórico de los valores generados).

- **Recomendaciones:**
  - Para reglas complejas o condiciones de conteo, se recomienda complementar Mockaroo con un procesamiento posterior de los datos mediante scripts en lenguajes como Python o R.
  - Aprovechar la exportación en formato SQL para insertar los datos directamente en el SGBD y validar de inmediato su integridad.


## Parte 2: Funciones de agregación (SQL)
  
*Disclaimer: Los datos generados por Mockaroo generan problemas en la tabla Grades dado que hay registros que tienen el mismo school_id y course_id, lo cual genera problemas al ser su primary key, para ello se realiza un script para modificar los valores con problema y se modifica el student_id a otro que no cause problema en la incorporación en la base de datos (esta problematica se menciona anteriormente).*

Usando los datos generados en la parte 1 (ajustado la tabla Grades), se realizan las siguientes consultas de estadisticos:

### Conteo de frecuencias

*Conteo del numero de estudiantes por cada escuela.*
```sql

SELECT school_id, COUNT(*) AS total_estudiantes
FROM Student
GROUP BY school_id;

```

| school_id | total_estudiantes |
|------------|-----------------|
| GP         | 254               |
| MS         | 246               |

### Media

*Calificacion promedio en el G3 de todos los estudiantes que llevaron curso Math*
```sql

SELECT AVG(G3) AS promedio_G3_math
FROM Grades
WHERE course_id = 1;

```
**Resultado: 10.1489**

### Mínimos y Máximos

*Calificacion mas alta en el G3 independientemente del curso y escuela*
```sql

SELECT MAX(G3) AS max_G3
FROM Grades;

```
**Resultado: 20**

*Calificacion mas baja en math en el G3*
```sql

SELECT MIN(G1) AS min_G1_math
FROM Grades
WHERE course_id = 1;

```
**Resultado: 0**

### Cálculo de cuantiles

*Cálculo del primer cuartil (25%) y el tercer cuartil (75%) de todas las calificaciones en el Q3 sin hacer distinción por curso o escuela*
```sql

SET @offset_q1 = FLOOR((SELECT COUNT(*) FROM Grades) * 0.25 )-1;
SET @sql = CONCAT(
  'SELECT G3 FROM Grades ORDER BY G3 LIMIT 1 OFFSET ', @offset_q1
);

SELECT @offset_q1;

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET @offset_q3 = FLOOR((SELECT COUNT(*) FROM Grades) * 0.75 )-1;
SET @sql = CONCAT(
  'SELECT G3 FROM Grades ORDER BY G3 LIMIT 1 OFFSET ', @offset_q3
);

SELECT @offset_q3;

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

```

### Moda

*Cálculo de la moda de las calificaciones en el G1, G2 y G3 sin hacer distinción por curso o escuela*
```sql

(
  SELECT 'G1' AS periodo, G1 AS calificacion, COUNT(*) AS frecuencia
  FROM Grades
  GROUP BY G1
  ORDER BY frecuencia DESC
  LIMIT 1
)
UNION ALL
(
  SELECT 'G2' AS periodo, G2 AS calificacion, COUNT(*) AS frecuencia
  FROM Grades
  GROUP BY G2
  ORDER BY frecuencia DESC
  LIMIT 1
)
UNION ALL
(
  SELECT 'G3' AS periodo, G3 AS calificacion, COUNT(*) AS frecuencia
  FROM Grades
  GROUP BY G3
  ORDER BY frecuencia DESC
  LIMIT 1
);


```

| periodo | moda | frecuencia |
|---------|--------------|------------|
| G1      | 1            | 9          |
| G2      | 16           | 8          |
| G3      | 11           | 9          |


## Hallazgos y dificultades

- Se identificó que algunas funciones avanzadas de MySQL, como `PERCENTILE_CONT`, no estaban disponibles en la versión del servidor utilizada. Esto obligó a buscar soluciones alternativas para el cálculo de cuantiles, como ordenar los datos y utilizar `LIMIT OFFSET` para seleccionar el valor en la posición correspondiente.
- El uso de variables como `@offset_q1` no fue aceptado directamente dentro de `LIMIT OFFSET`, por lo que se consideró el uso de queries dinámicos con `PREPARE` y `EXECUTE`.
- Para la moda fue posible obtener el valor más frecuente mediante `GROUP BY` y `ORDER BY`, pero si hubiera habido empate en la frecuencia máxima, la consulta actual solo devuelve uno de los valores. Esto es una limitación conocida de `LIMIT 1`.

