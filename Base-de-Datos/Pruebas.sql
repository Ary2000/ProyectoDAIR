------------Pruebas CRUD Usuario------------
EXEC dbo.CreateUsuario 'admin','contrasenia'
EXEC dbo.ReadUsuario 1
EXEC dbo.UpdateUsuario 1, 'admin','contrasenia'

------------Pruebas Tablas------------
---Departemento
EXEC dbo.CreateDepartamento 'Matematica'
EXEC dbo.CreateDepartamento 'Ingenieria en Computacion'
EXEC dbo.CreateDepartamento 'Recursos Humanos'
EXEC dbo.CreateDepartamento 'Quimica'

EXEC ReadDepartamento 1
EXEC UpdateDepartamento 1, 'AIR'
EXEC ReadDepartamento 1

---Sede
EXEC dbo.CreateSede 'Limon'
EXEC dbo.CreateSede 'San Jose'

EXEC dbo.ReadSede 1
EXEC dbo.ReadSede 2

EXEC dbo.UpdateSede 2, 'Cartago'
EXEC dbo.ReadSede 2

SELECT * FROM dbo.Sede

---Sector
EXEC dbo.CreateSector 'Administrativo'
EXEC dbo.CreateSector 'Docente'
EXEC dbo.CreateSector 'Oficio'
EXEC dbo.CreateSector 'Egresado'

EXEC dbo.ReadSector 4
EXEC dbo.UpdateSector 4,'Estudiante' 
SELECT * FROM dbo.Sector

---Etapa
EXEC dbo.CreateEtapa 'Aprobado'
EXEC dbo.CreateEtapa 'Rechasado'

EXEC dbo.ReadEtapa 1
EXEC dbo.UpdateEtapa 1, 'Aprobado'
SELECT * FROM dbo.Etapa

---Periodo
EXEC dbo.CreatePeriodo 2020,2022
EXEC dbo.ReadPeriodo 1
EXEC dbo.UpdatePeriodo 1, 2021,2022

SELECT * FROM dbo.Periodo

------------Notificacion------------
EXEC dbo.CreateNotificacion 'Reunion semana 9', '28/09/2022'
EXEC dbo.CreateNotificacion 'Asamblea extraordinaria', '05/11/2022'
EXEC dbo.CreateNotificacion 'Tema importante', '15/02/2026'

EXEC dbo.ReadNotificacion 1
EXEC dbo.ReadNotificacion 3

EXEC dbo.UpdateNotificacion 1,'Reunion semana 10', '05/10/2022'
EXEC dbo.DeleteNotificacion 3

SELECT * FROM dbo.Notificacion

------------Asambleista------------
SELECt * FROM dbo.Departamento
SELECt * FROM dbo.Sector
SELECt * FROM dbo.Sede
EXEC dbo.CreateAsambleista 'AIR','Oficio','Limon','Juan Perez','201540136'
EXEC dbo.CreateAsambleista 'Ingenieria en Computacion','Estudiante','Cartago','Juan Gomez','601450951'
EXEC dbo.CreateAsambleista 'Matematica','Docente','San Jose','Fabian Perez','301451450'
EXEC dbo.CreateAsambleista 'Recursos Humanos','Administrativo','Limon','Pablo Perez','704140312'
EXEC dbo.CreateAsambleista 'Quimica','Docente','Cartago','Maria Quiroz','301470147'
EXEC dbo.CreateAsambleista 'Matematica','Docente','San Jose','Sara Arguedas','601370841'
EXEC dbo.CreateAsambleista 'Matematica','Estudiante','Cartago','Juan Perez','104440888'
EXEC dbo.CreateAsambleista 'Quimica','Estudiante','Cartago','Juana Villalobos','303320112'

EXEC dbo.ReadAsambleista 2
EXEC dbo.UpdateAsambleista 'Ingenieria en Computacion','Docente','San Jose','Juan Perez Coto','201540136'
EXEC dbo.ReadAsambleista 5
SELECT * FROM dbo.Asambleista ORDER BY Nombre