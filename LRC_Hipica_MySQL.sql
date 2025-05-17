-- Eliminar la base de datos si existe
DROP DATABASE IF EXISTS LRC_Hipica;

-- Crear la base de datos
CREATE DATABASE LRC_Hipica CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE LRC_Hipica;

-- Tabla CCAA
CREATE TABLE CCAA (
    ID_CCAA INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100)
);

-- Tabla Provincias
CREATE TABLE Provincias (
    ID_Provincia INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    IDCCAA INT,
    FOREIGN KEY (IDCCAA) REFERENCES CCAA(ID_CCAA)
);

-- Tabla Localidades
CREATE TABLE Localidades (
    ID_Localidad INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    IDProvincia INT,
    FOREIGN KEY (IDProvincia) REFERENCES Provincias(ID_Provincia)
);

-- Tabla Clientes
CREATE TABLE Clientes (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    DNI VARCHAR(20),
    Nombre VARCHAR(100),
    Direccion VARCHAR(200),
    IDLocalidad INT,
    Email VARCHAR(100),
    Movil VARCHAR(20),
    IBAN VARCHAR(50),
    F_alta DATE,
    F_baja DATE,
    Tipo VARCHAR(50), -- 'Estudiante', 'Propietario', 'Ambos'
    FOREIGN KEY (IDLocalidad) REFERENCES Localidades(ID_Localidad)
);

-- Tabla Caballos
CREATE TABLE Caballos (
    ID_Caballo INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Raza VARCHAR(100),
    Edad INT,
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Tabla Empleados
CREATE TABLE Empleados (
    ID_Empleado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Direccion VARCHAR(200),
    IDLocalidad INT,
    DNI VARCHAR(20),
    Salario DECIMAL(10, 2),
    Tipo VARCHAR(50), -- 'Cuidador', 'Profesor', 'Administrativo'
    FOREIGN KEY (IDLocalidad) REFERENCES Localidades(ID_Localidad)
);

-- Tabla Metodo_Pago
CREATE TABLE Metodo_Pago (
    ID_Metodo INT AUTO_INCREMENT PRIMARY KEY,
    Metodo VARCHAR(50) -- 'Efectivo', 'Tarjeta', 'Transferencia'
);

-- Tabla Clases
CREATE TABLE Clases (
    ID_Clase INT AUTO_INCREMENT PRIMARY KEY,
    Estudiantes_ID_Cliente INT,
    Profesor_ID_Empleado INT,
    F_inicio DATE,
    F_fin DATE,
    FOREIGN KEY (Estudiantes_ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (Profesor_ID_Empleado) REFERENCES Empleados(ID_Empleado)
);

-- Tabla Pupilaje
CREATE TABLE Pupilaje (
    ID_Pupilaje INT AUTO_INCREMENT PRIMARY KEY,
    Cuidador_ID_Empleado INT,
    Caballos_ID_Caballo INT,
    Box INT,
    F_inicio DATE,
    F_fin DATE,
    FOREIGN KEY (Cuidador_ID_Empleado) REFERENCES Empleados(ID_Empleado),
    FOREIGN KEY (Caballos_ID_Caballo) REFERENCES Caballos(ID_Caballo)
);

-- Tabla Cobros_clases
CREATE TABLE Cobros_clases (
    ID_Cobro INT AUTO_INCREMENT PRIMARY KEY,
    ID_Metodo INT,
    Monto DECIMAL(10, 2),
    Fecha_Cobro DATE,
    Estado VARCHAR(50), -- 'Pagado', 'Pendiente'
    ID_Clase INT,
    FOREIGN KEY (ID_Metodo) REFERENCES Metodo_Pago(ID_Metodo),
    FOREIGN KEY (ID_Clase) REFERENCES Clases(ID_Clase)
);

-- Tabla Cobros_pupilaje
CREATE TABLE Cobros_pupilaje (
    ID_Cobro INT AUTO_INCREMENT PRIMARY KEY,
    ID_Metodo INT,
    Monto DECIMAL(10, 2),
    Fecha_Cobro DATE,
    Estado VARCHAR(50), -- 'Pagado', 'Pendiente'
    ID_Pupilaje INT,
    FOREIGN KEY (ID_Metodo) REFERENCES Metodo_Pago(ID_Metodo),
    FOREIGN KEY (ID_Pupilaje) REFERENCES Pupilaje(ID_Pupilaje)
);

-- Tabla Nominas
CREATE TABLE Nominas (
    ID_Nomina INT AUTO_INCREMENT PRIMARY KEY,
    ID_Empleado INT,
    Periodo_Inicio DATE,
    Periodo_Fin DATE,
    Monto DECIMAL(10, 2),
    Fecha_Pago DATE,
    Estado VARCHAR(50), -- 'Pagado', 'Pendiente'
    FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado)
);

-- 2. Insertar datos en CCAA
INSERT INTO CCAA (Nombre) VALUES ('Galicia');

-- 3. Insertar Provincias
INSERT INTO Provincias (Nombre, IDCCAA) VALUES ('A Coruña', 1);

-- 4. Insertar Localidades
INSERT INTO Localidades (Nombre, IDProvincia) VALUES
('A Coruña', 1),
('Arteixo', 1),
('Oleiros', 1),
('Culleredo', 1),
('Sada', 1),
('Cambre', 1),
('Betanzos', 1);

-- 5. Generar 200 clientes
DELIMITER $$
CREATE PROCEDURE insertar_clientes()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 200 DO
    INSERT INTO Clientes (DNI, Nombre, Direccion, IDLocalidad, Email, Movil, IBAN, F_alta, F_baja, Tipo)
    VALUES (
      CONCAT('DNI', LPAD(i, 8, '0')),
      CONCAT('Cliente', i),
      CONCAT('Calle Cliente ', i, ' Nº', FLOOR(RAND()*100 + 1)),
      FLOOR(RAND()*7 + 1),
      CONCAT('cliente', i, '@example.com'),
      CONCAT('6', LPAD(i, 8, '0')),
      CONCAT('ES', LPAD(i, 20, '0')),
      DATE_SUB('2020-01-01', INTERVAL FLOOR(RAND()*1825) DAY),
      IF(i % 20 = 0, DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY), NULL),
      CASE 
        WHEN i % 3 = 0 THEN 'Estudiante'
        WHEN i % 3 = 1 THEN 'Propietario'
        ELSE 'Ambos'
      END
    );
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insertar_clientes();
DROP PROCEDURE insertar_clientes;

