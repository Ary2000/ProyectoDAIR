--DROP DATABASE IF EXISTS [ProyectoDAIR]

--CREATE DATABASE [ProyectoDAIR]

--USE [ProyectoDAIR];
--GO

CREATE TABLE Departamento(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [Nombre]				NVARCHAR(32) NOT NULL,
	  PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE Etapa(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [Nombre]				NVARCHAR(32) NOT NULL,
	  PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE Sector(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [Nombre]				NVARCHAR(32) NOT NULL,
	  PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE Sede(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [Nombre]				NVARCHAR(32) NOT NULL,
	  PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE Periodo(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [Inicio]				INT NOT NULL,
	  [Fin]					INT NOT NULL
	  PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE Notificacion(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [Motivo]				NVARCHAR(252) NOT NULL,
	  [FechaNotificacion]	DATE NOT NULL
	  PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE Asambleista(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [DepartamentoId]				INT NOT NULL,
	  [SectorId]			INT NOT NULL,
	  [SedeId]				INT NOT NULL,
	  [Nombre]				NVARCHAR(64) NOT NULL,
	  [Cedula]				NVARCHAR(16) NOT NULL
	  PRIMARY KEY CLUSTERED ([ID] ASC),
	  FOREIGN KEY ([DepartamentoId]) REFERENCES dbo.Departamento ([ID]),
	  FOREIGN KEY ([SectorId]) REFERENCES dbo.Sector ([ID]),
	  FOREIGN KEY ([SedeId]) REFERENCES dbo.Sede ([ID])
);

CREATE TABLE Votacion(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [AsambleistasPresentes]			INT NOT NULL,
	  [PersonalTecnico]					INT NOT NULL,
	  [AsambleistasVotoInicio]			INT NOT NULL,
	  [AsambleistasVotoFinal]			INT NOT NULL,
	  [VotosEmitidos]					INT NOT NULL,
	  [VotosSinEmitir]					INT NOT NULL,
	  [VotosAFavor]						INT NOT NULL,
	  [VotosEnContra]					INT NOT NULL
	  PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE SesionAIR(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [PeriodoId]			INT NOT NULL,
	  [Nombre]				NVARCHAR(64) NOT NULL,
	  [Fecha]				DATE NOT NULL,
	  [HoraInicio]			TIME NOT NULL,
	  [HoraFin]				TIME NOT NULL
	  PRIMARY KEY CLUSTERED ([ID] ASC),
	  FOREIGN KEY ([PeriodoId]) REFERENCES dbo.Periodo ([ID])
);

CREATE TABLE SesionDAIR(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [PeriodoId]			INT NOT NULL,
	  [Nombre]				NVARCHAR(64) NOT NULL,
	  [Fecha]				DATE NOT NULL,
	  [HoraInicio]			TIME NOT NULL,
	  [HoraFin]				TIME NOT NULL
	  PRIMARY KEY CLUSTERED ([ID] ASC),
	  FOREIGN KEY ([PeriodoId]) REFERENCES dbo.Periodo ([ID])
);

CREATE TABLE PropuestaDAIR(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [SesionDAIRId]		INT NOT NULL,
	  [EtapaId]				INT NOT NULL,
	  [VotacionId]			INT NOT NULL,
	  [Nombre]				NVARCHAR(64) NOT NULL,
	  [Resumen]				NVARCHAR(1024) NOT NULL
	  PRIMARY KEY CLUSTERED ([ID] ASC),
	  FOREIGN KEY ([SesionDAIRId]) REFERENCES dbo.SesionDAIR ([ID]),
	  FOREIGN KEY ([EtapaId]) REFERENCES dbo.Etapa ([ID]),
	  FOREIGN KEY ([VotacionId]) REFERENCES dbo.Votacion ([ID])
);

CREATE TABLE PropuestaAIR(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [SesionAIRId]			INT NOT NULL,
	  [EtapaId]				INT NOT NULL,
	  [VotacionId]			INT NOT NULL,
	  [Nombre]				NVARCHAR(64) NOT NULL,
	  [Resumen]				NVARCHAR(1024) NOT NULL
	  PRIMARY KEY CLUSTERED ([ID] ASC),
	  FOREIGN KEY ([SesionAIRId]) REFERENCES dbo.SesionAIR ([ID]),
	  FOREIGN KEY ([EtapaId]) REFERENCES dbo.Etapa ([ID]),
	  FOREIGN KEY ([VotacionId]) REFERENCES dbo.Votacion ([ID])
);

CREATE TABLE RegistroAsistenciaDAIR(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [SesionDAIRId]		INT NOT NULL,
	  [AsambleistaId]		INT NOT NULL,
	  [Asistio]				BIT NOT NULL,
	  [Validacion]			BIT NOT NULL
	  PRIMARY KEY CLUSTERED ([ID] ASC),
	  FOREIGN KEY ([SesionDAIRId]) REFERENCES dbo.SesionDAIR ([ID]),
	  FOREIGN KEY ([AsambleistaId]) REFERENCES dbo.Asambleista ([ID])
);

CREATE TABLE RegistroAsistenciaAIR(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [SesionAIRId]			INT NOT NULL,
	  [AsambleistaId]		INT NOT NULL,
	  [Asistio]				BIT NOT NULL,
	  [Validacion]			BIT NOT NULL
	  PRIMARY KEY CLUSTERED ([ID] ASC),
	  FOREIGN KEY ([SesionAIRId]) REFERENCES dbo.SesionAIR ([ID]),
	  FOREIGN KEY ([AsambleistaId]) REFERENCES dbo.Asambleista ([ID])
);

CREATE TABLE Padron(
	  [Id]					INT NOT NULL IDENTITY(1,1),
	  [AsambleistaId]		INT NOT NULL,
	  [PeriodoId]			INT NOT NULL,
	  [Validacion]			BIT NOT NULL
	  PRIMARY KEY CLUSTERED ([ID] ASC),
	  FOREIGN KEY ([AsambleistaId]) REFERENCES dbo.Asambleista ([ID]),
	  FOREIGN KEY ([PeriodoId]) REFERENCES dbo.Periodo ([ID])
);