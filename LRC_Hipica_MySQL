-- Eliminar la base de datos si existe
--DROP DATABASE IF EXISTS LRC_Hipica;

-- Crear la base de datos
--CREATE DATABASE LRC_Hipica;

-- Seleccionar la base de datos
--USE LRC_Hipica;

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

-- Crear la tabla Nominas
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

-- Insertar datos en CCAA
INSERT INTO CCAA (Nombre) VALUES ('Galicia');

-- Insertar Provincias
INSERT INTO Provincias (Nombre, IDCCAA) VALUES ('A Coruna', 1);

-- Insertar Localidades
INSERT INTO Localidades (Nombre, IDProvincia) VALUES 
('A Coruna', 1),
('Arteixo', 1),
('Oleiros', 1),
('Culleredo', 1),
('Sada', 1),
('Cambre', 1),
('Betanzos', 1);

-- Generar 200 clientes
DELIMITER //
CREATE PROCEDURE GenerarClientes()
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
            CASE WHEN i % 20 = 0 THEN DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY) ELSE NULL END,
            CASE 
                WHEN i % 3 = 0 THEN 'Estudiante' 
                WHEN i % 3 = 1 THEN 'Propietario' 
                ELSE 'Ambos' 
            END
        );
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL GenerarClientes();
DROP PROCEDURE GenerarClientes;

-- Generar 30 caballos
DELIMITER //
CREATE PROCEDURE GenerarCaballos()
BEGIN
    DECLARE j INT DEFAULT 1;
    DECLARE raza VARCHAR(50);
    DECLARE razas_array VARCHAR(255) DEFAULT 'Pura Sangre,Arabe,Andaluz,Frison,Appaloosa,Mustang,Shire';

    WHILE j <= 30 DO
        -- Seleccionar una raza aleatoria
        SET raza = ELT(FLOOR(RAND()*7 + 1), 'Pura Sangre', 'Arabe', 'Andaluz', 'Frison', 'Appaloosa', 'Mustang', 'Shire');

        INSERT INTO Caballos (Nombre, Raza, Edad, ID_Cliente)
        VALUES (
            CONCAT('Caballo', j),
            raza,
            FLOOR(RAND()*15 + 3),
            FLOOR(RAND()*200 + 1)
        );
        SET j = j + 1;
    END WHILE;
END //
DELIMITER ;

CALL GenerarCaballos();
DROP PROCEDURE GenerarCaballos;

-- Generar empleados (5 Admin, 10 Profesores, 15 Cuidadores)
DELIMITER //
CREATE PROCEDURE GenerarEmpleados()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE tipo VARCHAR(50);
    DECLARE salario DECIMAL(10, 2);
    
    WHILE i <= 30 DO
        IF i <= 5 THEN
            SET tipo = 'Administrativo';
            SET salario = 1500.00;
        ELSEIF i <= 15 THEN
            SET tipo = 'Profesor';
            SET salario = 1500.00;
        ELSE
            SET tipo = 'Cuidador';
            SET salario = 1100.00;
        END IF;
        
        INSERT INTO Empleados (Nombre, Direccion, IDLocalidad, DNI, Salario, Tipo)
        VALUES (
            CONCAT('Empleado', i),
            CONCAT('Calle Empleado ', i),
            FLOOR(RAND()*7 + 1),
            CONCAT('E', LPAD(i, 7, '0')),
            salario,
            tipo
        );
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL GenerarEmpleados();
DROP PROCEDURE GenerarEmpleados;

-- Insertar metodos de pago
INSERT INTO Metodo_Pago (Metodo) VALUES ('Efectivo'), ('Tarjeta'), ('Transferencia');

-- Generar 1000 clases (solo Profesores)
DELIMITER //
CREATE PROCEDURE GenerarClases()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE profesor_id INT;
    DECLARE estudiante_id INT;
    DECLARE fecha_inicio DATE;
    
    WHILE i <= 1000 DO
        -- Seleccionar un profesor aleatorio
        SELECT ID_Empleado INTO profesor_id
        FROM Empleados
        WHERE Tipo = 'Profesor'
        ORDER BY RAND()
        LIMIT 1;
        
        -- Seleccionar un estudiante aleatorio
        SELECT ID_Cliente INTO estudiante_id
        FROM Clientes
        WHERE Tipo IN ('Estudiante', 'Ambos')
        ORDER BY RAND()
        LIMIT 1;
        
        -- Generar fecha aleatoria
        SET fecha_inicio = DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 1825) DAY);
        
        INSERT INTO Clases (Estudiantes_ID_Cliente, Profesor_ID_Empleado, F_inicio, F_fin)
        VALUES (
            estudiante_id,
            profesor_id,
            fecha_inicio,
            DATE_ADD(fecha_inicio, INTERVAL 2 HOUR)
        );
        
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL GenerarClases();
DROP PROCEDURE GenerarClases;

-- Generar 500 pupilajes
DELIMITER //
CREATE PROCEDURE GenerarPupilajes()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE cuidador_id INT;
    DECLARE caballo_id INT;
    DECLARE fecha_inicio DATE;
    
    WHILE i <= 500 DO
        -- Seleccionar un cuidador aleatorio
        SELECT ID_Empleado INTO cuidador_id
        FROM Empleados
        WHERE Tipo = 'Cuidador'
        ORDER BY RAND()
        LIMIT 1;
        
        -- Seleccionar un caballo aleatorio
        SELECT ID_Caballo INTO caballo_id
        FROM Caballos
        ORDER BY RAND()
        LIMIT 1;
        
        -- Generar fecha aleatoria
        SET fecha_inicio = DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 1825) DAY);
        
        INSERT INTO Pupilaje (Cuidador_ID_Empleado, Caballos_ID_Caballo, Box, F_inicio, F_fin)
        VALUES (
            cuidador_id,
            caballo_id,
            FLOOR(RAND()*50 + 1),
            fecha_inicio,
            DATE_ADD(fecha_inicio, INTERVAL FLOOR(RAND()*6 + 1) MONTH)
        );
        
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL GenerarPupilajes();
DROP PROCEDURE GenerarPupilajes;

-- Cobros_clases
DELIMITER //
CREATE PROCEDURE GenerarCobrosClases()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE clase_id INT;
    DECLARE fecha_inicio DATE;
    DECLARE cur CURSOR FOR SELECT ID_Clase, F_inicio FROM Clases;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO clase_id, fecha_inicio;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        INSERT INTO Cobros_clases (ID_Metodo, Monto, Fecha_Cobro, Estado, ID_Clase)
        VALUES (
            FLOOR(RAND()*3 + 1),
            FLOOR(RAND()*100 + 50),
            DATE_ADD(fecha_inicio, INTERVAL FLOOR(RAND()*30) DAY),
            CASE WHEN RAND() > 0.15 THEN 'Pagado' ELSE 'Pendiente' END,
            clase_id
        );
    END LOOP;
    
    CLOSE cur;
END //
DELIMITER ;

CALL GenerarCobrosClases();
DROP PROCEDURE GenerarCobrosClases;

-- Cobros_pupilaje
DELIMITER //
CREATE PROCEDURE GenerarCobrosPupilaje()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE pupilaje_id INT;
    DECLARE fecha_inicio DATE;
    DECLARE cur CURSOR FOR SELECT ID_Pupilaje, F_inicio FROM Pupilaje;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO pupilaje_id, fecha_inicio;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        INSERT INTO Cobros_pupilaje (ID_Metodo, Monto, Fecha_Cobro, Estado, ID_Pupilaje)
        VALUES (
            FLOOR(RAND()*3 + 1),
            FLOOR(RAND()*500 + 300),
            DATE_ADD(fecha_inicio, INTERVAL FLOOR(RAND()*30) DAY),
            CASE WHEN RAND() > 0.2 THEN 'Pagado' ELSE 'Pendiente' END,
            pupilaje_id
        );
    END LOOP;
    
    CLOSE cur;
END //
DELIMITER ;

CALL GenerarCobrosPupilaje();
DROP PROCEDURE GenerarCobrosPupilaje;

-- Generar nominas 2020-2025
DELIMITER //
CREATE PROCEDURE GenerarNominas()
BEGIN
    DECLARE fecha_inicio DATE DEFAULT '2020-01-01';
    DECLARE fecha_fin DATE DEFAULT '2025-12-31';
    DECLARE done INT DEFAULT FALSE;
    DECLARE emp_id INT;
    DECLARE emp_salario DECIMAL(10, 2);
    DECLARE cur_fecha DATE;
    DECLARE ultimo_dia DATE;
    DECLARE cur CURSOR FOR SELECT ID_Empleado, Salario FROM Empleados;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    SET cur_fecha = fecha_inicio;
    
    WHILE cur_fecha <= fecha_fin DO
        SET ultimo_dia = LAST_DAY(cur_fecha);
        
        OPEN cur;
        set done = FALSE;
        
        read_loop: LOOP
            FETCH cur INTO emp_id, emp_salario;
            IF done THEN
                LEAVE read_loop;
            END IF;
            
            INSERT INTO Nominas (ID_Empleado, Periodo_Inicio, Periodo_Fin, Monto, Fecha_Pago, Estado)
            VALUES (
                emp_id,
                cur_fecha,
                ultimo_dia,
                emp_salario,
                ultimo_dia,
                'Pagado'
            );
        END LOOP;
        
        CLOSE cur;
        
        SET cur_fecha = DATE_ADD(cur_fecha, INTERVAL 1 MONTH);
    END WHILE;
END //
DELIMITER ;

CALL GenerarNominas();
DROP PROCEDURE GenerarNominas;
