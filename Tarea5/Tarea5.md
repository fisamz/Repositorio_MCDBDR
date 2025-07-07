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

```sql

SELECT school_id, COUNT(*) AS total_estudiantes
FROM Student
GROUP BY school_id;

```

Resultado: El conteo de estudiantes separados por cada escuela.

| school_id | total_estudiantes |
|------------|-----------------|
| GP         | 254               |
| MS         | 246               |