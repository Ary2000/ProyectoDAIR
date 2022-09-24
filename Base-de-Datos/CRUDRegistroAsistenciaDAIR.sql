USE [ProyectoDAIR];
GO

IF OBJECT_ID('[dbo].[CreateAsistenciaDAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[CreateAsistenciaDAIR] 
END 
GO
CREATE PROC [dbo].[CreateAsistenciaDAIR] 
	@SesionDAIRId INT,
	@AsambleistaId INT,
	@Asistio BIT,
	@Validacion BIT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION nuevaAsistenciaDAIR
			INSERT INTO dbo.RegistroAsistenciaDAIR(SesionDAIRId,
										AsambleistaId,
										Asistio,
										Validacion)
			SELECT @SesionDAIRId,
					@AsambleistaId,
					@Asistio,
					@Validacion;
		COMMIT TRANSACTION nuevaAsistenciaDAIR;
		SELECT @@Identity Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION nuevaAsistenciaDAIR;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[ReadAsistenciaDAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ReadAsistenciaDAIR] 
END 
GO
CREATE PROC [dbo].[ReadAsistenciaDAIR] 
    @Id INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SELECT A.Nombre,S.Nombre,R.Asistio
		FROM dbo.RegistroAsistenciaDAIR R
		INNER JOIN dbo.Asambleista A ON R.AsambleistaId = A.Id
		INNER JOIN dbo.SesionDAIR S ON R.SesionDAIRId = S.Id
		WHERE R.[Id] = @Id
	END TRY

	BEGIN CATCH
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[UpdateAsistenciaDAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[UpdateAsistenciaDAIR] 
END 
GO
CREATE PROC [dbo].[UpdateAsistenciaDAIR]
	@Id INT,
	@Asistio BIT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION modificarAsistenciaDAIR
			UPDATE dbo.RegistroAsistenciaDAIR
			SET Asistio = @Asistio
			WHERE Id = @Id
		COMMIT TRANSACTION modificarAsistenciaDAIR;
		SELECT @Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION modificarAsistenciaDAIR;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[DeleteAsistenciaDAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteAsistenciaDAIR] 
END 
GO
CREATE PROC [dbo].[DeleteAsistenciaDAIR]
	@Id INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION eliminarAsistenciaDAIR
			UPDATE dbo.RegistroAsistenciaDAIR
			SET Asistio = 0
			WHERE Id = @Id
		COMMIT TRANSACTION eliminarAsistenciaDAIR;
		SELECT @Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION eliminarAsistenciaDAIR;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO