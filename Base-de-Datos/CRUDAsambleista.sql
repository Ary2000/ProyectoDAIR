USE [ProyectoDAIR];
GO

IF OBJECT_ID('[dbo].[CreateAsambleista]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[CreateAsambleista] 
END 
GO
CREATE PROC [dbo].[CreateAsambleista] 
    @DepartamentoId INT,
	@SectorId INT,
	@SedeId INT,
	@Nombre NVARCHAR(32),
	@Cedula NVARCHAR(256)
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION nuevoAsambleista
			INSERT INTO dbo.Asambleista(DepartamentoId,
									SectorId,
									SedeId,
									Nombre,
									Cedula)
			SELECT @DepartamentoId,
					@SectorId,
					@SedeId,
					@Nombre,
					@Cedula;
		COMMIT TRANSACTION nuevoAsambleista;
		SELECT @@Identity Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION nuevoAsambleista;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[ReadAsambleista]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ReadAsambleista] 
END 
GO
CREATE PROC [dbo].[ReadAsambleista] 
    @Id INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SELECT D.Nombre, Sec.Nombre, Se.Nombre, Nombre, Cedula
		FROM dbo.Asambleista A
		INNER JOIN dbo.Departamento D ON A.DepartamentoId = D.Id
		INNER JOIN dbo.Sector Sec ON A.SectorId = Sec.Id
		INNER JOIN dbo.Sede Se ON A.SedeId = Se.Id
		WHERE [Id] = @Id
	END TRY

	BEGIN CATCH
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[UpdateAsambleista]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[UpdateAsambleista] 
END 
GO
CREATE PROC [dbo].[UpdateAsambleista]
	@DepartamentoId INT,
	@SectorId INT,
	@SedeId INT,
	@Nombre NVARCHAR(32),
	@Cedula NVARCHAR(256)
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION leerAsambleista
			UPDATE [dbo].[Biomasa]
			SET DepartamentoId = @DepartamentoId,
				SectorId = @SectorId,
				SedeId = @SedeId,
				Nombre = @Nombre
			WHERE Cedula = @Cedula
		COMMIT TRANSACTION leerAsambleista;
		SELECT 1;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION modificarAsambleista;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO