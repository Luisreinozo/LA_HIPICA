
-- TABLA SP(STORED PROCEDURE) VISTA
-- USUARIO ROL PERMISOS GRANT IMPERSONATE
-- IMPORT ARCHIVO DE TEXTO PLANO

-- Problem
-- I understand that, through the use of SQL Server ownership chaining, I can restrict access to 
-- the underlying tables with data while still allowing applications to query and modify data.
-- How does this work? Are there any examples which I might be able to use in my own code?

-- Solution
-- Ownership chaining is a great way to prevent direct access to the base tables. 
-- If you're not familiar with ownership chaining, in SQL Server, when one object refers to another object,
-- and both objects have the same owner, SQL Server will only look at the security on the first object.
-- For instance, if a stored procedure references a table, SQL Server will only check security 
-- on the stored procedure and not the table, as long as both objects have the same owner.

-- This allows us to control access through stored procedures and views and never give users 
-- direct access to the base tables. This effectively allows us to hide columns, control how data 
-- is queried and modified, and even perform business rules checks or complex data integrity rules. 
-- Let's take a look at some examples where this comes in handy.


-- OWNERSHIP CHAINING
-- Implementing SQL Server Security with Stored Procedures and Views


/*
-- Problema
-- Entiendo que, mediante el uso del encadenamiento de propiedad de SQL Server, puedo restringir el acceso a 
- las tablas subyacentes con datos y al mismo tiempo permiten que las aplicaciones consulten y modifiquen datos.
-- ¿Cómo funciona esto? ¿Hay algún ejemplo que pueda utilizar en mi propio código?

-- Solución
-- El encadenamiento de propiedad es una excelente manera de evitar el acceso directo a las tablas base. 
-- Si no está familiarizado con el encadenamiento de propiedad, en SQL Server, cuando un objeto hace referencia a otro objeto,
- y ambos objetos tienen el mismo propietario, SQL Server solo considerará la seguridad del primer objeto.
-- Por ejemplo, si un procedimiento almacenado hace referencia a una tabla, SQL Server solo verificará la seguridad 
-- en el procedimiento almacenado y no en la tabla, siempre que ambos objetos tengan el mismo propietario.

-- Esto nos permite controlar el acceso a través de procedimientos y vistas almacenados y nunca dar a los usuarios 
-- acceso directo a las mesas base. Esto nos permite efectivamente ocultar columnas, controlar cómo se almacenan los datos. 
- se consulta y modifica, e incluso realiza comprobaciones de reglas comerciales o reglas complejas de integridad de datos. 
-- Echemos un vistazo a algunos ejemplos en los que esto resulta útil.


-- ENCADENAMIENTO DE PROPIEDAD
-- Implementación de seguridad de SQL Server con vistas y procedimientos almacenados


*/

DROP DATABASE IF EXISTS TestDB
GO
CREATE DATABASE TestDB;
GO 
 
USE TestDB;
GO

DROP SCHEMA IF EXISTS HR
GO
CREATE SCHEMA HR;
GO 

DROP TABLE IF EXISTS HR.Employee
GO
CREATE TABLE HR.Employee
(
   EmployeeID CHAR(2),
   GivenName VARCHAR(50),
   Surname VARCHAR(50),
   SSN CHAR(9) -- No queremos que los Becarios vean esto
);
GO 

-- Vemos IMPORT / EXPORT
-- GUI IMPORT FLAT FILE Employees
-- Creamos con NOTEPAD (o cualquier otro Editor de Texto) este fichero
-- Employees.txt
-- Tasks Import in GUI

SELECT * FROM HR.Employee
GO

--EmployeeID	GivenName	Surname	SSN
--1					Luis	Arias	111      
--2					Ana		Gomez	222      
--3					Juan	Perez	333      
     

DROP VIEW IF EXISTS HR.LookupEmployee
GO
CREATE VIEW HR.LookupEmployee
AS
SELECT 
   EmployeeID, GivenName, Surname
FROM HR.Employee;
GO

DROP ROLE IF EXISTS HumanResourcesAnalyst
GO
CREATE ROLE HumanResourcesAnalyst;
GO 

GRANT SELECT ON HR.LookupEmployee TO HumanResourcesAnalyst;
GO 

DROP USER IF EXISTS JaneDoe
GO
CREATE USER JaneDoe WITHOUT LOGIN;
GO 

ALTER ROLE HumanResourcesAnalyst
ADD MEMBER JaneDoe;
GO 

-- Esto Funciona
-- Usuaria tiene permisos sobre la Vista
-- No tiene permisos para ejecutar SELECT sobre la Tabla
-- El concepto de Cadena de Propiedad provoca esta posibilidad
-- This will work
-- JaneDoe has SELECT against the view
-- She does not have SELECT against the table
-- Ownership chaining makes this happen


