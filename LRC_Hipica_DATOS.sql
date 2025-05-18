USE LRC_Hipica; -- Cambiamos al contexto de la base de datos LRC_Hipica
GO

-- 1. Insertar datos en CCAA
INSERT INTO CCAA (Nombre)
VALUES ('Galicia');

-- 2. Insertar datos en Provincias
INSERT INTO Provincias (Nombre, IDCCAA)
VALUES ('A Coruña', 1);

-- 3. Insertar datos en Localidades
INSERT INTO Localidades (Nombre, IDProvincia)
VALUES ('A Coruña', 1), ('Santiago de Compostela', 1), ('Arteixo', 1), ('Oleiros', 1);

-- 4. Insertar datos en Clientes
INSERT INTO Clientes (DNI, Nombre, Dirección, IDLocalidad, Email, Movil, IBAN, F_alta, F_baja, Tipo)
VALUES
('12345678A', 'Juan Pérez', 'Calle Falsa 123', 1, 'juan@example.com', '555-1234', 'ES1234567890123456789012', '2020-01-01', NULL, 'Propietario'),
('87654321B', 'María López', 'Avenida Siempre Viva 456', 1, 'maria@example.com', '555-5678', 'ES9876543210987654321098', '2020-02-15', NULL, 'Estudiante'),
('11223344C', 'Carlos Gómez', 'Calle Real 789', 2, 'carlos@example.com', '555-9101', 'ES1122334455667788990011', '2021-03-10', NULL, 'Ambos'),
('55667788D', 'Laura Ruiz', 'Calle del Mar 78', 3, 'laura@example.com', '555-1122', 'ES5566778899001122334455', '2021-04-20', NULL, 'Propietario'),
('99887766E', 'Pedro Sánchez', 'Calle del Río 90', 4, 'pedro@example.com', '555-3344', 'ES9988776655443322110099', '2021-05-15', NULL, 'Estudiante');

-- 5. Insertar datos en Caballos
INSERT INTO Caballos (Nombre, Raza, Edad, ID_Cliente)
VALUES
('Relámpago', 'Pura Sangre', 5, 1),
('Trueno', 'Árabe', 7, 2),
('Estrella', 'Andaluz', 4, 3),
('Viento', 'Frisón', 6, 4),
('Luna', 'Pura Raza Española', 5, 5);

-- 6. Insertar datos en Empleados
INSERT INTO Empleados (Nombre, Dirección, IDLocalidad, DNI, Salario, Tipo)
VALUES
('Ana Martánez', 'Calle del Sol 12', 1, '22334455F', 2000.00, 'Profesor'),
('Luis Fernández', 'Calle de la Luna 34', 1, '33445566G', 1800.00, 'Cuidador'),
('Sofía García', 'Calle de las Estrellas 56', 2, '44556677H', 2200.00, 'Administrativo'),
('Carmen Rodríguez', 'Calle del Viento 12', 3, '66778899I', 1900.00, 'Profesor'),
('Jorge Martín', 'Calle de la Lluvia 34', 4, '77889900J', 2100.00, 'Cuidador');

-- 7. Insertar datos en Metodo_Pago
INSERT INTO Metodo_Pago (Metodo)
VALUES ('Efectivo'), ('Tarjeta'), ('Transferencia');

-- 8. Insertar datos en Clases
INSERT INTO Clases (Estudiantes_ID_Cliente, Profesor_ID_Empleado, F_inicio, F_fin)
VALUES
(2, 1, '2023-10-01', '2023-10-31'), -- Mar�a L�pez con Ana Mart�nez
(3, 4, '2023-11-01', '2023-11-30'), -- Carlos G�mez con Carmen Rodr�guez
(5, 1, '2024-01-01', '2024-01-31'); -- Pedro S�nchez con Ana Mart�nez

-- 9. Insertar datos en Pupilaje
INSERT INTO Pupilaje (Cuidador_ID_Empleado, Caballos_ID_Caballo, Box, F_inicio, F_fin)
VALUES
(2, 1, 1, '2023-10-01', '2023-12-31'), -- Luis Fern�ndez cuida a Rel�mpago
(5, 3, 2, '2024-01-01', '2024-03-31'); -- Jorge Mart�n cuida a Estrella

-- 10. Insertar datos en Cobros_clases
INSERT INTO Cobros_clases (ID_Metodo, Monto, Fecha_Cobro, Estado, ID_Clase)
VALUES
(1, 100.00, '2023-10-05', 'Pagado', 1), -- Cobro en efectivo por la clase 1
(2, 120.00, '2023-11-05', 'Pagado', 2), -- Cobro con tarjeta por la clase 2
(3, 110.00, '2024-01-05', 'Pendiente', 3); -- Cobro por transferencia por la clase 3

-- 11. Insertar datos en Cobros_pupilaje
INSERT INTO Cobros_pupilaje (ID_Metodo, Monto, Fecha_Cobro, Estado, ID_Pupilaje)
VALUES
(1, 300.00, '2023-10-10', 'Pagado', 1), -- Cobro en efectivo por el pupilaje 1
(2, 350.00, '2024-01-10', 'Pendiente', 2); -- Cobro con tarjeta por el pupilaje 2
GO

USE LRC_Hipica; -- Cambiamos al contexto de la base de datos LRC_Hipica
GO

-- 1. Insertar m�s datos en Clientes
INSERT INTO Clientes (DNI, Nombre, Dirección, IDLocalidad, Email, Movil, IBAN, F_alta, F_baja, Tipo)
VALUES
('33445566F', 'Elena Díaz', 'Calle del Bosque 12', 1, 'elena@example.com', '555-5566', 'ES3344556677889900112233', '2020-06-01', NULL, 'Estudiante'),
('77889900G', 'Javier López', 'Calle del Monte 34', 2, 'javier@example.com', '555-7788', 'ES7788990011223344556677', '2020-07-01', NULL, 'Propietario'),
('11223344H', 'Sara Martínez', 'Calle del Valle 56', 3, 'sara@example.com', '555-9900', 'ES1122334455667788990011', '2020-08-01', NULL, 'Ambos'),
('55667788I', 'David González', 'Calle del Prado 78', 4, 'david@example.com', '555-2233', 'ES5566778899001122334455', '2020-09-01', NULL, 'Estudiante'),
('99887766J', 'Marta Sánchez', 'Calle del Campo 90', 1, 'marta@example.com', '555-4455', 'ES9988776655443322110099', '2020-10-01', NULL, 'Propietario');

-- 2. Insertar m�s datos en Caballos
INSERT INTO Caballos (Nombre, Raza, Edad, ID_Cliente)
VALUES
('Brisa', 'Frisón', 6, 6),
('Cielo', 'Pura Raza Española', 5, 7),
('Duna', 'Appaloosa', 7, 8),
('Espuma', 'Shire', 8, 9),
('Fuego', 'Mustang', 4, 10);

-- 3. Insertar m�s datos en Empleados
INSERT INTO Empleados (Nombre, Dirección, IDLocalidad, DNI, Salario, Tipo)
VALUES
('Lucía Sánchez', 'Calle del Trueno 56', 2, '88990011K', 2000.00, 'Profesor'),
('Miguel Gómez', 'Calle del Relámpago 78', 3, '99001122L', 1800.00, 'Cuidador'),
('Eva Fernández', 'Calle del Arcoíris 90', 4, '00112233M', 2200.00, 'Administrativo'),
('Hugo López', 'Calle del Sol 12', 1, '11223344N', 1900.00, 'Profesor'),
('Irene Martínez', 'Calle de la Luna 34', 2, '22334455O', 2100.00, 'Cuidador');

-- 4. Insertar m�s datos en Clases (desde 2020 hasta 2025)
INSERT INTO Clases (Estudiantes_ID_Cliente, Profesor_ID_Empleado, F_inicio, F_fin)
VALUES
(2, 1, '2020-01-01', '2020-01-31'), -- Mar�a L�pez con Ana Mart�nez
(3, 4, '2020-02-01', '2020-02-28'), -- Carlos G�mez con Carmen Rodr�guez
(5, 1, '2020-03-01', '2020-03-31'), -- Pedro S�nchez con Ana Mart�nez
(6, 6, '2021-04-01', '2021-04-30'), -- Elena D�az con Luc�a S�nchez
(7, 7, '2021-05-01', '2021-05-31'), -- Javier L�pez con Miguel G�mez
(8, 8, '2022-06-01', '2022-06-30'), -- Sara Mart�nez con Eva Fern�ndez
(9, 9, '2022-07-01', '2022-07-31'), -- David Gonz�lez con Hugo L�pez
(10, 10, '2023-08-01', '2023-08-31'), -- Marta S�nchez con Irene Mart�nez
(2, 1, '2024-09-01', '2024-09-30'), -- Mar�a L�pez con Ana Mart�nez
(3, 4, '2025-10-01', '2025-10-31'); -- Carlos G�mez con Carmen Rodr�guez

