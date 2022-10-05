USE [ProyectoDAIR];
GO

IF OBJECT_ID('[dbo].[CreateSesionAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[CreateSesionAIR] 
END 
GO
CREATE PROC [dbo].[CreateSesionAIR] 
	@Periodo INT,
	@Nombre NVARCHAR(64),
	@Fecha DATE,
	@Inicio TIME,
	@Fin TIME,
	@Descripcion NVARCHAR(200),
	@Link NVARCHAR(200)
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION nuevaSesionAIR
			INSERT INTO dbo.SesionAIR(PeriodoId,
										Nombre,
										Fecha,
										HoraInicio,
										HoraFin, 
										Descripcion,
										Link)
			SELECT @Periodo,
					@Nombre,
					@Fecha,
					@Inicio,
					@Fin,
					@Descripcion,
					@Link;
		COMMIT TRANSACTION nuevaSesionAIR;
		SELECT @@Identity Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION nuevaSesionAIR;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[ReadSesionAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ReadSesionAIR] 
END 
GO
CREATE PROC [dbo].[ReadSesionAIR] 
    @Id INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SELECT Id,Nombre,Fecha,HoraInicio,HoraFin
		FROM dbo.SesionAIR
		WHERE [Id] = @Id
	END TRY

	BEGIN CATCH
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[UpdateSesionAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[UpdateSesionAIR] 
END 
GO
CREATE PROC [dbo].[UpdateSesionAIR]
	@Id INT,
	@Nombre NVARCHAR(64),
	@Fecha DATE,
	@Inicio TIME,
	@Fin TIME
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION modificarSesionAIR
			UPDATE dbo.SesionAIR
			SET Nombre = @Nombre,
				Fecha = @Fecha,
				HoraInicio = @Inicio,
				HoraFin = @Fin
			WHERE Id = @Id
		COMMIT TRANSACTION modificarSesionAIR;
		SELECT @Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION modificarSesionAIR;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[DeleteSesionAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteSesionAIR] 
END 
GO
CREATE PROC [dbo].[DeleteSesionAIR]
	@Id INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION eliminarSesionAIR
			DELETE FROM dbo.SesionAIR
			WHERE Id = @Id;
		COMMIT TRANSACTION eliminarSesionAIR;
		SELECT @Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION eliminarSesionAIR;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO