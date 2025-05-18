-- Eliminar la base de datos si existe
USE master; -- Cambiamos al contexto de la base de datos maestra
GO

IF DB_ID('LRC_Hipica') IS NOT NULL
BEGIN
    ALTER DATABASE LRC_Hipica SET SINGLE_USER WITH ROLLBACK IMMEDIATE; -- Desconectar a todos los usuarios
    DROP DATABASE LRC_Hipica; -- Eliminar la base de datos
END
GO

-- Crear la base de datos
CREATE DATABASE LRC_Hipica;
GO

USE LRC_Hipica; -- Cambiamos al contexto de la base de datos LRC_Hipica
GO

-- Tabla CCAA
CREATE TABLE CCAA (
    ID_CCAA INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100)
);

-- Tabla Provincias
CREATE TABLE Provincias (
    ID_Provincia INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100),
    IDCCAA INT FOREIGN KEY REFERENCES CCAA(ID_CCAA)
);

-- Tabla Localidades
CREATE TABLE Localidades (
    ID_Localidad INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100),
    IDProvincia INT FOREIGN KEY REFERENCES Provincias(ID_Provincia)
);

-- Tabla Clientes
CREATE TABLE Clientes (
    ID_Cliente INT IDENTITY(1,1) PRIMARY KEY,
    DNI NVARCHAR(20),
    Nombre NVARCHAR(100),
    Dirección NVARCHAR(200),
    IDLocalidad INT FOREIGN KEY REFERENCES Localidades(ID_Localidad),
    Email NVARCHAR(100),
    Movil NVARCHAR(20),
    IBAN NVARCHAR(50),
    F_alta DATE,
    F_baja DATE,
    Tipo VARCHAR(50) -- 'Estudiante', 'Propietario', 'Ambos'
);

-- Tabla Caballos
CREATE TABLE Caballos (
    ID_Caballo INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100),
    Raza NVARCHAR(100),
    Edad INT,
    ID_Cliente INT FOREIGN KEY REFERENCES Clientes(ID_Cliente)
);

-- Tabla Empleados
CREATE TABLE Empleados (
    ID_Empleado INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100),
    Dirección NVARCHAR(200),
    IDLocalidad INT FOREIGN KEY REFERENCES Localidades(ID_Localidad),
    DNI NVARCHAR(20),
    Salario DECIMAL(10, 2),
    Tipo VARCHAR(50) -- 'Cuidador', 'Profesor', 'Administrativo'
);

-- Tabla Metodo_Pago
CREATE TABLE Metodo_Pago (
    ID_Metodo INT IDENTITY(1,1) PRIMARY KEY,
    Metodo VARCHAR(50) -- 'Efectivo', 'Tarjeta', 'Transferencia'
);

-- Tabla Clases
CREATE TABLE Clases (
    ID_Clase INT IDENTITY(1,1) PRIMARY KEY,
    Estudiantes_ID_Cliente INT FOREIGN KEY REFERENCES Clientes(ID_Cliente),
    Profesor_ID_Empleado INT FOREIGN KEY REFERENCES Empleados(ID_Empleado),
    F_inicio DATE,
    F_fin DATE
);

-- Tabla Pupilaje (creada antes que Cobros_pupilaje)
CREATE TABLE Pupilaje (
    ID_Pupilaje INT IDENTITY(1,1) PRIMARY KEY,
    Cuidador_ID_Empleado INT FOREIGN KEY REFERENCES Empleados(ID_Empleado),
    Caballos_ID_Caballo INT FOREIGN KEY REFERENCES Caballos(ID_Caballo),
    Box INT,
    F_inicio DATE,
    F_fin DATE
);

-- Tabla Cobros_clases
CREATE TABLE Cobros_clases (
    ID_Cobro INT IDENTITY(1,1) PRIMARY KEY,
    ID_Metodo INT FOREIGN KEY REFERENCES Metodo_Pago(ID_Metodo),
    Monto DECIMAL(10, 2),
    Fecha_Cobro DATE,
    Estado VARCHAR(50), -- 'Pagado', 'Pendiente'
    ID_Clase INT FOREIGN KEY REFERENCES Clases(ID_Clase)
);

-- Tabla Cobros_pupilaje (creada despu�s de Pupilaje)
CREATE TABLE Cobros_pupilaje (
    ID_Cobro INT IDENTITY(1,1) PRIMARY KEY,
    ID_Metodo INT FOREIGN KEY REFERENCES Metodo_Pago(ID_Metodo),
    Monto DECIMAL(10, 2),
    Fecha_Cobro DATE,
    Estado VARCHAR(50), -- 'Pagado', 'Pendiente'
    ID_Pupilaje INT FOREIGN KEY REFERENCES Pupilaje(ID_Pupilaje)
);

-- Crear la tabla Nominas
CREATE TABLE Nominas (
    ID_Nomina INT IDENTITY(1,1) PRIMARY KEY,
    ID_Empleado INT FOREIGN KEY REFERENCES Empleados(ID_Empleado),
    Periodo_Inicio DATE,
    Periodo_Fin DATE,
    Monto DECIMAL(10, 2),
    Fecha_Pago DATE,
    Estado VARCHAR(50) -- 'Pagado', 'Pendiente'
);