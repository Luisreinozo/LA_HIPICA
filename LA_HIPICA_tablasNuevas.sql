USE [LRC_Hipica]
GO
/****** Object:  Table [dbo].[Administrativo]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administrativo](
	[ID_Empleado] [int] NOT NULL,
	[Departamento] [varchar](50) NOT NULL,
 CONSTRAINT [Administrativo_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Caballo]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Caballo](
	[ID_Caballo] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Raza] [varchar](50) NOT NULL,
	[Edad] [tinyint] NOT NULL,
	[F_Ingreso] [date] NOT NULL,
	[ID_Cliente] [int] NULL,
 CONSTRAINT [Caballo_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Caballo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CCAA]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CCAA](
	[ID_CCAA] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [CCAA_PK] PRIMARY KEY CLUSTERED 
(
	[ID_CCAA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clases]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clases](
	[ID_Clase] [int] NOT NULL,
	[ID_Nivel] [int] NOT NULL,
	[ID_Cliente] [int] NOT NULL,
	[ID_Empleado] [int] NOT NULL,
	[F_inicio] [date] NOT NULL,
	[F_fini] [date] NULL,
 CONSTRAINT [Clases_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Clase] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[ID_Cliente] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[DNI_cliente] [varchar](9) NOT NULL,
	[Direccion] [varchar](50) NOT NULL,
	[ID_Localidad] [int] NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Movil] [varchar](9) NOT NULL,
	[IBAN] [varchar](20) NOT NULL,
 CONSTRAINT [Cliente_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Cliente_DNI_cliente_UN] UNIQUE NONCLUSTERED 
(
	[DNI_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cobro_clases]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cobro_clases](
	[ID_CobroCls] [int] NOT NULL,
	[Monto] [decimal](6, 2) NOT NULL,
	[Periodo_cobro] [date] NOT NULL,
	[ID_Clase] [int] NOT NULL,
 CONSTRAINT [Cobro_clases_PK] PRIMARY KEY CLUSTERED 
(
	[ID_CobroCls] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cobro_pupilaje]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cobro_pupilaje](
	[ID_CobroPup] [int] NOT NULL,
	[Monto] [decimal](6, 2) NOT NULL,
	[Periodo_cobro] [date] NOT NULL,
	[ID_Pupilaje] [int] NOT NULL,
 CONSTRAINT [Cobro_pupilaje_PK] PRIMARY KEY CLUSTERED 
(
	[ID_CobroPup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cuidador]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cuidador](
	[ID_Empleado] [int] NOT NULL,
	[Cant_Caballos] [int] NOT NULL,
 CONSTRAINT [Cuidador_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[ID_Empleado] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[DNI_empleado] [varchar](9) NOT NULL,
	[Direccion] [varchar](50) NOT NULL,
	[ID_Localidad] [int] NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Movil] [varchar](9) NOT NULL,
	[Tipo] [varchar](50) NOT NULL,
	[IBAN] [varchar](20) NOT NULL,
	[Salario] [decimal](7, 2) NOT NULL,
 CONSTRAINT [Empleado_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Empleado_DNI_empleado_UN] UNIQUE NONCLUSTERED 
(
	[DNI_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estudiante]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estudiante](
	[ID_Cliente] [int] NOT NULL,
	[F_Inscripcion] [date] NOT NULL,
	[Nivel] [varchar](9) NOT NULL,
 CONSTRAINT [Estudiante_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Localidad]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Localidad](
	[ID_Localidad] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ID_Provincia] [int] NOT NULL,
 CONSTRAINT [Localidad_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Localidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nivel]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nivel](
	[ID_Nivel] [int] NOT NULL,
	[Nombre] [varchar](9) NOT NULL,
	[Precio] [decimal](6, 2) NOT NULL,
 CONSTRAINT [Nivel_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Nivel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nomina]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nomina](
	[ID_Nomina] [int] NOT NULL,
	[Monto] [decimal](6, 2) NOT NULL,
	[Fecha_Pago] [date] NOT NULL,
	[DNI_empleado] [varchar](9) NOT NULL,
 CONSTRAINT [Nomina_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Nomina] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profesor]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profesor](
	[ID_Empleado] [int] NOT NULL,
	[Nivel] [varchar](9) NOT NULL,
 CONSTRAINT [Profesor_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Propietario]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Propietario](
	[ID_Cliente] [int] NOT NULL,
	[F_Alta] [date] NOT NULL,
	[Cant_Caballos] [tinyint] NOT NULL,
 CONSTRAINT [Propietario_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincia](
	[ID_Provincia] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ID_CCAA] [int] NOT NULL,
 CONSTRAINT [Provincia_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Provincia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pupilaje]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pupilaje](
	[ID_Pupilaje] [int] NOT NULL,
	[F_inicio] [date] NOT NULL,
	[F_fin] [date] NOT NULL,
	[ID_Caballo] [int] NOT NULL,
	[Box] [tinyint] NULL,
	[ID_Empleado] [int] NULL,
 CONSTRAINT [Pupilaje_PK] PRIMARY KEY CLUSTERED 
(
	[ID_Pupilaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [RRHH].[Empleados]    Script Date: 23/11/2024 18:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RRHH].[Empleados](
	[ID_Empleado] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[DNI_empleado] [varchar](9) NOT NULL,
	[Direccion] [varchar](50) NOT NULL,
	[ID_Localidad] [int] NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Movil] [varchar](9) NOT NULL,
	[Tipo] [varchar](50) NOT NULL,
	[IBAN] [varchar](20) NOT NULL,
	[Salario] [decimal](7, 2) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Administrativo]  WITH CHECK ADD  CONSTRAINT [Administrativo_Empleado_FK] FOREIGN KEY([ID_Empleado])
REFERENCES [dbo].[Empleado] ([ID_Empleado])
GO
ALTER TABLE [dbo].[Administrativo] CHECK CONSTRAINT [Administrativo_Empleado_FK]
GO
ALTER TABLE [dbo].[Caballo]  WITH CHECK ADD  CONSTRAINT [Caballo_Propietario_FK] FOREIGN KEY([ID_Cliente])
REFERENCES [dbo].[Propietario] ([ID_Cliente])
GO
ALTER TABLE [dbo].[Caballo] CHECK CONSTRAINT [Caballo_Propietario_FK]
GO
ALTER TABLE [dbo].[Clases]  WITH CHECK ADD  CONSTRAINT [Clases_Estudiante_FK] FOREIGN KEY([ID_Cliente])
REFERENCES [dbo].[Estudiante] ([ID_Cliente])
GO
ALTER TABLE [dbo].[Clases] CHECK CONSTRAINT [Clases_Estudiante_FK]
GO
ALTER TABLE [dbo].[Clases]  WITH CHECK ADD  CONSTRAINT [Clases_Nivel_FK] FOREIGN KEY([ID_Nivel])
REFERENCES [dbo].[Nivel] ([ID_Nivel])
GO
ALTER TABLE [dbo].[Clases] CHECK CONSTRAINT [Clases_Nivel_FK]
GO
ALTER TABLE [dbo].[Clases]  WITH CHECK ADD  CONSTRAINT [Clases_Profesor_FK] FOREIGN KEY([ID_Empleado])
REFERENCES [dbo].[Profesor] ([ID_Empleado])
GO
ALTER TABLE [dbo].[Clases] CHECK CONSTRAINT [Clases_Profesor_FK]
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [Cliente_Localidad_FK] FOREIGN KEY([ID_Localidad])
REFERENCES [dbo].[Localidad] ([ID_Localidad])
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [Cliente_Localidad_FK]
GO
ALTER TABLE [dbo].[Cobro_clases]  WITH CHECK ADD  CONSTRAINT [Cobro_clases_Clases_FK] FOREIGN KEY([ID_Clase])
REFERENCES [dbo].[Clases] ([ID_Clase])
GO
ALTER TABLE [dbo].[Cobro_clases] CHECK CONSTRAINT [Cobro_clases_Clases_FK]
GO
ALTER TABLE [dbo].[Cobro_pupilaje]  WITH CHECK ADD  CONSTRAINT [Cobro_pupilaje_Pupilaje_FK] FOREIGN KEY([ID_Pupilaje])
REFERENCES [dbo].[Pupilaje] ([ID_Pupilaje])
GO
ALTER TABLE [dbo].[Cobro_pupilaje] CHECK CONSTRAINT [Cobro_pupilaje_Pupilaje_FK]
GO
ALTER TABLE [dbo].[Cuidador]  WITH CHECK ADD  CONSTRAINT [Cuidador_Empleado_FK] FOREIGN KEY([ID_Empleado])
REFERENCES [dbo].[Empleado] ([ID_Empleado])
GO
ALTER TABLE [dbo].[Cuidador] CHECK CONSTRAINT [Cuidador_Empleado_FK]
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [Empleado_Localidad_FK] FOREIGN KEY([ID_Localidad])
REFERENCES [dbo].[Localidad] ([ID_Localidad])
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [Empleado_Localidad_FK]
GO
ALTER TABLE [dbo].[Estudiante]  WITH CHECK ADD  CONSTRAINT [Estudiante_Cliente_FK] FOREIGN KEY([ID_Cliente])
REFERENCES [dbo].[Cliente] ([ID_Cliente])
GO
ALTER TABLE [dbo].[Estudiante] CHECK CONSTRAINT [Estudiante_Cliente_FK]
GO
ALTER TABLE [dbo].[Localidad]  WITH CHECK ADD  CONSTRAINT [Localidad_Provincia_FK] FOREIGN KEY([ID_Provincia])
REFERENCES [dbo].[Provincia] ([ID_Provincia])
GO
ALTER TABLE [dbo].[Localidad] CHECK CONSTRAINT [Localidad_Provincia_FK]
GO
ALTER TABLE [dbo].[Nomina]  WITH CHECK ADD  CONSTRAINT [Nomina_Empleado_FK] FOREIGN KEY([DNI_empleado])
REFERENCES [dbo].[Empleado] ([DNI_empleado])
GO
ALTER TABLE [dbo].[Nomina] CHECK CONSTRAINT [Nomina_Empleado_FK]
GO
ALTER TABLE [dbo].[Profesor]  WITH CHECK ADD  CONSTRAINT [Profesor_Empleado_FK] FOREIGN KEY([ID_Empleado])
REFERENCES [dbo].[Empleado] ([ID_Empleado])
GO
ALTER TABLE [dbo].[Profesor] CHECK CONSTRAINT [Profesor_Empleado_FK]
GO
ALTER TABLE [dbo].[Propietario]  WITH CHECK ADD  CONSTRAINT [Propietario_Cliente_FK] FOREIGN KEY([ID_Cliente])
REFERENCES [dbo].[Cliente] ([ID_Cliente])
GO
ALTER TABLE [dbo].[Propietario] CHECK CONSTRAINT [Propietario_Cliente_FK]
GO
ALTER TABLE [dbo].[Provincia]  WITH CHECK ADD  CONSTRAINT [Provincia_CCAA_FK] FOREIGN KEY([ID_CCAA])
REFERENCES [dbo].[CCAA] ([ID_CCAA])
GO
ALTER TABLE [dbo].[Provincia] CHECK CONSTRAINT [Provincia_CCAA_FK]
GO
ALTER TABLE [dbo].[Pupilaje]  WITH CHECK ADD  CONSTRAINT [Pupilaje_Caballo_FK] FOREIGN KEY([ID_Caballo])
REFERENCES [dbo].[Caballo] ([ID_Caballo])
GO
ALTER TABLE [dbo].[Pupilaje] CHECK CONSTRAINT [Pupilaje_Caballo_FK]
GO
ALTER TABLE [dbo].[Pupilaje]  WITH CHECK ADD  CONSTRAINT [Pupilaje_Cuidador_FK] FOREIGN KEY([ID_Empleado])
REFERENCES [dbo].[Cuidador] ([ID_Empleado])
GO
ALTER TABLE [dbo].[Pupilaje] CHECK CONSTRAINT [Pupilaje_Cuidador_FK]
GO
