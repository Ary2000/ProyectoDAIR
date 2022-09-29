USE [ProyectoDAIR];
GO

IF OBJECT_ID('[dbo].[CreateAsistenciaAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[CreateAsistenciaAIR] 
END 
GO
CREATE PROC [dbo].[CreateAsistenciaAIR] 
	@SesionAIRId INT,
	@Cedula NVARCHAR(16),
	@Asistio BIT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION nuevaAsistenciaAIR
			DECLARE @AsambleistaId INT
			SELECT @AsambleistaId = A.Id
			FROM dbo.Asambleista A
			WHERE A.Cedula = @Cedula
			IF NOT EXISTS (SELECT Id FROM dbo.RegistroAsistenciaAIR WHERE AsambleistaId = @AsambleistaId AND SesionAIRId = @SesionAIRId)
				BEGIN
					INSERT INTO dbo.RegistroAsistenciaAIR(SesionAIRId,
												AsambleistaId,
												Asistio,
												Validacion)
					SELECT @SesionAIRId,
							@AsambleistaId,
							@Asistio,
							1;
					SELECT @@Identity Id;
				END
			ELSE
				BEGIN
					UPDATE dbo.RegistroAsistenciaAIR
					SET Asistio = @Asistio,
						Validacion = 1
					WHERE SesionAIRId = @SesionAIRId
					SELECT 0
				END
		COMMIT TRANSACTION nuevaAsistenciaAIR;
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
		SELECT R.Id,A.Nombre,A.Cedula,R.Asistio
		FROM dbo.RegistroAsistenciaAIR R
		INNER JOIN dbo.Asambleista A ON R.AsambleistaId = A.Id
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
	@SesionAIRId INT,
	@Cedula NVARCHAR(16),
	@Asistio BIT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION modificarAsistenciaAIR
			DECLARE @AsambleistaId INT
			SELECT @AsambleistaId = A.Id
			FROM dbo.Asambleista A
			WHERE A.Cedula = @Cedula
			
			UPDATE dbo.RegistroAsistenciaAIR
			SET Asistio = @Asistio
			WHERE AsambleistaId = @AsambleistaId AND SesionAIRId = SesionAIRId
		COMMIT TRANSACTION modificarAsistenciaAIR;
		SELECT 1;
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

IF OBJECT_ID('[dbo].[NuevoRegistroAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[NuevoRegistroAIR] 
END 
GO
CREATE PROC [dbo].[NuevoRegistroAIR]
	@SesionId INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION modificarAsistenciaAIR
			UPDATE dbo.RegistroAsistenciaAIR
			SET Validacion = 0
			WHERE SesionAIRId = @SesionId
		COMMIT TRANSACTION modificarAsistenciaAIR;
		SELECT 1;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION modificarAsistenciaAIR;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO