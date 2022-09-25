USE [ProyectoDAIR];
GO

IF OBJECT_ID('[dbo].[CreatePadron]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[CreatePadron] 
END 
GO
CREATE PROC [dbo].[CreatePadron] 
	@Cedula INT,
	@Periodo INT, 
	@Validacion BIT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION nuevoPadron
			IF EXISTS (SELECT Id FROM dbo.Asambleista WHERE Cedula = @Cedula)
				BEGIN
					DECLARE @Asambleista INT
					SELECT @Asambleista = A.Id
					FROM dbo.Asambleista A
					WHERE A.Cedula = @Cedula
					INSERT INTO dbo.Padron(AsambleistaId,
											PeriodoId,
											Validacion)
					SELECT @Asambleista,
							@Periodo,
							@Validacion;
					
					SELECT @@Identity Id;
				END
			ELSE
				BEGIN
					SELECT 0;
				END
		COMMIT TRANSACTION nuevoPadron;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION nuevoPadron;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[ReadPadron]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ReadPadron] 
END 
GO
CREATE PROC [dbo].[ReadPadron] 
    @Id INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SELECT A.Nombre, A.Cedula, D.Nombre
		FROM dbo.Padron Pa
		INNER JOIN dbo.Asambleista A ON A.Id = Pa.AsambleistaId
		INNER JOIN dbo.Departamento D ON D.Id = A.DepartamentoId
		WHERE Pa.[Id] = @Id AND Pa.Validacion = 1
	END TRY

	BEGIN CATCH
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[UpdatePadron]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[UpdatePadron] 
END 
GO
CREATE PROC [dbo].[UpdatePadron]
	@AsambleistaId INT,
	@Validacion BIT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION modificarPadron
			UPDATE dbo.Padron
			SET Validacion = @Validacion
			WHERE AsambleistaId = @AsambleistaId
		COMMIT TRANSACTION modificarPadron;
		SELECT 1;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION modificarPadron;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[NuevoPeriodo]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[NuevoPeriodo] 
END 
GO
CREATE PROC [dbo].[NuevoPeriodo]
	@PeriodoId INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION modificarPadron
			UPDATE dbo.Padron
			SET Validacion = 0
			WHERE PeriodoId = @PeriodoId
		COMMIT TRANSACTION modificarPadron;
		SELECT 1;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION modificarPadron;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[GetPadron]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GetPadron] 
END 
GO
CREATE PROC [dbo].[GetPadron] 
    @PeriodoId INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SELECT A.Nombre, A.Cedula, D.Nombre AS Departamento
		FROM dbo.Padron Pa
		INNER JOIN dbo.Asambleista A ON A.Id = Pa.AsambleistaId
		INNER JOIN dbo.Departamento D ON D.Id = A.DepartamentoId
		WHERE Pa.[PeriodoId] = @PeriodoId AND Pa.Validacion = 1
	END TRY

	BEGIN CATCH
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO