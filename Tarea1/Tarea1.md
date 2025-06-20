# Tarea 1 (Base de Datos Relacionales)

## Descripción Base de Datos 

La base de datos con la que se va a trabajar se llama "Stress and Sleep Patterns" obtenida desde el repositorio de Kaggle (https://www.kaggle.com/datasets/orvile/stress-and-sleep-patterns)


La base de datos consta de 116 registros obtenidos mediante encuestas. En cada encuesta se pregunta la siguiente información (tipo de variable):

- **(Categorica Nominal)** Gender
- **(Numerica)** Age
- **(Categorica Nominal)** Your major
- **(Binaria)** Have you ever been diagnosed with a mental health condition by a professional (doctor, therapist, etc.)?
- **(Binaria)** Have you ever received treatment/support for a mental health problem?
- **(Categorica Nominal)** When have you usually gone to bed in the past month?
- **(Categorica Nominal)** How long has it taken you to fall asleep each night in the past month?
- **(Categorica Nominal)** What time have you usually gotten up in the morning in the past month?
- **(Categorica Nominal)** How many hours of actual sleep did you get on an average for the past month? (maybe different from the number of hours spent in bed)
- **(Categorica Ordinal)** During the past month, how often have you had trouble sleeping because you: (choose an option that indicate the most accurate reply for the majority of days and nights in the past month) [Cannot get to sleep within 30 minutes]
- **(Categorica Ordinal)** During the past month, how often have you had trouble sleeping because you: (choose an option that indicate the most accurate reply for the majority of days and nights in the past month) [Wake up in the middle of the night or early morning]
- **(Categorica Ordinal)** During the past month, how often have you had trouble sleeping because you: (choose an option that indicate the most accurate reply for the majority of days and nights in the past month) [Have to get up to use the bathroom]
- **(Categorica Ordinal)** During the past month, how often have you had trouble sleeping because you: (choose an option that indicate the most accurate reply for the majority of days and nights in the past month) [Cough or snore loudly]
- **(Categorica Ordinal)** During the past month, how often have you had trouble sleeping because you: (choose an option that indicate the most accurate reply for the majority of days and nights in the past month) [Feel too cold]
- **(Categorica Ordinal)** During the past month, how often have you had trouble sleeping because you: (choose an option that indicate the most accurate reply for the majority of days and nights in the past month) [Feel too hot]
- **(Categorica Ordinal)** During the past month, how often have you had trouble sleeping because you: (choose an option that indicate the most accurate reply for the majority of days and nights in the past month) [Have bad dreams]
- **(Categorica Ordinal)** During the past month, how often have you had trouble sleeping because you: (choose an option that indicate the most accurate reply for the majority of days and nights in the past month) [Have pain]
- **(Categorica Ordinal)** What is your stress level in these given situations: 
  - [You have to submit an assignment in less than a day]
  - [A week before exams]
  - [Asking for an extra ketchup packet at a restaurant]
  - [Meeting a new person ]
  - [Asking for help]
  - [Confronting someone]
  - [Doing something without help]


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

  **El sistema que usaremos será MySQL.**