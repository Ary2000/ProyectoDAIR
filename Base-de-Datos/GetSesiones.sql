USE [ProyectoDAIR];
GO

IF OBJECT_ID('[dbo].[GetSesionesAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GetSesionesAIR] 
END 
GO
CREATE PROC [dbo].[GetSesionesAIR] 
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SELECT P.AnioInicio,P.AnioFin,S.Nombre,S.Fecha
		FROM dbo.SesionAIR S
		INNER JOIN dbo.Periodo P ON P.Id = S.PeriodoId
	END TRY

	BEGIN CATCH
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO


IF OBJECT_ID('[dbo].[GetSesionesDAIR]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GetSesionesDAIR] 
END 
GO
CREATE PROC [dbo].[GetSesionesDAIR] 
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		SELECT P.AnioInicio,P.AnioFin,S.Nombre,S.Fecha
		FROM dbo.SesionDAIR S
		INNER JOIN dbo.Periodo P ON P.Id = S.PeriodoId
	END TRY

	BEGIN CATCH
		SELECT -1
	END CATCH
SET NOCOUNT OFF
END
GO