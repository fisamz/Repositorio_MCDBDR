
DROP DATABASE IF EXISTS Tarea9;
CREATE DATABASE Tarea9;
USE Tarea9;


-- Borrar si existen
DROP TABLE IF EXISTS X;
DROP TABLE IF EXISTS Y;

-- Crear tabla X
CREATE TABLE X (
  id INT PRIMARY KEY,
  val DECIMAL(5,2) -- horas estudiadas
);

-- Crear tabla Y
CREATE TABLE Y (
  id INT PRIMARY KEY,
  val DECIMAL(5,2) -- calificación
);

-- Insertar valores en X
INSERT INTO X (id, val) VALUES
(1, 1.0),
(2, 2.0),
(3, 3.0),
(4, 4.0),
(5, 5.0),
(6, 6.0),
(7, 7.0);

-- Insertar valores en Y
INSERT INTO Y (id, val) VALUES
(1, 2.0),
(2, 3.8),
(3, 5.0),
(4, 6.2),
(5, 7.9),
(6, 9.1),
(7, 10.0);

SELECT 
  X.id,
  X.val AS X,
  Y.val AS Y
FROM X
JOIN Y ON X.id = Y.id;


-- Correlación

DROP PROCEDURE IF EXISTS calcular_correlacion;
DELIMITER //

CREATE PROCEDURE calcular_correlacion(OUT resultado DECIMAL(10,5))
BEGIN
  DECLARE media_x DECIMAL(10,5);
  DECLARE media_y DECIMAL(10,5);
  DECLARE suma_prod DECIMAL(10,5);
  DECLARE suma_x2 DECIMAL(10,5);
  DECLARE suma_y2 DECIMAL(10,5);

  SELECT AVG(val) INTO media_x FROM X;
  SELECT AVG(val) INTO media_y FROM Y;

  SELECT 
    SUM((X.val - media_x) * (Y.val - media_y)),
    SUM(POW(X.val - media_x, 2)),
    SUM(POW(Y.val - media_y, 2))
  INTO 
    suma_prod, suma_x2, suma_y2
  FROM X
  JOIN Y ON X.id = Y.id;

  -- Calcular la correlación
  SET resultado = suma_prod / (SQRT(suma_x2) * SQRT(suma_y2));
END //

DELIMITER ;

CALL calcular_correlacion(@r);
SELECT @r AS correlacion;



DROP PROCEDURE IF EXISTS regresion_lineal;
DELIMITER //

CREATE PROCEDURE regresion_lineal(
  OUT beta_0 DECIMAL(10,5),
  OUT beta_1 DECIMAL(10,5)
)
BEGIN
  DECLARE media_x DECIMAL(10,5);
  DECLARE media_y DECIMAL(10,5);
  DECLARE suma_xy DECIMAL(10,5);
  DECLARE suma_x2 DECIMAL(10,5);

  -- Calcular medias
  SELECT AVG(val) INTO media_x FROM X;
  SELECT AVG(val) INTO media_y FROM Y;

  -- Calcular numerador y denominador para beta_1
  SELECT 
    SUM((X.val - media_x) * (Y.val - media_y)),
    SUM(POW(X.val - media_x, 2))
  INTO 
    suma_xy, suma_x2
  FROM X
  JOIN Y ON X.id = Y.id;

  -- Calcular pendiente y ordenada al origen
  SET beta_1 = suma_xy / suma_x2;
  SET beta_0 = media_y - beta_1 * media_x;
END //

DELIMITER ;

CALL regresion_lineal(@b0, @b1);
SELECT @b0 AS beta_0, @b1 AS beta_1;


