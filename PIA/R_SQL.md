Untitled
================

## 1) Librerias necesarias para la conexión

``` r
library(DBI) 
library(RMariaDB)
```

## 2) Conexión a una base de datos de MySQL desde R

``` r
con <- dbConnect(
  RMariaDB::MariaDB(),
  host     = "localhost",
  port     = 3306,
  user     = "root",
  password = rstudioapi::askForPassword("MySQL password"),
  dbname   = "STUDENTS_PERFORMANCE_DB"
)
```

## 3) Revisar las tablas existentes en la base de datos asi como los atributos de cada tabla:

``` r
dbListTables(con) #Revisa tablas en la base de datos
```

    ## [1] "Course"  "Grades"  "School"  "Student"

``` r
dbListFields(con, "Grades") #Revisa los atributos de una de las tablas
```

    ## [1] "student_id" "course_id"  "G1"         "G2"         "G3"

## 4) Consulta a la base de datos manteniendo el languaje SQL:

``` r
dbReadTable(con, "School") #Extrae todos los datos de una de las tablas
```

    ##   school_id                 name
    ## 1        GP      Gabriel Pereira
    ## 2        MS Mousinho da Silveira

``` r
califs <- dbGetQuery(con, "SELECT * FROM Grades")

califs
```

    ##    student_id course_id G1 G2 G3
    ## 1           1         1  5  6  6
    ## 2           1         2  0 11 11
    ## 3           2         1  5  5  6
    ## 4           2         2  9 11 11
    ## 5           3         1  7  8 10
    ## 6           3         2 12 13 12
    ## 7           4         1 15 14 15
    ## 8           4         2 14 14 14
    ## 9           5         1  6 10 10
    ## 10          5         2 11 13 13

``` r
res <- dbGetQuery(con, "
  SELECT student_id, course_id, G3
  FROM Grades
  WHERE G3 > 0
  LIMIT 50
")

res
```

    ##    student_id course_id G3
    ## 1           1         1  6
    ## 2           1         2 11
    ## 3           2         1  6
    ## 4           2         2 11
    ## 5           3         1 10
    ## 6           3         2 12
    ## 7           4         1 15
    ## 8           4         2 14
    ## 9           5         1 10
    ## 10          5         2 13

## 5) Creación de tablas

``` r
df <- data.frame(
  name = c("Ana", "Luis", "María"),
  score = c(10, 11, 12)
)

dbWriteTable(
  con,
  "scores",
  df,
  overwrite = TRUE,
  field.types = c(name = "VARCHAR(20)", score = "INT")
)

new_df <- data.frame(
  name = c("Carlos", "Elena"),
  score = c(88, 95)
)

dbWriteTable(con, "scores", new_df, append = TRUE)
#Aquí usamos append = TRUE para añadir filas sin eliminar lo ya existente
```

## 6) Creación de tablas

``` r
# Verifica que la tabla existe, en caso de que si, borrarla

if ( dbExistsTable(con, "scores") == TRUE) { dbRemoveTable(con, "scores") }
```

## 7) Uso de dplyr para consultas

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(dbplyr)
```

    ## 
    ## Attaching package: 'dbplyr'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     ident, sql

``` r
grades_tbl <- tbl(con, "Grades")

grades_high <- grades_tbl %>%
  filter(G3 > 0) %>%
  select(student_id, course_id, G3) %>%
  collect()

head(grades_high)
```

    ## # A tibble: 6 × 3
    ##   student_id course_id    G3
    ##        <int>     <int> <int>
    ## 1          1         1     6
    ## 2          1         2    11
    ## 3          2         1     6
    ## 4          2         2    11
    ## 5          3         1    10
    ## 6          3         2    12

## 9) Importante al final, desconectar la sesión

``` r
  dbDisconnect(con)
```
