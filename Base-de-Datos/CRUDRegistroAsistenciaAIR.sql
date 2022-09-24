USE [ProyectoDAIR];
GO

IF OBJECT_ID('[dbo].[CreateAsistenciaAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[CreateAsistenciaAIR] 
END 
GO
CREATE PROC [dbo].[CreateAsistenciaAIR] 
	@SesionAIRId INT,
	@AsambleistaId INT,
	@Asistio BIT,
	@Validacion BIT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION nuevaAsistenciaAIR
			INSERT INTO dbo.RegistroAsistenciaAIR(SesionAIRId,
										AsambleistaId,
										Asistio,
										Validacion)
			SELECT @SesionAIRId,
					@AsambleistaId,
					@Asistio,
					@Validacion;
		COMMIT TRANSACTION nuevaAsistenciaAIR;
		SELECT @@Identity Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION nuevaAsistenciaAIR;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[ReadAsistenciaAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ReadAsistenciaAIR] 
END 
GO
CREATE PROC [dbo].[ReadAsistenciaAIR] 
    @Id INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SELECT A.Nombre,S.Nombre,R.Asistio
		FROM dbo.RegistroAsistenciaAIR R
		INNER JOIN dbo.Asambleista A ON R.AsambleistaId = A.Id
		INNER JOIN dbo.SesionAIR S ON R.SesionAIRId = S.Id
		WHERE R.[Id] = @Id
	END TRY

	BEGIN CATCH
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[UpdateAsistenciaAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[UpdateAsistenciaAIR] 
END 
GO
CREATE PROC [dbo].[UpdateAsistenciaAIR]
	@Id INT,
	@Asistio BIT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION modificarAsistenciaAIR
			UPDATE dbo.RegistroAsistenciaAIR
			SET Asistio = @Asistio
			WHERE Id = @Id
		COMMIT TRANSACTION modificarAsistenciaAIR;
		SELECT @Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION modificarAsistenciaAIR;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[DeleteAsistenciaAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteAsistenciaAIR] 
END 
GO
CREATE PROC [dbo].[DeleteAsistenciaAIR]
	@Id INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION eliminarAsistenciaAIR
			UPDATE dbo.RegistroAsistenciaAIR
			SET Asistio = 0
			WHERE Id = @Id
		COMMIT TRANSACTION eliminarAsistenciaAIR;
		SELECT @Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION eliminarAsistenciaAIR;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO