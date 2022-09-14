USE [ProyectoDAIR];
GO

IF OBJECT_ID('[dbo].[CreateDepartamento]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[CreateDepartamento] 
END 
GO
CREATE PROC [dbo].[CreateDepartamento] 
	@Nombre NVARCHAR(32)
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION nuevoDepartamento
			INSERT INTO dbo.Departamento(Nombre)
			SELECT @Nombre;
		COMMIT TRANSACTION nuevoDepartamento;
		SELECT @@Identity Id;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION nuevoDepartamento;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[ReadDepartamento]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ReadDepartamento] 
END 
GO
CREATE PROC [dbo].[ReadDepartamento] 
    @Id INT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SELECT Nombre
		FROM dbo.Departamento
		WHERE [Id] = @Id
	END TRY

	BEGIN CATCH
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO

IF OBJECT_ID('[dbo].[UpdateDepartamento]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[UpdateDepartamento] 
END 
GO
CREATE PROC [dbo].[UpdateDepartamento]
	@Id INT,
	@Nombre NVARCHAR(32)
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
		BEGIN TRANSACTION modificarDepartamento
			UPDATE dbo.Departamento
			SET Nombre = @Nombre
			WHERE Id = @Id
		COMMIT TRANSACTION modificarDepartamento;
		SELECT 1;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION modificarDepartamento;
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO