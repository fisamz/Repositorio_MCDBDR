# Tarea 1 (Base de Datos Relacionales)

## Descripción Base de Datos 

La base de datos con la que se va a trabajar se llama "Student Perfomance Dataset" obtenida desde el repositorio de Kaggle (https://www.kaggle.com/datasets/devansodariya/student-performance-data/data).

Esta base de datos se divide en 4 tablas relevantes para nuestro análisis:

### SCHOOL

| Variable   | Description                 | Type: Domain                   |
|------------|-----------------------------|---------------------------------|
| school_id  | School identifier            | string: {"GP", "MS"}           |
| name       | School name                  | string: {"Gabriel Pereira", "Mousinho da Silveira"} |


### STUDENT

| Variable    | Description                   | Type: Domain                   |
|-------------|-------------------------------|---------------------------------|
| student_id  | Student identifier             | int                            |
| school_id   | School the student belongs to   | string: {"GP", "MS"}           |
| sex         | Student sex                    | string: {"F", "M"}             |
| age         | Student age                    | int                            |
| address     | Student home address type       | string: {"U", "R"}             |
| famsize     | Family size                    | string: {"LE3", "GT3"}         |
| Pstatus     | Parent's cohabitation status    | string: {"T", "A"}             |
| Medu        | Mother's education level        | int: [0, 4]                    |
| Fedu        | Father's education level        | int: [0, 4]                    |
| Mjob        | Mother's job                    | string: {"teacher", "health", "services", "at_home", "other"} |
| Fjob        | Father's job                    | string: {"teacher", "health", "services", "at_home", "other"} |
| reason      | Reason to choose the school     | string: {"home", "reputation", "course", "other"} |
| guardian    | Student's guardian              | string: {"mother", "father", "other"} |
| traveltime  | Home to school travel time      | int: [1, 4]                    |
| studytime   | Weekly study time               | int: [1, 4]                    |
| failures    | Number of past class failures   | int: [0, 4]                    |
| schoolsup   | Extra educational support       | string: {"yes", "no"}          |
| famsup      | Family educational support      | string: {"yes", "no"}          |
| paid        | Extra paid classes (Math/Port.) | string: {"yes", "no"}          |
| activities  | Extra-curricular activities     | string: {"yes", "no"}          |
| nursery     | Attended nursery school         | string: {"yes", "no"}          |
| higher      | Wants to take higher education  | string: {"yes", "no"}          |
| internet    | Internet access at home         | string: {"yes", "no"}          |
| romantic    | With a romantic relationship    | string: {"yes", "no"}          |
| famrel      | Family relationship quality     | int: [1, 5]                    |
| freetime    | Free time after school          | int: [1, 5]                    |
| goout       | Going out with friends          | int: [1, 5]                    |
| Dalc        | Workday alcohol consumption     | int: [1, 5]                    |
| Walc        | Weekend alcohol consumption     | int: [1, 5]                    |
| health      | Current health status           | int: [1, 5]                    |
| absences    | Number of school absences       | int                            |


### COURSE

| Variable   | Description                 | Type: Domain                   |
|------------|-----------------------------|---------------------------------|
| course_id  | Course identifier            | int                            |
| school_id  | School offering the course    | string                         |
| name       | Course name                  | string: {"Math", "Portuguese"} |


### GRADES

| Variable    | Description                  | Type: Domain                   |
|-------------|------------------------------|---------------------------------|
| student_id  | Student who obtained the grade | int                            |
| course_id   | Course corresponding to the grade | int                         |
| G1          | First period grade            | int: [0, 20]                   |
| G2          | Second period grade           | int: [0, 20]                   |
| G3          | Final grade                   | int: [0, 20]                   |


## Notas importantes a considerar en nuestra base de datos:

- En el sistema educativo Portugues se maneja una escala 0-20 en las calificaciones, donde la calificación aprobatoria es 10 (50 en escala México). Se trabajarán los datos respetando este sistema de calificaciones, sin embargo, con fines meramente informativos se muestra a continuación una tabla de equivalencias entre el sistema de calificaciones portugués y mexicano.

| Nota Portugal (0-20) | Nota México (0-100) |
|---------------------|--------------------|
| 0 | 0 |
| 1 | 5 |
| 2 | 10 |
| 3 | 15 |
| 4 | 20 |
| 5 | 25 |
| 6 | 30 |
| 7 | 35 |
| 8 | 40 |
| 9 | 45 |
| 10 | 50 |
| 11 | 55 |
| 12 | 60 |
| 13 | 65 |
| 14 | 70 |
| 15 | 75 |
| 16 | 80 |
| 17 | 85 |
| 18 | 90 |
| 19 | 95 |
| 20 | 100 |


## SGBD

- [MySQL](https://www.mysql.com)
  - Muy usado en aplicaciones web (LAMP).
  - Compatible con Windows, Linux, MacOS.
  - Soporte para ACID, replicación, particionamiento.
  - Motores de almacenamiento: InnoDB, MyISAM, etc.

- [PostgreSQL](https://www.postgresql.org)
  - 100% open source y orientado a estándares SQL.
  - Soporte nativo para JSON, arrays, XML, GIS (PostGIS).
  - Manejo avanzado de concurrencia (MVCC).
  - Extensible: permite crear funciones, tipos y operadores personalizados.

- [Microsoft SQL Server](https://www.microsoft.com/sql-server)
  - Altamente integrado con herramientas Microsoft (Azure, .NET).
  - Motor híbrido OLTP/OLAP con soporte a big data.
  - Incluye SSMS (SQL Server Management Studio) para gestión visual.
  - Alto rendimiento en sistemas empresariales.

- [Oracle Database](https://www.oracle.com/database)
  - Sistema robusto para transacciones empresariales críticas.
  - Avanzadas opciones de replicación, clustering y seguridad.
  - Compatible con PL/SQL (lenguaje procedural propio).
  - Altamente optimizado para rendimiento en grandes volúmenes.

- [SQLite](https://www.sqlite.org)
  - Ligero, sin servidor, y embebido en una sola librería.
  - Muy usado en apps móviles (Android, iOS) y navegadores.
  - No requiere configuración ni instalación.
  - Velocidad excelente en entornos livianos.

  **El sistema que se usará en los próximos entregables será MySQL.**