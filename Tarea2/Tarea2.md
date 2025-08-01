# Tarea 2 (Base de Datos Relacionales)

## Modelo Entidad - Relación

El siguiente modelo entidad-relación describe la estructura de la base de datos diseñada para gestionar información de escuelas, estudiantes, cursos y calificaciones.

El modelo describe las entidades principales, sus atributos y las relaciones entre ellas, considerando las claves primarias, claves foráneas y dominios de los atributos. Este diseño busca garantizar la integridad de los datos y facilitar consultas relacionadas con estudiantes, escuelas, cursos y calificaciones.

### Diagrama Entidad-Relación

![Modelo ER Parte 1](MODELOER_P1_v2.png)

#### Atributos de la Entidad "Student"

![Modelo ER Parte 2](MODELOER_P2.png)

## Descripción general

- **SCHOOL**: Representa las escuelas. Cada escuela tiene un identificador y un nombre.  
- **STUDENT**: Contiene los datos de los estudiantes y su relación con la escuela a la que pertenecen.  
- **COURSE**: Incluye los cursos ofrecidos.  
- **GRADES**: Almacena las calificaciones de los estudiantes en los diferentes cursos.

El modelo incluye las siguientes relaciones:
- N estudiantes pertenecen a una escuela (N:1).
- N calificaciones (grades) pertenecen a 1 estudiante (student) (N:1).
- Las calificaciones relacionan a estudiantes con cursos (N:N resuelto mediante la entidad GRADES).

---

**[Para conocer mas detalles de cada atributo, revisar Tarea 1.](../Tarea1/Tarea1.md)**