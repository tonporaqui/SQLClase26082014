use ejemplo;

CREATE TABLE PRODUCTO(
	CODIGOPRODUCTO INT PRIMARY KEY,
	NOMBREPRODUCTO VARCHAR(100) NOT NULL,
	PRECIONETO NUMERIC(12) NOT NULL
)

CREATE PROCEDURE Sp_insertarProductos @codpro int,
				      @nompro varchar(100),
				      @precioneto numeric(12)
AS
BEGIN
	INSERT INTO PRODUCTO(CODIGOPRODUCTO,NOMBREPRODUCTO,PRECIONETO)	
	VALUES(@codpro,@nompro,@precioneto)
	IF @@ERROR <> 0
		PRINT 'PRODUCTO CREADO'
END				

exec Sp_insertarProductos 1,'VENTANAS',100
exec Sp_insertarProductos 2,'PUERTAS',200
exec Sp_insertarProductos 3,'TEJAS',350

CREATE PROCEDURE SP_ActualizaProducto @codpro int,
				      @nompro varchar(100),
				      @precioneto numeric(12)
AS
BEGIN
	UPDATE PRODUCTO
	SET NOMBREPRODUCTO = @nompro, PRECIONETO = @precioneto
	WHERE CODIGOPRODUCTO = @codpro
END

EXEC SP_ActualizaProducto 1,'PUERTA',200

CREATE PROCEDURE SP_BOORARPRODUCTO @CODPRO INT
AS
BEGIN 
	DELETE PRODUCTO
	where CODIGOPRODUCTO = @CODPRO
END

exec SP_BOORARPRODUCTO 1

CREATE PROCEDURE SP_SELECTALLPRODUCTO
AS
BEGIN 
		SELECT * FROM PRODUCTO
END

EXEC SP_SELECTALLPRODUCTO

CREATE PROCEDURE SP_SelectCodProducto @codpro int
AS
BEGIN
	SELECT * FROM PRODUCTO WHERE CODIGOPRODUCTO = @codpro
	IF @@ERROR = 0
		PRINT 'NO ENCONTRO NAITE'
END

EXEC SP_SelectCodProducto 5
