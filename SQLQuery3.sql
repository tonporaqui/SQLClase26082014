USE ejemplo;

ALTER PROCEDURE SP_INSERTCLIENTE @rut varchar(12),
								 @nom varchar(50),
								 @fechnacimiento date
AS
BEGIN
BEGIN TRY
	IF EXISTS (SELECT RUT FROM CLIENTE WHERE RUT = @rut)
		BEGIN 
			UPDATE CLIENTE SET NOMBRES = @nom, FECHANACIMIENTO = @fechnacimiento
			WHERE RUT = @rut
			IF @@ERROR = 0
				PRINT 'CLIENTE ACTUALIZADO'
		END
	ELSE
		BEGIN
			INSERT INTO CLIENTE (RUT,NOMBRES,FECHANACIMIENTO)
			VALUES(@rut,@nom,@fechnacimiento)
			IF @@ERROR = 0
				PRINT 'CLIENTE INSERTADO'
		END
END TRY
BEGIN CATCH
	PRINT 'ERROR EN LA TRANSACCION'
END CATCH
END

EXEC SP_INSERTCLIENTE '2-5','PEPITO','20140808'
						
						
CREATE PROCEDURE SP_SELECTALL
AS 
BEGIN
	SELECT * FROM CLIENTE	
END		  

EXEC SP_SELECTALL