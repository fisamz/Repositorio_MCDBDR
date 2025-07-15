
library(DBI)
library(RMariaDB)
library(odbc)

con <- dbConnect(
  RMariaDB::MariaDB(),
  host     = "localhost",
  port     = 3306,
  user     = "root",
  password = rstudioapi::askForPassword("MySQL password"),
  dbname   = "STUDENTS_PERFORMANCE_DB"
)



dbListTables(con)
dbListFields(con, "Grades")


califs <- dbGetQuery(con, "
  SELECT * FROM Grades
")


dbReadTable(con, "Grades")



res <- dbGetQuery(con, "
  SELECT student_id, course_id, G3
  FROM Grades
  WHERE G3 > 0
  LIMIT 50
")
head(res)


library(dplyr)
library(dbplyr)


grades_tbl <- tbl(con, "Grades")

grades_high <- grades_tbl %>%
  filter(G3 > 0) %>%
  select(student_id, course_id, G3) %>%
  collect()

head(grades_high)

dbDisconnect(con)

grades_tbl <- tbl(con, "Grades")  # referencia en la base
filtered <- grades_tbl %>%
  filter(G3 > 80) %>%
  select(student_id, G3)

# No pasa nada aún, se guarda la consulta
df <- filtered %>% collect()  # aquí sí se ejecuta y trae datos



# Defino un pequeño data.frame de ejemplo
df <- data.frame(
  name = c("Ana", "Luis", "María"),
  score = c(85, 92, 78)
)

# Si la tabla "scores" NO existe en la BD:
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

# Supongamos que tienes conexión 'con' ya establecida

# Verifica que la tabla existe:
dbExistsTable(con, "scores")
#> TRUE

# Borra la tabla:
dbRemoveTable(con, "scores")  # devuelve TRUE invisiblemente

# Ahora:
dbExistsTable(con, "scores")

## 8) Dentro de un R Notebook es posible tener un bloque de consulta en SQL y el resultado guardarlo en un dataframe para su posterior manejo

```{sql, connection=con, output.var = "mydataframe"}

SELECT student_id, course_id, G3
FROM Grades
WHERE G3 > 0
LIMIT 50

```


