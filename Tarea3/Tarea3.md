# Tarea 3 (Base de Datos Relacionales)

## Modelo Relacional

### School →
School(**school_id** (PK), name)

### Student →

Student(**student_id** (PK), sex, age, address, famsize, Pstatus, Medu, Fedu, Mjob, Fjob, guardian, traveltime, studytime, failures, schoolsup, famsup, paid, activities, nursery, higher, internet, romantic, famrel, freetime, goout, Dalc, Walc, health, absences, school_id (FK) )

### Course →

Course(**course_id** (PK), name )

### Grades (tambien se le puede llamar Student_Course) →

Grades(**student_id** (FK), **course_id** (FK), G1, G2, G3 )

### Diagrama (Modelo Relacional)

![Modelo Relacional](Diagrama_Relacional.png)


**[Para conocer mas detalles de cada atributo, revisar Tarea 1.](../Tarea1/Tarea1.md)**
**[Para conocer el diagrama de entidad-relación, revisar Tarea 2.](../Tarea2/Tarea2.md)**