-- 5. Insertar m�s datos en Pupilaje (desde 2020 hasta 2025)
INSERT INTO Pupilaje (Cuidador_ID_Empleado, Caballos_ID_Caballo, Box, F_inicio, F_fin)
VALUES
(2, 1, 1, '2020-01-01', '2020-12-31'), -- Luis Fern�ndez cuida a Rel�mpago
(5, 3, 2, '2021-01-01', '2021-12-31'), -- Jorge Mart�n cuida a Estrella
(7, 5, 3, '2022-01-01', '2022-12-31'), -- Miguel G�mez cuida a Fuego
(9, 7, 4, '2023-01-01', '2023-12-31'), -- Hugo L�pez cuida a Duna
(10, 9, 5, '2024-01-01', '2024-12-31'); -- Irene Mart�nez cuida a Espuma

-- 6. Insertar m�s datos en Cobros_clases (desde 2020 hasta 2025)
INSERT INTO Cobros_clases (ID_Metodo, Monto, Fecha_Cobro, Estado, ID_Clase)
VALUES
(1, 100.00, '2020-01-05', 'Pagado', 1), -- Cobro en efectivo por la clase 1
(2, 120.00, '2020-02-05', 'Pagado', 2), -- Cobro con tarjeta por la clase 2
(3, 110.00, '2020-03-05', 'Pendiente', 3), -- Cobro por transferencia por la clase 3
(1, 130.00, '2021-04-05', 'Pagado', 4), -- Cobro en efectivo por la clase 4
(2, 140.00, '2021-05-05', 'Pagado', 5), -- Cobro con tarjeta por la clase 5
(3, 150.00, '2022-06-05', 'Pendiente', 6), -- Cobro por transferencia por la clase 6
(1, 160.00, '2022-07-05', 'Pagado', 7), -- Cobro en efectivo por la clase 7
(2, 170.00, '2023-08-05', 'Pagado', 8), -- Cobro con tarjeta por la clase 8
(3, 180.00, '2024-09-05', 'Pendiente', 9), -- Cobro por transferencia por la clase 9
(1, 190.00, '2025-10-05', 'Pagado', 10); -- Cobro en efectivo por la clase 10

-- 7. Insertar m�s datos en Cobros_pupilaje (desde 2020 hasta 2025)
INSERT INTO Cobros_pupilaje (ID_Metodo, Monto, Fecha_Cobro, Estado, ID_Pupilaje)
VALUES
(1, 300.00, '2020-01-10', 'Pagado', 1), -- Cobro en efectivo por el pupilaje 1
(2, 350.00, '2021-01-10', 'Pendiente', 2), -- Cobro con tarjeta por el pupilaje 2
(3, 400.00, '2022-01-10', 'Pagado', 3), -- Cobro por transferencia por el pupilaje 3
(1, 450.00, '2023-01-10', 'Pagado', 4), -- Cobro en efectivo por el pupilaje 4
(2, 500.00, '2024-01-10', 'Pendiente', 5); -- Cobro con tarjeta por el pupilaje 5

-- Eliminar datos existentes (opcional, si es necesario)
-- DELETE FROM Nominas;

-- Script modificado para inserción por mes
DECLARE @FechaInicio DATE = '2020-01-01';
DECLARE @FechaFin DATE = '2025-01-31';
DECLARE @PeriodoInicio DATE = @FechaInicio;
DECLARE @PeriodoFin DATE;
DECLARE @FechaPago DATE;
DECLARE @Estado VARCHAR(50);
DECLARE @ID_Empleado INT;
DECLARE @Salario DECIMAL(10, 2);

-- Recorrer cada mes
WHILE @PeriodoInicio <= @FechaFin
BEGIN
    -- Calcular fechas del periodo
    SET @PeriodoFin = EOMONTH(@PeriodoInicio);
    SET @FechaPago = @PeriodoFin;

    -- Recorrer todos los empleados para este mes
    DECLARE empleado_cursor CURSOR FOR
    SELECT ID_Empleado, Salario FROM Empleados;

    OPEN empleado_cursor;
    FETCH NEXT FROM empleado_cursor INTO @ID_Empleado, @Salario;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Aleatorizar el estado (90% Pagado, 10% Pendiente)
        IF RAND() < 1
            SET @Estado = 'Pagado';
        ELSE
            SET @Estado = 'Pendiente';

        -- Insertar la nómina
        INSERT INTO Nominas (ID_Empleado, Periodo_Inicio, Periodo_Fin, Monto, Fecha_Pago, Estado)
        VALUES (@ID_Empleado, @PeriodoInicio, @PeriodoFin, @Salario, @FechaPago, @Estado);

        FETCH NEXT FROM empleado_cursor INTO @ID_Empleado, @Salario;
    END;

    CLOSE empleado_cursor;
    DEALLOCATE empleado_cursor;

    -- Avanzar al siguiente mes
    SET @PeriodoInicio = DATEADD(MONTH, 1, @PeriodoInicio);
END;
GO