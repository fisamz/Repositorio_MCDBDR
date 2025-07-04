# Tarea 3 (Base de Datos Relacionales)

## Modelo Relacional

### School →

School(**school_id** (PK), name)

---

### Student →

Student(**student_id** (PK), sex, age, address, famsize, Pstatus, Medu, Fedu, Mjob, Fjob, guardian, traveltime, studytime, failures, schoolsup, famsup, paid, activities, nursery, higher, internet, romantic, famrel, freetime, goout, Dalc, Walc, health, absences, school_id (FK) )

---

### Course →

Course(**course_id** (PK), name )

---

### Grades (tambien se le puede llamar Student_Course) →

Grades(**student_id** (FK), **course_id** (FK), G1, G2, G3 )

---

### Diagrama (Modelo Relacional)

![Modelo Relacional](Diagrama_Relacional.png)


**- [Revisar Tarea 1 para conocer mas detalles de cada atributo.](../Tarea1/Tarea1.md)**  

**- [Revisar Tarea 2 para observar el diagrama entidad-relación de este conjunto de datos.](../Tarea2/Tarea2.md)**  

---

### Operaciones Álgebra Relacional

**1- Selección (σ)**: σ absences > 10 (Student)

*Esta operación selecciona a todos los estudiantes que tienen más de 10 faltas con lo cual podríamos analizar el nivel de ausentismo.*

**2- Proyección (π)**: π student_id, age (Student)

*Esta operación devuelve una relación que contiene solo el student_id y el age de los estudiantes.*

**3- Join natural (⨝)**: Student ⨝ Student.school_id = School.school_id School

*Esta operación combina la tabla Student con School uniendo las filas que tienen el mismo school_id, con lo cual se logra añadir el name de la escuela en la tabla de Student.*

**4- Interseccion (∩)**: (π student_id (σ name = 'Math' (Course) ⨝ Course.course_id = Grades.course_id Grades)) ∩ (π student_id (σ name = 'Portuguese' (Course) ⨝ Course.course_id = Grades.course_id Grades))

*Esta operación obtiene los student_id de los estudiantes que han cursado Math y los estudiantes que han cursado Portuguese, al hacer la intercección entre estos 2 el resultante es los estudiantes que han cursado ambos cursos.*
