USE LRC_Hipica;
GO

-- 2. Insertar datos en CCAA
INSERT INTO CCAA (Nombre) VALUES ('Galicia');
GO

-- 3. Insertar Provincias
INSERT INTO Provincias (Nombre, IDCCAA) VALUES ('A Coruña', 1);
GO

-- 4. Insertar Localidades
INSERT INTO Localidades (Nombre, IDProvincia) VALUES 
('A Coruña', 1),
('Arteixo', 1),
('Oleiros', 1),
('Culleredo', 1),
('Sada', 1),
('Cambre', 1),
('Betanzos', 1);
GO

-- 5. Generar 200 clientes
DECLARE @i INT = 1;
WHILE @i <= 200
BEGIN
    INSERT INTO Clientes (DNI, Nombre, Dirección, IDLocalidad, Email, Movil, IBAN, F_alta, F_baja, Tipo)
    VALUES (
        CONCAT('DNI', RIGHT('00000000' + CAST(@i AS VARCHAR(8)), 8)),
        CONCAT('Cliente', @i),
        CONCAT('Calle Cliente ', @i, ' Nº', CAST(FLOOR(RAND()*100 + 1) AS INT)),
        CAST(FLOOR(RAND()*7 + 1) AS INT),
        CONCAT('cliente', @i, '@example.com'),
        CONCAT('6', RIGHT('00000000' + CAST(@i AS VARCHAR(8)), 8)),
        CONCAT('ES', RIGHT('000000000000000000' + CAST(@i AS VARCHAR(20)), 20)),
        DATEADD(DAY, -CAST(RAND()*1825 AS INT), '2020-01-01'),
        CASE WHEN @i % 20 = 0 THEN DATEADD(DAY, -CAST(RAND()*365 AS INT), GETDATE()) ELSE NULL END,
        CASE 
            WHEN @i % 3 = 0 THEN 'Estudiante' 
            WHEN @i % 3 = 1 THEN 'Propietario' 
            ELSE 'Ambos' 
        END
    );
    SET @i += 1;
END
GO

-- 6. Generar 30 caballos
DECLARE @razas TABLE (Nombre VARCHAR(50));
INSERT INTO @razas VALUES 
('Pura Sangre'), ('Árabe'), ('Andaluz'), ('Frisón'), ('Appaloosa'), ('Mustang'), ('Shire');

DECLARE @j INT = 1;
WHILE @j <= 30
BEGIN
    INSERT INTO Caballos (Nombre, Raza, Edad, ID_Cliente)
    VALUES (
        CONCAT('Caballo', @j),
        (SELECT TOP 1 Nombre FROM @razas ORDER BY NEWID()),
        CAST(FLOOR(RAND()*15 + 3) AS INT),
        CAST(FLOOR(RAND()*200 + 1) AS INT)
    );
    SET @j += 1;
END
GO

-- 7. Generar empleados (5 Admin, 10 Profesores, 15 Cuidadores)
INSERT INTO Empleados (Nombre, Dirección, IDLocalidad, DNI, Salario, Tipo)
SELECT 
    CONCAT('Empleado', ROW_NUMBER() OVER(ORDER BY (SELECT NULL))),
    CONCAT('Calle Empleado ', ROW_NUMBER() OVER(ORDER BY (SELECT NULL))),
    CAST(FLOOR(RAND()*7 + 1) AS INT),
    CONCAT('E', RIGHT('0000000' + CAST(ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS VARCHAR(7)), 7)),
    CASE 
        WHEN n <= 5 THEN 1500.00   -- Administrativos
        WHEN n <= 15 THEN 1500.00  -- Profesores
        ELSE 1100.00               -- Cuidadores
    END,
    CASE 
        WHEN n <= 5 THEN 'Administrativo'
        WHEN n <= 15 THEN 'Profesor' 
        ELSE 'Cuidador' 
    END
FROM (SELECT TOP 30 ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS n FROM sys.objects) AS numbers;
GO

-- 8. Generar 1000 clases (solo Profesores)
WITH Profesores AS (
    SELECT ID_Empleado 
    FROM Empleados 
    WHERE Tipo = 'Profesor'
),
Fechas AS (
    SELECT TOP 1000
        DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1825 AS INT), '2020-01-01') AS F_inicio
    FROM sys.columns
)
INSERT INTO Clases (Estudiantes_ID_Cliente, Profesor_ID_Empleado, F_inicio, F_fin)
SELECT 
    c.ID_Cliente,
    p.ID_Empleado,
    f.F_inicio,
    DATEADD(HOUR, 2, f.F_inicio)
FROM Fechas f
CROSS JOIN (SELECT TOP 1 ID_Cliente FROM Clientes WHERE Tipo IN ('Estudiante', 'Ambos') ORDER BY NEWID()) c
CROSS JOIN (SELECT TOP 1 ID_Empleado FROM Profesores ORDER BY NEWID()) p;
GO

-- 9. Generar 500 pupilajes
WITH Cuidadores AS (
    SELECT ID_Empleado 
    FROM Empleados 
    WHERE Tipo = 'Cuidador'
),
Propietarios AS (
    SELECT ID_Cliente 
    FROM Clientes 
    WHERE Tipo IN ('Propietario', 'Ambos')
),
Fechas AS (
    SELECT TOP 500
        DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * 1825 AS INT), '2020-01-01') AS F_inicio
    FROM sys.columns
)
INSERT INTO Pupilaje (Cuidador_ID_Empleado, Caballos_ID_Caballo, Box, F_inicio, F_fin)
SELECT 
    c.ID_Empleado,
    cab.ID_Caballo,
    CAST(FLOOR(RAND()*50 + 1) AS INT),
    f.F_inicio,
    DATEADD(MONTH, CAST(RAND()*6 + 1 AS INT), f.F_inicio)
FROM Fechas f
CROSS JOIN (SELECT TOP 1 ID_Empleado FROM Cuidadores ORDER BY NEWID()) c
CROSS JOIN (SELECT TOP 1 ID_Caballo FROM Caballos ORDER BY NEWID()) cab;
GO

-- 10 Insertar métodos de pago (si no existen)
IF NOT EXISTS (SELECT 1 FROM Metodo_Pago)
BEGIN
    INSERT INTO Metodo_Pago (Metodo)
    VALUES ('Efectivo'), ('Tarjeta'), ('Transferencia');
END
GO

--11 Cobros_clases (solo IDs 1-3, que corresponden a Efectivo, Tarjeta, Transferencia)
INSERT INTO Cobros_clases (ID_Metodo, Monto, Fecha_Cobro, Estado, ID_Clase)
SELECT 
    CAST(FLOOR(RAND()*3 + 1) AS INT), -- Genera 1, 2 o 3
    CAST(FLOOR(RAND()*100 + 50) AS DECIMAL(10,2)),
    DATEADD(DAY, CAST(FLOOR(RAND()*30) AS INT), c.F_inicio),
    CASE WHEN RAND() > 0.15 THEN 'Pagado' ELSE 'Pendiente' END,
    c.ID_Clase
FROM Clases c;
GO

--12 Cobros_pupilaje (mismo rango)
INSERT INTO Cobros_pupilaje (ID_Metodo, Monto, Fecha_Cobro, Estado, ID_Pupilaje)
SELECT 
    CAST(FLOOR(RAND()*3 + 1) AS INT), -- Genera 1, 2 o 3
    CAST(FLOOR(RAND()*500 + 300) AS DECIMAL(10,2)),
    DATEADD(DAY, CAST(FLOOR(RAND()*30) AS INT), p.F_inicio),
    CASE WHEN RAND() > 0.2 THEN 'Pagado' ELSE 'Pendiente' END,
    p.ID_Pupilaje
FROM Pupilaje p;
GO


-- 12. Generar nóminas 2020-2025
DECLARE @FechaInicio DATE = '2020-01-01';
DECLARE @FechaFin DATE = '2025-12-31';

WHILE @FechaInicio <= @FechaFin
BEGIN
    INSERT INTO Nominas (ID_Empleado, Periodo_Inicio, Periodo_Fin, Monto, Fecha_Pago, Estado)
    SELECT 
        ID_Empleado,
        @FechaInicio,
        EOMONTH(@FechaInicio),
        Salario,
        EOMONTH(@FechaInicio),
        'Pagado'
    FROM Empleados;
    
    SET @FechaInicio = DATEADD(MONTH, 1, @FechaInicio);
END
GO