-- 6. Generar 30 caballos
DELIMITER $$
CREATE PROCEDURE insertar_caballos()
BEGIN
  DECLARE j INT DEFAULT 1;
  DECLARE razas JSON;
  SET razas = JSON_ARRAY('Pura Sangre', 'Árabe', 'Andaluz', 'Frisón', 'Appaloosa', 'Mustang', 'Shire');
  WHILE j <= 30 DO
    INSERT INTO Caballos (Nombre, Raza, Edad, ID_Cliente)
    VALUES (
      CONCAT('Caballo', j),
      JSON_UNQUOTE(JSON_EXTRACT(razas, CONCAT('$[', FLOOR(RAND()*7), ']'))),
      FLOOR(RAND()*15 + 3),
      FLOOR(RAND()*200 + 1)
    );
    SET j = j + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insertar_caballos();
DROP PROCEDURE insertar_caballos;

-- 7. Generar empleados (5 Admin, 10 Profesores, 15 Cuidadores)
DELIMITER $$
CREATE PROCEDURE insertar_empleados()
BEGIN
  DECLARE n INT DEFAULT 1;
  WHILE n <= 30 DO
    INSERT INTO Empleados (Nombre, Direccion, IDLocalidad, DNI, Salario, Tipo)
    VALUES (
      CONCAT('Empleado', n),
      CONCAT('Calle Empleado ', n),
      FLOOR(RAND()*7 + 1),
      CONCAT('E', LPAD(n, 7, '0')),
      CASE
        WHEN n <= 5 THEN 1500.00
        WHEN n <= 15 THEN 1500.00
        ELSE 1100.00
      END,
      CASE
        WHEN n <= 5 THEN 'Administrativo'
        WHEN n <= 15 THEN 'Profesor'
        ELSE 'Cuidador'
      END
    );
    SET n = n + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insertar_empleados();
DROP PROCEDURE insertar_empleados;

-- 8. Generar 1000 clases (solo Profesores)
DELIMITER $$
CREATE PROCEDURE insertar_clases()
BEGIN
  DECLARE cnt INT DEFAULT 1;
  DECLARE est INT;
  DECLARE prof INT;
  WHILE cnt <= 1000 DO
    SET est = (SELECT ID_Cliente FROM Clientes WHERE Tipo IN ('Estudiante', 'Ambos') ORDER BY RAND() LIMIT 1);
    SET prof = (SELECT ID_Empleado FROM Empleados WHERE Tipo='Profesor' ORDER BY RAND() LIMIT 1);
    SET @f_ini = DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND()*1825) DAY);
    INSERT INTO Clases (Estudiantes_ID_Cliente, Profesor_ID_Empleado, F_inicio, F_fin)
    VALUES (
      est,
      prof,
      @f_ini,
      DATE_ADD(@f_ini, INTERVAL 2 HOUR)
    );
    SET cnt = cnt + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insertar_clases();
DROP PROCEDURE insertar_clases;

-- 9. Generar 500 pupilajes
DELIMITER $$
CREATE PROCEDURE insertar_pupilaje()
BEGIN
  DECLARE cnt INT DEFAULT 1;
  DECLARE cuidador INT;
  DECLARE caballo INT;
  WHILE cnt <= 500 DO
    SET cuidador = (SELECT ID_Empleado FROM Empleados WHERE Tipo='Cuidador' ORDER BY RAND() LIMIT 1);
    SET caballo = (SELECT ID_Caballo FROM Caballos ORDER BY RAND() LIMIT 1);
    SET @f_ini = DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND()*1825) DAY);
    INSERT INTO Pupilaje (Cuidador_ID_Empleado, Caballos_ID_Caballo, Box, F_inicio, F_fin)
    VALUES (
      cuidador,
      caballo,
      FLOOR(RAND()*50 + 1),
      @f_ini,
      DATE_ADD(@f_ini, INTERVAL FLOOR(RAND()*180+30) DAY)
    );
    SET cnt = cnt + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insertar_pupilaje();
DROP PROCEDURE insertar_pupilaje;

-- 10 Insertar métodos de pago (si no existen)
INSERT IGNORE INTO Metodo_Pago (ID_Metodo, Metodo) VALUES (1, 'Efectivo'), (2, 'Tarjeta'), (3, 'Transferencia');

-- 11 Cobros_clases (solo IDs 1-3)
INSERT INTO Cobros_clases (ID_Metodo, Monto, Fecha_Cobro, Estado, ID_Clase)
SELECT 
  FLOOR(RAND()*3 + 1),
  FLOOR(RAND()*100 + 50),
  DATE_ADD(F_inicio, INTERVAL FLOOR(RAND()*30) DAY),
  IF(RAND() > 0.15, 'Pagado', 'Pendiente'),
  ID_Clase
FROM Clases;

-- 12 Cobros_pupilaje (mismo rango)
INSERT INTO Cobros_pupilaje (ID_Metodo, Monto, Fecha_Cobro, Estado, ID_Pupilaje)
SELECT
  FLOOR(RAND()*3 + 1),
  FLOOR(RAND()*500 + 300),
  DATE_ADD(F_inicio, INTERVAL FLOOR(RAND()*30) DAY),
  IF(RAND() > 0.2, 'Pagado', 'Pendiente'),
  ID_Pupilaje
FROM Pupilaje;

-- 13. Generar nóminas 2020-2025 (mensual para cada empleado)
DELIMITER $$
CREATE PROCEDURE insertar_nominas()
BEGIN
  DECLARE fecha DATE DEFAULT '2020-01-01';
  WHILE fecha <= '2025-12-31' DO
    INSERT INTO Nominas (ID_Empleado, Periodo_Inicio, Periodo_Fin, Monto, Fecha_Pago, Estado)
    SELECT
      ID_Empleado,
      fecha,
      LAST_DAY(fecha),
      Salario,
      LAST_DAY(fecha),
      'Pagado'
    FROM Empleados;
    SET fecha = DATE_ADD(fecha, INTERVAL 1 MONTH);
  END WHILE;
END$$
DELIMITER ;
CALL insertar_nominas();
DROP PROCEDURE insertar_nominas;
