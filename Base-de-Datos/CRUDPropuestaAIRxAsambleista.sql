USE [ProyectoDAIR];
GO

IF OBJECT_ID('[dbo].[CreateProponente]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[CreateProponente] 
END 
GO
CREATE PROC [dbo].[CreateProponente] 
	@AsambleistaId INT,
	@PropuestaAIRId INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION nuevaProponente
			INSERT INTO dbo.PropuestaAIRxAsambleista(AsambleistaId,
										PropuestaAIRId,
										Validaion)
			SELECT @AsambleistaId,
					@PropuestaAIRId,
					1;
		COMMIT TRANSACTION nuevaProponente;
		SELECT @@Identity Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION nuevaProponente;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[ReadProponente]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ReadProponente] 
END 
GO
CREATE PROC [dbo].[ReadProponente] 
    @Id INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SELECT A.Nombre,P.Nombre,PxA.Validaion
		FROM dbo.PropuestaAIRxAsambleista PxA
		INNER JOIN dbo.Asambleista A ON PxA.AsambleistaId = A.Id
		INNER JOIN dbo.PropuestaAIR P ON PxA.PropuestaAIRId = P.Id
		WHERE PxA.[Id] = @Id
	END TRY

	BEGIN CATCH
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[UpdateProponente]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[UpdateProponente] 
END 
GO
CREATE PROC [dbo].[UpdateProponente]
	@Id INT,
	@AsambleistaId INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION modificarProponente
			UPDATE dbo.PropuestaAIRxAsambleista
			SET AsambleistaId = @AsambleistaId
			WHERE Id = @Id
		COMMIT TRANSACTION modificarProponente;
		SELECT @Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION modificarProponente;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[DeleteProponente]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[DeleteProponente] 
END 
GO
CREATE PROC [dbo].[DeleteProponente]
	@Id INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION eliminarProponente
			UPDATE dbo.PropuestaAIRxAsambleista
			SET Validaion = 0
			WHERE Id = @Id
		COMMIT TRANSACTION eliminarProponente;
		SELECT @Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION eliminarProponente;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO