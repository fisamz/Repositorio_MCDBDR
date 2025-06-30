# Tarea 1 (Base de Datos Relacionales)

## Descripción Base de Datos 

La base de datos con la que se va a trabajar se llama "Student Perfomance Dataset" obtenida desde el repositorio de Kaggle (https://www.kaggle.com/datasets/devansodariya/student-performance-data/data).

Esta base de datos consta de 2 tablas, ambas tablas contienen una muestra de estudiantes de 2 escuelas en Portugal, sin embargo una tabla muestra las calificaciones de cada estudiante en un curso de matemáticas mientras que la otra muestra las calificaciones en un curso de Portugues. 

Para cada tabla se obtiene la siguiente información para cada estudiante:

|  | Variable | Description | Type: Domain |
|--|----------|-------------|--------------|
| 1 | school | student's school | binary: "GP" - Gabriel Pereira or "MS" - Mousinho da Silveira |
| 2 | sex | student's sex | binary: "F" - female or "M" - male |
| 3 | age | student's age | numeric: from 15 to 22 |
| 4 | address | student's home address type | binary: "U" - urban or "R" - rural |
| 5 | famsize | family size | binary: "LE3" - less or equal to 3 or "GT3" - greater than 3 |
| 6 | Pstatus | parent's cohabitation status | binary: "T" - living together or "A" - apart |
| 7 | Medu | mother's education | numeric: 0 - none, 1 - primary education (4th grade), 2 – 5th to 9th grade, 3 – secondary education or 4 – higher education |
| 8 | Fedu | father's education | numeric: 0 - none, 1 - primary education (4th grade), 2 – 5th to 9th grade, 3 – secondary education or 4 – higher education |
| 9 | Mjob | mother's job | nominal: "teacher", "health" care related, civil "services" (e.g. administrative or police), "at_home" or "other" |
| 10 | Fjob | father's job | nominal: "teacher", "health" care related, civil "services" (e.g. administrative or police), "at_home" or "other" |
| 11 | reason | reason to choose this school | nominal: close to "home", school "reputation", "course" preference or "other" |
| 12 | guardian | student's guardian | nominal: "mother", "father" or "other" |
| 13 | traveltime | home to school travel time | numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour |
| 14 | studytime | weekly study time | numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours |
| 15 | failures | number of past class failures | numeric: n if 1<=n<3, else 4 |
| 16 | schoolsup | extra educational support | binary: yes or no |
| 17 | famsup | family educational support | binary: yes or no |
| 18 | paid | extra paid classes within the course subject | binary: yes or no |
| 19 | activities | extra-curricular activities | binary: yes or no |
| 20 | nursery | attended nursery school | binary: yes or no |
| 21 | higher | wants to take higher education | binary: yes or no |
| 22 | internet | Internet access at home | binary: yes or no |
| 23 | romantic | with a romantic relationship | binary: yes or no |
| 24 | famrel | quality of family relationships | numeric: from 1 - very bad to 5 - excellent |
| 25 | freetime | free time after school | numeric: from 1 - very low to 5 - very high |
| 26 | goout | going out with friends | numeric: from 1 - very low to 5 - very high |
| 27 | Dalc | workday alcohol consumption | numeric: from 1 - very low to 5 - very high |
| 28 | Walc | weekend alcohol consumption | numeric: from 1 - very low to 5 - very high |
| 29 | health | current health status | numeric: from 1 - very bad to 5 - very good |
| 30 | absences | number of school absences | numeric: from 0 to 93 |
| 31 | G1 | first period grade | numeric: from 0 to 20 |
| 32 | G2 | second period grade | numeric: from 0 to 20 |
| 33 | G3 | final grade | numeric: from 0 to 20, output target |

## Notas importantes a considerar en nuestra base de datos:

- Cada tabla de nuestra base de datos muestra las calificaciones de primer periodo, segundo periodo y finales (columnas 31-33) para el curso en cuestión. 
- La columna 1 muestra la escuela a la que pertenece el alumno ya sea el colegio Gabriel Pereira (GP) o Mousinho da Silveira (MS), un alumno de cierta escuela puede pertenecer a ambas muestras dado que un alumno que estudia en el colegia Gabriel Pereira puede haber tomado un curso de matemáticas y uno de portugués. En esta base de datos hay una cantidad de 382 alumnos que sus datos fueron recabados para alimentar ambas tablas.
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