-- USANDO LA VISTA
-- Impersona
EXECUTE AS USER = 'JaneDoe';
GO 

SELECT * FROM HR.LookupEmployee;
GO 

PRINT USER
GO

-- JaneDoe


REVERT;
GO 

PRINT USER
GO

-- dbo

-- USANDO SELECT DIRECTAMENTE SOBRE LA TABLA
-- NO FUNCIONARA
-- This will not work
-- Since JaneDoe doesn't have SELECT permission
-- She cannot query the table in this way
EXECUTE AS USER = 'JaneDoe';
GO 

SELECT * FROM HR.Employee;
GO 

--Msg 229, Level 14, State 5, Line 90
--The SELECT permission was denied on the object 'Employee', database 'TestDB', schema 'HR'.
PRINT USER
GO
REVERT;
GO
PRINT USER
GO


-- DEMOSTRACIÓN USANDO SP
-- STORED PROCEDURE (PROCEDIMIENTO ALMACENADO)

CREATE OR ALTER PROC HR.InsertNewEmployee
	-- INPUT PARAMETERS
   @EmployeeID INT,
   @GivenName VARCHAR(50),
   @Surname VARCHAR(50),
   @SSN CHAR(9)
AS
BEGIN
   INSERT INTO HR.Employee
   ( EmployeeID, GivenName, Surname, SSN )
   VALUES
   ( @EmployeeID, @GivenName, @Surname, @SSN );
END;
GO 

DROP ROLE IF EXISTS  HumanResourcesRecruiter
GO
CREATE ROLE HumanResourcesRecruiter;
GO 

GRANT EXECUTE ON SCHEMA::[HR] TO HumanResourcesRecruiter;
GO 

-- CREO OTRO USUARIO PARA DEMOSTRACIÓN
DROP USER IF EXISTS JohnSmith
GO
CREATE USER JohnSmith WITHOUT LOGIN;
GO 

-- AÑADO AL USUARIO AL ROL
ALTER ROLE HumanResourcesRecruiter
ADD MEMBER JohnSmith;
GO

-- FALLARA PORQUE EL USUARIO NO PUEDE INSERTAR DIRECTAMENTE EN LA TABLA
-- This will fail as JohnSmith doesn't have the ability to
-- insert directly into the table.

EXECUTE AS USER = 'JohnSmith';
GO 

INSERT INTO HR.Employee
   ( EmployeeID, GivenName, Surname, SSN )
   -- (GivenName, Surname, SSN ) con IDENTITY
   VALUES
   (4, 'Miguel', 'Martinez', '444' );
GO 

--Msg 229, Level 14, State 5, Line 133
--The INSERT permission was denied on the object 'Employee', database 'TestDB', schema 'HR'.


REVERT;
GO

-- This will succeed because JohnSmith can execute any 
-- stored procedure in the HR schema. An ownership chain forms,
-- allowing the insert to happen.

--	DELETE HR.Employee 
--	WHERE EmployeeID = 4
--	GO

-- SIN EMBARGO, SI QUE PODRA INSERTAR USANDO EL SP

EXECUTE AS USER = 'JohnSmith';
GO 

EXEC HR.InsertNewEmployee 
      @EmployeeID = 4, 
      @GivenName = 'Miguel', 
      @Surname = 'Martinez', 
      @SSN = '444';
GO 
-- (1 row affected)

PRINT user
GO
-- JohnSmith

-- SOLO PARA DEMOSTRAR QUE EL OBJETO Employee ES DIFERENTE DE HR.Employee 
SELECT * FROM Employee
GO

-- Invalid object name 'Employee'.
-- WRONG SCHEMA dbo

-- ESTO NO FUNCIONARA EL USUARIO TAMPOCO TIENE PERMISOS DE CONSULTA SOBRE LA TABLA

SELECT * FROM HR.Employee;
GO 

--Msg 229, Level 14, State 5, Line 212
--The SELECT permission was denied on the object 'Employee', database 'TestDB', schema 'HR'.
-- JohnSmith hasn't SELECT permission

REVERT;
GO

-- COMPROBANDO QUE INSERT ANTERIOR FUNCIONO
-- Verifying the insert
SELECT EmployeeID, GivenName, Surname, SSN 
FROM HR.Employee;
GO 

--EmployeeID	GivenName	Surname	SSN
--1	Luis	Arias	111      
--2	Ana	Gomez	222      
--3	Juan	Perez	333      
--4	Miguel	Martinez	444      