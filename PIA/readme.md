# Universidad Autonoma de Nuevo Leon
## Facultad de Ciencias Físico Matemáticas - Maestría en Ciencia de Datos

### Proyecto Integrador de Aprendizaje: Conectividad R <-> MySQL

Objetivos
- Establecer una conexión segura entre R y MySQL a través de librerias como DBI y RMariaDB.
- Leer, escribir y manipular datos desde R usando funciones como dbGetQuery(), dbWriteTable(), dbReadTable() y dbRemoveTable().
- Optimizar consultas empleando el paquete dbplyr, para realizar operaciones con sintaxis dplyr pero ejecutadas directamente en la base de datos.
- Gestionar el ciclo completo de vida de los datos: creación de tablas, inserción y modificación de registros, eliminación y limpieza de tablas.
- Explorar las ventajas que conlleva realizar consultas SQL desde R al complementar con otros paquetes de visualización de datos como ggplot, flextable, etc. 

Existen distintas formas 


PIA/                          <- raíz del proyecto
├── 01_introduccion/         <- documentación, readme, objetivos
│   └── readme.md
│
├── 02_ejemplos_notebook/    <- ejemplos en notebooks
│   ├── ejemplo_dbGetQuery.Rmd
│   └── ejemplo_dbplyr.Rmd
│
├── 03_subconsultas_plots/   <- análisis con subconsultas y gráficos/tablas
│   ├── subconsulta_1.Rmd
│   └── subconsulta_2.Rmd
│
├── data/                    <- si incluyes datos de muestra o SQL de ejemplo
│   └── consulta_ejemplo.sql
│
└── .gitignore




Material de interes:
- https://solutions.posit.co/connections/db/getting-started/database-queries/
- https://rpubs.com/nwstephens/318586
- https://solutions.posit.co/connections/db/r-packages/dbi/
- https://solutions.posit.co/connections/db/r-packages/dplyr/
- https://solutions.posit.co/connections/db/databases/my-sql/index.html#using-the-rmariadb-package



